#! /bin/bash
set -e
cd /tf/caf

# This script is caller by the rover boostrap
# It also supports a direct call of sub-function for maintainers
# to call only the launchpad
# ./deploy_platform.sh --function launchpad
# other options are gitops_agents credentials pr

function bootstrap {

  # check if the /tf/caf/platform folder exist
  PLATFORM_FOLDER="/tf/caf/platform"

  if [[ -d "$PLATFORM_FOLDER" ]]; then
    echo "$PLATFORM_FOLDER exists in your current configuration. You need to delete first and restart the boostrap process."
    exit
  else
    caf_landingzone_branch=$(cd /tf/caf/landingzones && git branch --show-current)
    echo "efault tem"
    read -p "Press Enter to continue to generate the definition files from Ansible template ..."

    ansible-playbook /tf/caf/landingzones/templates/ansible/walk-through-bootstrap.yaml \
      -e public_templates_folder=/tf/caf/landingzones/templates \
      -e topology_file=${topology_file:='/tf/caf/landingzones/templates/platform/caf_platform_prod_nonprod.yaml'} \
      -e landingzones_folder=/tf/caf/landingzones \
      -e platform_configuration_folder=/tf/caf/configuration \
      -e platform_definition_folder=$PLATFORM_FOLDER/definition \
      -e platform_template_folder=$PLATFORM_FOLDER/template \
      -e template_folder=/tf/caf/landingzones/templates/platform \
      -e firewall_rules_path=$PLATFORM_FOLDER/firewall_rules \
      -e keyvault_enable_rbac_authorization=true \
      -e keyvault_purge_protection_enabled=false \
      -e private_endpoints=true \
      -e rover_bootstrap=true \
      -e caf_landingzone_branch=${caf_landingzone_branch} \
      --extra-vars "@${bootstrap_variables:="/tf/caf/landingzones/templates/platform/ignite.yaml"}" \
      -e $(echo ${params} | xargs)

    # Generate initial configuration
    read -p "Press Enter to continue to generate the configuration files from Ansible definition files ..."

    ansible-playbook $(readlink -f ./landingzones/templates/ansible/ansible.yaml) \
      --extra-vars "@$(readlink -f ./platform/definition/ignite.yaml)" \
      -e topology_file="$(readlink -f ./platform/definition/ignite.yaml)" \
      -e base_folder=$(pwd)
  fi
}

function launchpad {

  check_environment_variable

  read -p "Press Enter to continue to deploy the launchpad configuration with Rover ..."

  /tf/rover/rover.sh \
    -lz /tf/caf/landingzones/caf_launchpad \
    -var-folder /tf/caf/platform/configuration/level0/launchpad \
    -tfstate_subscription_id ${sub_management} \
    -target_subscription ${sub_management} \
    -tfstate caf_launchpad.tfstate \
    -launchpad \
    -env ${TF_VAR_environment} \
    -level level0 \
    -parallelism=50 \
    -a apply

  # Need to logout and login to get the new group memberships
  tenant_id=$(az account show --query tenantId -o tsv)
  az account clear

  /tf/rover/rover.sh login -t ${tenant_id} -s ${sub_management}

}

function gitops_agents() {

  check_environment_variable

  /tf/rover/rover.sh \
    -lz /tf/caf/landingzones/caf_solution \
    -var-folder /tf/caf/platform/configuration/level0/gitops_agents \
    -tfstate_subscription_id ${sub_management} \
    -target_subscription ${sub_management} \
    -tfstate gitops_agents.tfstate \
    -env ${TF_VAR_environment} \
    -level level0 \
    -a apply

}

function gitops_agents_aca()
{ 
  set +e
  echo "Getting resources from CAF environment ${TF_VAR_environment}"

  resource_group_obj=$(az graph query -q \
  "ResourceContainers | where type =~ 'microsoft.resources/subscriptions/resourcegroups' | where ( tags['environment']=='${TF_VAR_environment}' or tags['caf_environment']=='${TF_VAR_environment}' ) and name contains_cs 'gitops-agents' | project name, location, subscriptionId" --query "data" -o json  | jq -r '.[]')

  resource_group=$(echo ${resource_group_obj} | jq -r .name)
  location=$(echo ${resource_group_obj} | jq -r .location)

  ROVER_AGENT_TAG=${ROVER_AGENT_VERSION:="1.2"}
  ROVER_AGENT_DOCKER_IMAGE=$(curl -s https://hub.docker.com/v2/repositories/aztfmod/rover-agent/tags | jq -r ".results | sort_by(.tag_last_pushed) | reverse  | map(select(.name | contains(\"${gitops_agent}\") ) | select(.name | contains(\"${ROVER_AGENT_TAG}\") ) ) | .[0].name")

  
  aca_env_name="rover-platform-landingzones"
  aca_env_id=$(az containerapp env list --resource-group ${resource_group} --query "[0].id" -o tsv)

  if [ -v ${aca_env_id} ]; then

    vnet_name=$(az network vnet list --resource-group ${resource_group} --query "[0].name" -o tsv)
    infrastructure_subnet_id=$(az network vnet subnet list --vnet-name ${vnet_name} --resource-group ${resource_group} --query "[?contains(name, 'runners')].id" -o tsv)
 
    echo "Create Azure container app environment... please wait..."
    aca_env_id=$(az containerapp env create \
      --name ${aca_env_name} \
      --resource-group ${resource_group} \
      --zone-redundant \
      --internal-only true \
      --infrastructure-subnet-resource-id ${infrastructure_subnet_id} \
      -o tsv --query id)

    sleep 120

  else
    echo "Azure container apps environment: ${aca_env_id}"
  fi

  aca_name="rover-platform"

  acr_obj=$(az acr list --resource-group ${resource_group} --query "[0]" -o json)
  acr_name=$(echo ${acr_obj} | jq -r .name)
  registry_server=$(echo ${acr_obj} | jq -r .loginServer)

  acr_credential_obj=$(az acr credential show --name ${acr_name} --resource-group ${resource_group} -o json)
  registry_username=$(echo ${acr_credential_obj} | jq -r .username)
  registry_password=$(echo ${acr_credential_obj} | jq -r '.passwords[0].value')

  msi_id=$(az identity list --resource-group ${resource_group} --query "[0].id" -o tsv)

  docker_image="rover-agent:${ROVER_AGENT_DOCKER_IMAGE}"
  target_image_tag="caf/${docker_image}"

  stg_name=$(az storage account list --resource-group ${resource_group} --query "[0].name" -o tsv)
  stg_key=$(az storage account keys list --account-name ${stg_name} --resource-group ${resource_group} --query "[0].value" -o tsv)
  queue_conn_string=$(az storage account show-connection-string --name ${stg_name} --resource-group ${resource_group} --query "connectionString" -o tsv)
  queue_name=$(az storage queue list --account-name ${stg_name} --auth-mode login --query "[0].name" -o tsv)
  queue_account_name="${stg_name}"
  
  gh_token=${GH_TOKEN}
  gh_owner="LaurentLesle"
  gh_repository="a20"


  image=$(az acr repository show --name ${acr_name} --image  ${target_image_tag} --query name -o tsv 2&>/dev/null)
  echo ${image}
  if [ "${image}" = "" ]; then
    echo "Importing rover agent image ${docker_image} into Azure container registry into ${target_image_tag} ."
    az acr import \
      --name ${acr_name} \
      --source docker.io/aztfmod/${docker_image} \
      --image ${target_image_tag}
  fi

  cp ./landingzones/templates/pipelines/.github/aca/runners.yaml /tf/caf/.github/runners.yaml
  yaml_file="/tf/caf/.github/runners.yaml"

  echo "resource_group: $resource_group" && sed -i "s/#resource_group#/$resource_group/g" $yaml_file
  echo "location: $location" && sed -i "s/#location#/$location/g" $yaml_file
  echo "aca_env_id: $aca_env_id" && sed -i "s|#aca_env_id#|$aca_env_id|g" $yaml_file
  echo "aca_name: $aca_name" && sed -i "s/#aca_name#/$aca_name/g" $yaml_file
  echo "gh_token: *****" && sed -i "s/#gh_token#/$gh_token/g" $yaml_file
  echo "registry_server: $registry_server" && sed -i "s/#registry_server#/$registry_server/g" $yaml_file
  echo "registry_password: ******" && sed -i "s|#registry_password#|$registry_password|g" $yaml_file
  echo "registry_username: $registry_username" && sed -i "s/#registry_username#/$registry_username/g" $yaml_file
  echo "target_image_tag: $target_image_tag" && sed -i "s|#target_image_tag#|$target_image_tag|g" $yaml_file
  echo "queue_conn_string: $queue_conn_string" && sed -i "s|#queue_conn_string#|$queue_conn_string|g" $yaml_file
  echo "queue_name: $queue_name" && sed -i "s/#queue_name#/$queue_name/g" $yaml_file
  echo "queue_account_name: $queue_account_name" && sed -i "s/#queue_account_name#/$queue_account_name/g" $yaml_file
  echo "gh_owner: $gh_owner" && sed -i "s/#gh_owner#/$gh_owner/g" $yaml_file
  echo "gh_repository: $gh_repository" && sed -i "s/#gh_repository#/$gh_repository/g" $yaml_file

  aca_obj=$(az containerapp list --resource-group ${resource_group})
  
  if [ "${aca_obj}" = "[]" ]; then

    echo "\nCreate Azure container app for rover agents...\n"
    az containerapp create \
      --name ${aca_name} \
      --resource-group ${resource_group} \
      --environment ${aca_env_id} \
      --yaml $yaml_file

  else
    echo "Updating Azure container app for rover agents...\n"
    az containerapp update \
      --name ${aca_name} \
      --resource-group ${resource_group} \
      --yaml $yaml_file
  fi

}

function credentials() {

  check_environment_variable

  read -p "Press Enter to continue to deploy the credentials configuration with Rover."

  /tf/rover/rover.sh \
    -lz /tf/caf/landingzones/caf_solution \
    -var-folder /tf/caf/platform/configuration/level0/credentials \
    -tfstate_subscription_id ${sub_management} \
    -target_subscription ${sub_management} \
    -tfstate launchpad_credentials.tfstate \
    -env ${TF_VAR_environment} \
    -level level0 \
    -a apply

  if [ $? != 0 ]; then
    echo "Fix the errors and restart the rover bootstrap"
    exit
  fi
}

function check_environment_variable() {

  if [ -v ${TF_VAR_environment} ];then 
    echo "TF_VAR_environment must be set first" && exit
  elif [ -v ${sub_management} ]; then
    echo "sub_management not set." && exit
  fi

}

function pr {
  cd /tf/caf

  if [ "${gitops_agent}" == "github" ]; then
    git add ./.github/**
    git add ./getting-started/**
    git commit -m "Adding Github workflows"
    git push
  fi

  git config user.name "CAF Rover Actions Bot"
  git config user.email "caf-rover-actions@github.com"

  if [ "$(gh pr status --json id | jq .currentBranch.id)" = "null" ]; then
    git checkout -b bootstrap
    git push --set-upstream origin bootstrap
    git checkout -b setup
    git add .
    pre-commit
    git commit -am "Update definition files."
    git push --set-upstream origin setup
body=<<EOF
    Definition folder with the initial templates for:
    - launchpad (only for azurerm backend type)
    - credentials
    - self-hosted agents
EOF
    /usr/bin/gh pr create \
      --assignee "@me" \
      --title "Setup the foundation services for Azure landing zones" \
      --body "${body}" \
      --base bootstrap \
      --head setup
  else
    git checkout bootstrap
    git add .
    git commit -am "Initial definition files."
    git push origin
  fi
}


export ANSIBLE_DISPLAY_SKIPPED_HOSTS=False 

while [ $# -gt 0 ]; do
  echo $1
  if [[ $1 == *"--"* ]]; then
    param="${1/--/}"
    declare $param="$2"
    # echo $1 $2 // Optional to see the parameter:value result
    $2
    exit
  else
    # make all the parameters available in this script
    IFS='=' read -r left right <<< $1
    declare $left="$right"
    params+="-e $1 "
  fi
  shift

done

echo ${params} | xargs
echo "sub_management: ${sub_management}"
echo "gitops_agent: ${gitops_agent}"
echo "subscription_deployment_mode: ${subscription_deployment_mode}"

bootstrap
launchpad
# gitops_agents_aca
# gitops_agents
credentials
# pr
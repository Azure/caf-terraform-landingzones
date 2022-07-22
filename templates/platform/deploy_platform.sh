#! /bin/bash
set -e
cd /tf/caf

# This script is caller by the rover boostrap
# It also supports a direct call of sub-function for maintainers
# to call only the launchpad
# ./deploy_platform.sh --function launchpad
# other options are gitops_agents credentials pr

function bootstrap {

  ansible-playbook /tf/caf/landingzones/templates/ansible/walk-through-bootstrap.yaml \
    -e public_templates_folder=/tf/caf/landingzones/templates \
    -e bootstrap_playbook=${topology_file:='/tf/caf/landingzones/templates/platform/caf_platform_prod_nonprod.yaml'} \
    -e landingzones_folder=/tf/caf/landingzones \
    -e platform_configuration_folder=/tf/caf/configuration \
    -e platform_definition_folder=/tf/caf/platform/definition \
    -e platform_template_folder=/tf/caf/platform/template \
    -e template_folder=/tf/caf/landingzones/templates/platform \
    -e firewall_rules_path=/tf/caf/platform/firewall_rules \
    -e keyvault_enable_rbac_authorization=true \
    -e keyvault_purge_protection_enabled=false \
    -e private_endpoints=true \
    -e caf_landingzone_branch="$(cd /tf/caf/landingzones && git rev-parse --abbrev-ref HEAD)" \
    --extra-vars "@/tf/caf/landingzones/templates/platform/ignite.yaml" \
    -e $(echo ${params} | xargs)

  # Generate initial configuration
  ansible-playbook $(readlink -f ./landingzones/templates/ansible/ansible.yaml) \
    --extra-vars "@$(readlink -f ./platform/definition/ignite.yaml)" \
    -e base_folder=$(pwd)
}

function launchpad {

  check_environment_variable

  /tf/rover/rover.sh \
    -lz /tf/caf/landingzones/caf_launchpad \
    -var-folder /tf/caf/platform/configuration/level0/launchpad \
    -tfstate_subscription_id ${sub_management} \
    -target_subscription ${sub_management} \
    -tfstate caf_launchpad.tfstate \
    -launchpad \
    -env ${TF_VAR_environment} \
    -level level0 \
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

function credentials() {

  check_environment_variable
  
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

  if [ "$(gh pr status --json id | jq .currentBranch.id)" = "null" ]; then
    git fetch origin main 
    git checkout -b bootstrap --track origin/main
    git branch --set-upstream-to origin/bootstrap bootstrap
    git push
    git checkout -b setup
    git branch --set-upstream-to origin/setup setup
    git add .
    pre-commit
    git commit -am "Update definition files."
    git push
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
      --head setup \
      -R ${GITHUB_SERVER_URL}/${GITHUB_REPOSITORY}
  else
    git checkout bootstrap
    git add .
    git commit -am "Initial definition files."
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
    params+="-e $1 "
  fi
  shift

done

echo $params
echo ${params} | xargs
echo "sub_management: ${sub_management}"

bootstrap
launchpad
gitops_agents
credentials
pr
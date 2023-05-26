#! /bin/bash
set -e
cd /tf/caf

export ANSIBLE_DISPLAY_SKIPPED_HOSTS=False 

params=$(echo ${@} | xargs -n1 | xargs -I@ echo "-e @ " )

echo ${params} | xargs
echo "sub_management: ${sub_management}"

ansible-playbook /tf/caf/landingzones/templates/ansible/walk-through-bootstrap.yaml \
  -e public_templates_folder=/tf/caf/landingzones/templates \
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

/tf/rover/rover.sh \
  -lz /tf/caf/landingzones/caf_solution \
  -var-folder /tf/caf/platform/configuration/level0/gitops_agents \
  -tfstate_subscription_id ${sub_management} \
  -target_subscription ${sub_management} \
  -tfstate gitops_agents.tfstate \
  -env ${TF_VAR_environment} \
  -level level0 \
  -a apply

/tf/rover/rover.sh \
  -lz /tf/caf/landingzones/caf_solution \
  -var-folder /tf/caf/platform/configuration/level0/credentials \
  -tfstate_subscription_id ${sub_management} \
  -target_subscription ${sub_management} \
  -tfstate launchpad_credentials.tfstate \
  -env ${TF_VAR_environment} \
  -level level0 \
  -a apply

if [ $? = 0 ]; then

  cd /tf/caf

  if [ "$(gh pr status --json id | jq .currentBranch.id)" = "null" ]; then
    git fetch origin main
    git checkout -b bootstrap --track origin/main
    git add .
    pre-commit
    git commit -am "Update definition files."
    git push origin HEAD
        # Create the initial PR for the bootstrap configuration
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
      --base main \
      -R ${GITHUB_SERVER_URL}/${GITHUB_REPOSITORY}
  else
    git checkout bootstrap
    git add .
    git commit -am "Initial definition files."
    git add .
    git commit -am "Initial definition files."
    git push origin
  fi


else
  echo "Fix the errors and restart the rover bootstrap"
fi


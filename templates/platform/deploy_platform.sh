#! /bin/bash

cd /tf/caf

export ANSIBLE_DISPLAY_SKIPPED_HOSTS=False 

params=$(echo ${@} | xargs -n1 | xargs -I@ echo "-e @ " )

echo ${params} | xargs

ansible-playbook /tf/caf/landingzones/templates/ansible/walk-through-single.yaml \
  -e topology_file=/tf/caf/landingzones/templates/platform/single_subscription.yaml \
  -e public_templates_folder=/tf/caf/landingzones/templates \
  -e landingzones_folder=/tf/caf/landingzones \
  -e platform_configuration_folder=/tf/caf/configuration \
  -e platform_definition_folder=/tf/caf/platform/definition \
  -e platform_template_folder=/tf/caf/platform/template \
  -e firewall_rules_path=/tf/caf/platform/firewall_rules \
  -e keyvault_enable_rbac_authorization=true \
  -e keyvault_purge_protection_enabled=false \
  -e subscription_deployment_mode=single_reuse \
  -e caf_landingzone_branch="$(cd /tf/caf/landingzones && git rev-parse --abbrev-ref HEAD)" \
  --extra-vars "@/tf/caf/landingzones/templates/platform/bootstrap.yaml" \
  -e $(echo ${params} | xargs)

if [ $? = 0 ]; then


  # ansible-playbook $(readlink -f ./landingzones/templates/ansible/ansible.yaml) \
  #   --extra-vars "@$(readlink -f ./platform/definition/ignite.yaml)"

  cd /tf/caf

  if [ "$(gh pr status --json id | jq .currentBranch.id)" = "null" ]; then
    git fetch origin main
    git checkout -b bootstrap --track origin/main
    git add .
    pre-commit
    git commit -am "Update definition files."
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
  fi

  git push

else
  echo "Fix the errors and restart the rover bootstrap"
fi


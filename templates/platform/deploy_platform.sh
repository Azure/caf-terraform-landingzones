#! /bin/bash


export ANSIBLE_DISPLAY_SKIPPED_HOSTS=False 

params=$(echo ${@} | xargs -n1 | xargs -I@ echo "-e @ " )

ansible-playbook /tf/caf/landingzones/templates/ansible/walk-through-single.yaml \
  -e topology_file=/tf/caf/landingzones/templates/platform/single_subscription.yaml \
  -e public_templates_folder=/tf/caf/landingzones/templates \
  -e landingzones_folder=/tf/caf/landingzones \
  -e platform_configuration_folder=/tf/caf/configuration \
  -e platform_definition_folder=/tf/caf/platform/definition \
  -e platform_template_folder=/tf/caf/platform/template \
  -e caf_landingzone_branch='2204.1.int' \
  --extra-vars "@/tf/caf/landingzones/templates/platform/template_topology.yaml" \
  -e $(echo ${params} | xargs)

# Create the initial PR for the bootstrap configuration
body=<<EOF
    Definition folder with the initial templates for:
     - launchpad (only for azurerm backend type)
     - credentials
     - self-hosted agents
EOF

cd /tf/caf

if [ "$(gh pr status --json id | jq .currentBranch.id)" = "null" ]; then
  git checkout -b bootstrap
  git add .
  git commit -am "Update definition files."
  /usr/bin/gh pr create \
    --assignee "@me" \
    --title "Setup the foundation services for Azure landing zones" \
    --body "${body}" \
    -R ${GITHUB_SERVER_URL}/${GITHUB_REPOSITORY}
else
  git checkout bootstrap
  git add .
  git commit -am "Initial definition files."
  git add .
  git commit -am "Initial definition files."
fi

git push
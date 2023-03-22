#! /bin/bash

echo -n "Name of the landingzone group definition (no spaces) to create: "
read -r landingzone_definition

export ANSIBLE_DISPLAY_SKIPPED_HOSTS=False

ansible-playbook /tf/caf/landingzones/templates/asvm/orion/walk-through.yaml \
  -e topology_folder=/tf/caf/landingzones/templates/asvm/orion \
  -e public_templates_folder=/tf/caf/landingzones/templates \
  -e landingzones_folder=/tf/caf/landingzones \
  -e template_folder=/tf/caf/asvm/${landingzone_definition}/template \
  -e definition_folder=/tf/caf/asvm/${landingzone_definition}/definition \
  -e platform_configuration_folder=/tf/caf/configuration \
  -e platform_definition_folder=/tf/caf/platform/definition \
  -e deployment_mode=asvm \
  --extra-vars landingzone_definition=${landingzone_definition}
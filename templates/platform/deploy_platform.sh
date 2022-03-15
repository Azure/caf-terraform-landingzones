#! /bin/bash

export ANSIBLE_DISPLAY_SKIPPED_HOSTS=False

ansible-playbook /tf/caf/landingzones/templates/ansible/walk-through-single.yaml \
  -e topology_file=/tf/caf/landingzones/templates/platform/single_subscription.yaml \
  -e public_templates_folder=/tf/caf/landingzones/templates \
  -e landingzones_folder=/tf/caf/landingzones \
  -e platform_configuration_folder=/tf/caf/configuration \
  -e platform_definition_folder=/tf/caf/platform/definition \
  -e platform_template_folder=/tf/caf/platform/template \
  --extra-vars "@/tf/caf/landingzones/templates/platform/template_topology.yaml"


# Generate the terraform configuration files

## Deploy into a single subscription

```
ansible-playbook /tf/caf/landingzones/templates/ansible/walk-through-single.yaml \
  -e topology_file=/tf/caf/landingzones/templates/platform/single_subscription.yaml \
  -e config_folder_platform_templates=/tf/caf/landingzones/templates/platform \
  -e platform_service_folder=/tf/caf/landingzones/templates/platform/services \
  -e public_templates_folder=/tf/caf/landingzones/templates \
  -e resource_template_folder=/tf/caf/landingzones/templates/resources \
  -e landingzones_folder=/tf/caf/landingzones \
  -e platform_configuration_folder=/tf/caf/configuration \
  -e platform_definition_folder=/tf/caf/platform/definition

```


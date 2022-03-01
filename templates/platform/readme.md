
# Generate the terraform configuration files

## Deploy in a single subscription

```
ansible-playbook /tf/caf/landingzones/templates/platform/walk-through-single.yaml \
  -e topology_file=/tf/caf/landingzones/templates/platform/single_subscription.yaml \
  -e config_folder_platform_templates=/tf/caf/landingzones/templates/platform \
  -e platform_service_folder=/tf/caf/landingzones/templates/platform/services \
  -e landingzones_folder=/tf/caf/landingzones \
  -e configuration_folder=/tf/caf/configuration/platform \
  -e destination_folder=/tf/caf/definition/platform

```


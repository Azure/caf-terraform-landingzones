# Cloud Adoption Framework landing zones for Terraform - Starter template for Azure Subscription Vending Machine (ASVM)

## Generate the configuration files

```bash

rover ignite \
  --playbook /tf/caf/landingzones/templates/platform/ansible.yaml \
  -e base_templates_folder=/tf/caf/landingzones/templates/platform \
  -e resource_template_folder=/tf/caf/landingzones/templates/resources \
  -e config_folder=/tf/caf/definitions/asvm/orion-landingzone \
  -e config_folder_platform=/tf/caf/definitions/single_subscription \
  -e landingzones_folder=/tf/caf/landingzones


```
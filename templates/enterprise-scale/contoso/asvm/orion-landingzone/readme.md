# Cloud Adoption Framework landing zones for Terraform - Starter template for Azure Subscription Vending Machine (ASVM)

## Generate the configuration files

```bash
rover ignite \
  --playbook /tf/caf/landingzones/templates/applications/ansible.yaml \
  -e base_templates_folder=/tf/caf/landingzones/templates/applications \
  -e resource_template_folder=/tf/caf/landingzones/templates/resources \
  -e destination_base_path=/tf/caf/configuration/contoso/landingzones/<replace> \
  -e config_folder=/tf/caf/platform-definition/application/<replace> \
  -e config_folder_platform=/tf/caf/platform-definition

```
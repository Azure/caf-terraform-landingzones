# Cloud Adoption Framework landing zones for Terraform - Starter template for Azure Subscription Vending Machine (ASVM)

## Generate the definition files

Note: This script will generate the definition files from your templates

```bash
# Execute this script from the /tf/caf folder.

ansible-playbook {{public_templates_folder}}/ansible/asvm_definition.yaml \
  --extra-vars "@{{template_folder}}/ignite.yaml" \
  -e base_folder=$(pwd)

```

### Regenerate the template

Note: This playbook will override the customization you have performed in your {{platform_configuration_folder}} folder and redeploy the original version from the public library.


```bash
ansible-playbook {{public_templates_folder}}/asvm/orion/walk-through.yaml \
  --extra-vars "@{{template_folder}}/ignite.yaml"

```
# Cloud Adoption Framework landing zones for Terraform - Starter template for Azure Subscription Vending Machine (ASVM)

## Generate the definition files

```bash

ansible-playbook {{public_templates_folder}}/ansible/asvm_definition.yaml \
  --extra-vars "@{{template_folder}}/ignite.yaml"

```

### Regenerate the template

Note: This playbook will override the customization you have performed in your {{platform_configuration_folder}} folder.

```bash
ansible-playbook {{public_templates_folder}}/asvm/orion/walk-through.yaml \
  --extra-vars "@{{template_folder}}/ignite.yaml"

```
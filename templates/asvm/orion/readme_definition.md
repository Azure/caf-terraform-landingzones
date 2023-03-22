# Cloud Adoption Framework landing zones for Terraform - Starter template for Azure Subscription Vending Machine (ASVM)

## Generate the configuration files

```bash
ansible-playbook {{public_templates_folder}}/ansible/ansible.yaml \
  --extra-vars "@{{template_folder}}/ignite.yaml"  \
  -e base_folder=$(pwd)


```

## Regenerate the definition folder

```bash
ansible-playbook {{public_templates_folder}}/ansible/asvm_definition.yaml \
  --extra-vars "@{{template_folder}}/ignite.yaml" \
  -e base_folder=$(pwd)

```
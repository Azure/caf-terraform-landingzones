# Cloud Adoption Framework landing zones for Terraform - Ignite the Azure Platform and landing zones


:rocket: START HERE: [Follow the onboarding guide from](https://aztfmod.github.io/documentation/docs/enterprise-scale/landingzones/platform/org-setup)


For further executions or command, you can refer to the following sections

## Commands

### Clone the landingzone project (Terraform base code)
```bash
git clone https://github.com/Azure/caf-terraform-landingzones.git {{landingzones_folder}}
cd {{landingzones_folder}} && git pull
git checkout {{topology.caf_landingzone_branch}}

```

### Rover ignite the platform
Rover ignite will now process the yaml files and start building the configuration structure of the tfvars. Note during the creation of the platform landingones you will have to run rover ignite many times as some deployments are required to be completed before you can perform the next steps. Just follow the readme and next steps.

Rover ignite creates the tfvars and also the documentation.

```bash
rover login -t {{tenant_name.stdout}} -s {{subscription_id.stdout}}

rover ignite \
  --playbook {{ config_folder_platform_templates }}/ansible/ansible.yaml \
  -e base_templates_folder={{ config_folder_platform_templates }} \
  -e resource_template_folder={{landingzones_folder}}/templates/resources \
  -e config_folder={{destination_path}} \
  -e landingzones_folder={{landingzones_folder}} \
  -e destination_folder={{configuration_folder}}

```

### Next step

Once the rover ignite command has been executed, go to your configuration folder when the platform launchpad configuration has been created.

Get started with the [launchpad]({{destination_path}}/{{topologies.launchpad.relative_destination_folder}})

### Regenerate the definition folder

```bash
ansible-playbook {{config_folder_platform_templates}}/walk-through-single.yaml \
  -e topology_file={{destination_folder}}/ignite.yaml \
  -e config_folder_platform_templates={{config_folder_platform_templates}} \
  -e platform_service_folder={{platform_service_folder}} \
  -e landingzones_folder={{landingzones_folder}} \
  -e destination_folder={{destination_folder}} \
  -e configuration_folder={{configuration_folder}} \
  --extra-vars "@{{destination_folder}}/ignite_input.yaml"

```
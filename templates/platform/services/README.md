# Cloud Adoption Framework landing zones for Terraform - Ignite the Azure Platform and landing zones


:rocket: START HERE: [Follow the onboarding guide from](https://aztfmod.github.io/documentation/docs/azure-landing-zones/landingzones/platform/org-setup)


For further executions or command, you can refer to the following sections

## Commands

### Rover ignite the platform

Rover ignite will  process the YAML files and start building the configuration structure of the TFVARS. 

Please note that during the creation of the platform landingones you will have to run rover ignite multiple times as some deployments are required to be completed before you can perform the next steps. 

The best course of actions is to follow the readme files generated within each landing zones, as rover ignite creates the tfvars and also the documentation.

Once you are ready to ingite, just run:

```bash
rover login -t {{ azure_landing_zones.identity.tenant_name | default(tenant_name)}} -s {{subscription_id.stdout}}

ansible-playbook $(readlink -f ./landingzones/templates/ansible/ansible.yaml) \
  --extra-vars "@$(readlink -f ./platform/definition/ignite.yaml)"

```

### Next step

Once the rover ignite command has been executed, go to your configuration folder when the platform launchpad configuration has been created.

Get started with the [launchpad]({{destination_path}}/{{topologies.launchpad.relative_destination_folder}})



## References

Whenever needed, or under a profesional supervision you can use the following commands

### Clone the landingzone project (Terraform base code)

```bash
git clone https://github.com/Azure/caf-terraform-landingzones.git {{landingzones_folder}}
cd {{landingzones_folder}} && git fetch origin
git checkout {{caf_landingzone_branch}}

```

### Regenerate the definition folder

For your reference, if you need to re-generate the YAML definition files later, you can run the following command: 

```bash
ansible-playbook $(readlink -f ./landingzones/templates/ansible/walk-through-single.yaml) \
  --extra-vars "@$(readlink -f ./platform/definition/ignite.yaml)"

```
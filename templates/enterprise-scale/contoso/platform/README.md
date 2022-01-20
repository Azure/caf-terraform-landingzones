# Cloud Adoption Framework landing zones for Terraform - Starter template for Azure Platform


## Commands

### clone the starter project
```bash
git clone https://github.com:Azure/caf-terraform-landingzones-starter.git /tf/caf/starter

cd /tf/caf/starter
git pull
git checkout contoso-2109


```

### clone the landingzone project (Terraform base code)
```bash
git clone https://github.com/Azure/caf-terraform-landingzones.git /tf/caf/landingzones

cd /tf/caf/landingzones
git pull
git checkout 2112.int


```

### Rover ignite the platform
Rover ignite will now process the yaml files and start building the configuration structure of the tfvars. Note during the creation of the platform landingones you will have to run rover ignite many times as some deployments are required to be completed before you can perform the next steps.
Rover ignite creates the tfvars and also the documentation.

```bash
rover login -t tenantname<replace>

rover ignite \
  --playbook /tf/caf/landingzones/templates/platform/ansible.yaml \
  -e base_templates_folder=/tf/caf/landingzones/templates/platform \
  -e resource_template_folder=/tf/caf/landingzones/templates/resources \
  -e config_folder=/tf/caf/orgs/contoso/platform

```

### Next step

Once the rover ignite command has been executed, go to your configuration folder when the platform launchpad configuration has been created.
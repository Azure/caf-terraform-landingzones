Alpha version - work in progress

# Cloud Adoption Framework landing zones for Terraform - Starter template

## Generate the configuration files

```bash

# Generate the contoso demo files (only this scenario is supported at the moment. More to come)
cd /tf/caf/templates/platform && \
ansible-playbook e2e.yaml \
  -e base_templates_folder=/tf/caf/templates/platform \
  -e config_folder=/tf/caf/enterprise_scale/contoso/platform \
  -e model=demo

```

## Deploy the stack using symphony job

```bash

## Prerequisites

```bash
branch={{ resources.alz.private_lib[resources.alz.private_lib.version_to_deploy].caf_landingzone_branch }}
cd {{ destination_base_path }}
git clone --branch ${branch} https://github.com/Azure/caf-terraform-landingzones.git landingzones

# If you are planning to submit PR you can clone the a forked version instead
git clone --branch ${branch} git@github.com:Azure/caf-terraform-landingzones.git landingzones

# Or refresh an existing clone
cd {{ destination_base_path }}landingzones
git fetch origin
git checkout ${branch}
git status

cd {{ destination_base_path }}
git pull


```


# Only launchpad

 rover deploy \
  plan \
  -sc /tf/caf/configuration/contoso/platform/demo/pipelines/symphony_e2e.yaml \
  -b /tf/caf \
  -env sandpit \
  -ct launchpad \
  -level level0


```
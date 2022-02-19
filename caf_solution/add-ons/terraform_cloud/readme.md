# Add-on to deploy a Terraform Cloud / Terraform Enterprise configuration for Azure CAF landing zones

Supported scenario in this release:

1. Create the TFE/TFC environment (organization, variables, workspaces)

Future scenarios:

1. Use TFE/TFC as remote backend (local execution, backend in TFC)
2. Deploy Terraform Enterprise Server and remote agents
3. Use TFE/TFC in online mode (execution in TFE with remote agents)

## Authenticating to Terraform Cloud

First step is to authenticate to TFC using the following commands:

```bash
terraform login
export TERRAFORM_CONFIG="$HOME/.terraform.d/credentials.tfrc.json"
```

## Creating the TFC environment

This will setup TFC organization, workspaces and variables to host landing zones.

```bash
# Deploy
rover -lz /tf/caf/caf_solution/add-ons/terraform_cloud/ \
-var-folder /tf/caf/caf_solution/add-ons/terraform_cloud/example/ \
-a plan -launchpad

or
cd /tf/caf/caf_solution/add-ons/terraform_cloud/
terraform init
terraform plan \
-var-file /tf/caf/caf_solution/add-ons/terraform_cloud/example/tfc.tfvars
```

Once ready, you can create your configuration:

```bash
terraform apply \
-var-file /tf/caf/caf_solution/add-ons/terraform_cloud/example/tfc.tfvars
```
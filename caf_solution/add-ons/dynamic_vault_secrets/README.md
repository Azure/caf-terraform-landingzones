# CAF landing zones for Terraform - Dynamic Hashicorp Vault Secrets Add-on

Deploys dynamic hashicop vault secrets to a given path


## Prerequisites

Before running the add-on please make sure you set your vault backend, you can do this by exporting below environment variables.

``` bash
export VAULT_ADDR = "vault address"
export VAULT_TOKEN= "vault token"

```

## Example

The example configurations to deploy this add-on can be found [here](./scenario/100-simple-vault-secrets/configuration.tfvars)

Ensure the below is set prior to apply or destroy.

```bash
# Login the Azure subscription
rover login -t [TENANT_ID/TENANT_NAME] -s [SUBSCRIPTION_GUID]
# Environment is needed to be defined, otherwise the below LZs will land into sandpit which someone else is working on
export environment=[YOUR_ENVIRONMENT]
```

## Run vault dynamic serets deployment

```bash
rover \
  -lz /tf/caf/landingzones/caf_solution/add-ons/dynamic_vault_secrets \
  -var-folder /tf/caf/landingzones/caf_solution/add-ons/dynamic_vault_secrets/scenario/100-simple-vault-secrets \
  -tfstate vault.tfstate \
    -env ${environment}} \
    -level level1 \
    -parallelism 50 \
    -a plan

```
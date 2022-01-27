# CAF landing zones for Terraform - Dynamic Hashicorp Vault Secrets Add-on

Deploys dynamic hashicop vault secrets.


## Prerequisites

Before running the add-on please make sure you are [authenticated](https://learn.hashicorp.com/tutorials/vault/getting-started-authentication) to vault, one of the way is to set the below environment variables. For more information visit : https://www.vaultproject.io/docs/commands#environment-variables

``` bash
export VAULT_ADDR = "vault address"
export VAULT_TOKEN= "vault token"

```

## Example

An example of the configurations to deploy this add-on feature can be found [here](./scenario/100-simple-dynamic-vault-secrets/configuration.tfvars)

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
  -lz /tf/caf/caf_solution/add-ons/hashicorp_vault_secrets \
  -var-folder /tf/caf/caf_solution/add-ons/hashicorp_vault_secrets/scenario/100-simple-hashicorp-vault-secrets \
  -tfstate vault.tfstate \
    -env ${environment}} \
    -level level1 \
    -parallelism 50 \
    -a plan

```
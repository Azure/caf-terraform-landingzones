# Launchpad - {{ bootstrap.caf_environment }}

## Pre-requisites

This scenario requires the following privileges:

| Component          | Privileges           |
|--------------------|----------------------|
| Active Directory   | Global Administrator |
| Azure subscription | Subscription owner   |

## Deployment

{% if bootstrap.billing_subscription_role_delegations is defined %}
### Pre-requisite

Elevate your credentials to the tenant root level to have enough privileges to create the management group hierarchy.

```bash
{% if bootstrap.billing_subscription_role_delegations.azuread_user_ea_account_owner is defined %}
# Login to the subscription {{ bootstrap.caf_launchpad.subscription_name }} with the user {{ bootstrap.billing_subscription_role_delegations.azuread_user_ea_account_owner }}
{% else %}
# Login to the subscription {{ bootstrap.caf_launchpad.subscription_name }} with an account owner.
{% endif %}
rover login -t {{ bootstrap.azure_landing_zones.identity.tenant_name }}
{% if bootstrap.azure_landing_zones.identity.azuread_identity_mode != 'logged_in_user' %}
az rest --method post --url "/providers/Microsoft.Authorization/elevateAccess?api-version=2016-07-01"
{% endif %}

```
{% endif %}

### Launchpad

```bash
{% if bootstrap.billing_subscription_role_delegations is defined %}
{% if bootstrap.billing_subscription_role_delegations.azuread_user_ea_account_owner is defined %}
# Login to the subscription {{ bootstrap.caf_launchpad.subscription_name }} with the user {{ bootstrap.billing_subscription_role_delegations.azuread_user_ea_account_owner }}
{% else %}
# Login to the subscription {{ bootstrap.caf_launchpad.subscription_name }} with an account owner.
{% endif %}
{% endif %}
rover login -t {{ bootstrap.azure_landing_zones.identity.tenant_name }} -s {{ bootstrap.caf_launchpad.subscription_id }}

cd {{ landingzones_folder }}
git fetch origin
git checkout {{ bootstrap.caf_landingzone_branch }}
git pull

rover \
{% if bootstrap.azure_landing_zones.identity.azuread_identity_mode != "logged_in_user" and keyvaults is defined %}
  --impersonate-sp-from-keyvault-url {{ keyvaults[tfstate_object.identity_aad_key].vault_uri }} \
{% endif %}
  -lz {{ landingzones_folder }}/caf_launchpad \
  -var-folder {{ destination_path }} \
  -tfstate_subscription_id {{ bootstrap.caf_launchpad.subscription_id }} \
  -target_subscription {{ bootstrap.caf_launchpad.subscription_id }} \
  -tfstate {{ tfstate_object.tfstate }} \
  -launchpad \
  -env {{ bootstrap.caf_environment }} \
  -level {{ level }} \
  -p ${TF_DATA_DIR}/{{ tfstate_object.tfstate }}.tfplan \
  -a plan

```

If the plan is not successfull you need to come back to the yaml ignite.yaml, fix the values, re-execute the rover ignite and then rover plan.


```bash 
# On success plan, execute

rover \
{% if bootstrap.azure_landing_zones.identity.azuread_identity_mode != "logged_in_user" and keyvaults is defined %}
  --impersonate-sp-from-keyvault-url {{ keyvaults.cred_level0.vault_uri }} \
{% endif %}
  -lz {{ landingzones_folder }}/caf_launchpad \
  -var-folder {{ destination_path }} \
  -tfstate_subscription_id {{ bootstrap.caf_launchpad.subscription_id }} \
  -target_subscription {{ bootstrap.caf_launchpad.subscription_id }} \
  -tfstate {{ tfstate_object.tfstate }} \
  -launchpad \
  -env {{ bootstrap.caf_environment }} \
  -level {{ level }} \
  -p ${TF_DATA_DIR}/{{ tfstate_object.tfstate }}.tfplan \
  -a apply

```

Execute a rover logout and rover login in order to make sure your azure sessions has the Azure groups membership updated.

```bash
rover logout

rover login -t {{ bootstrap.azure_landing_zones.identity.tenant_name }}

# On success, re-execute the rover ignite

ansible-playbook $(readlink -f ./landingzones/templates/ansible/ansible.yaml) \
  --extra-vars "@$(readlink -f ./platform/definition/ignite.yaml)"

```

# Next steps

When you have successfully deployed the launchpad you can  move to the next step.

{% if bootstrap.azure_landing_zones.identity.azuread_identity_mode == 'service_principal' %}
 [Deploy the credentials landing zone](../credentials/readme.md)
{% else %}
 [Deploy the management services](../../level1/management/readme.md)
{% endif %}


# To destroy the launchpad

Destroying the launchpad is a specific opertion that requires the tfstate to be first downloaded in the rover and then run the terraform destroy command. Note the action to use is -a destroy

```bash

rover \
  -lz {{ landingzones_folder }}/caf_launchpad \
  -var-folder {{ destination_path }} \
  -tfstate_subscription_id {{ bootstrap.caf_launchpad.subscription_id }} \
  -target_subscription {{ bootstrap.caf_launchpad.subscription_id }} \
  -tfstate {{ tfstate_object.tfstate }} \
  -launchpad \
  -env {{ bootstrap.caf_environment }} \
  -level {{ level }} \
  -a destroy

```
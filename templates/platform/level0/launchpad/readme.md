# Launchpad - {{ resources.caf_terraform.launchpad.caf_environment }}

## Pre-requisites

This scenario requires the following privileges:

| Component          | Privileges           |
|--------------------|----------------------|
| Active Directory   | Global Administrator |
| Azure subscription | Subscription owner   |

## Deployment

{% if resources.caf_terraform.billing_subscription_role_delegations is defined %}
### Pre-requisite

Elevate your credentials to the tenant root level to have enough privileges to create the management group hierarchy.

```bash
{% if resources.caf_terraform.billing_subscription_role_delegations.azuread_user_ea_account_owner is defined %}
# Login to the subscription {{ resources.caf_terraform.launchpad.subscription_name }} with the user {{ resources.caf_terraform.billing_subscription_role_delegations.azuread_user_ea_account_owner }}
{% else %}
# Login to the subscription {{ resources.caf_terraform.launchpad.subscription_name }} with an account owner.
{% endif %}
rover login -t {{ resources.platform_identity.tenant_name }}
{% if resources.platform_identity.azuread_identity_mode != 'logged_in_user' %}
az rest --method post --url "/providers/Microsoft.Authorization/elevateAccess?api-version=2016-07-01"
{% endif %}

```
{% endif %}

### Launchpad

```bash
{% if resources.caf_terraform.billing_subscription_role_delegations is defined %}
{% if resources.caf_terraform.billing_subscription_role_delegations.azuread_user_ea_account_owner is defined %}
# Login to the subscription {{ resources.caf_terraform.launchpad.subscription_name }} with the user {{ resources.caf_terraform.billing_subscription_role_delegations.azuread_user_ea_account_owner }}
{% else %}
# Login to the subscription {{ resources.caf_terraform.launchpad.subscription_name }} with an account owner.
{% endif %}
{% endif %}
rover login -t {{ resources.platform_identity.tenant_name }} -s {{ resources.caf_terraform.launchpad.subscription_id }}

cd {{ landingzones_folder }}
git fetch origin
git checkout {{ resources.gitops.caf_landingzone_branch }}
git pull

rover \
{% if ((resources.platform_identity.azuread_identity_mode != "logged_in_user") and (credentials_tfstate_exists.rc == 0)) %}
  --impersonate-sp-from-keyvault-url {{ keyvaults[tfstate_object.identity_aad_key].vault_uri }} \
{% endif %}
  -lz {{ landingzones_folder }}/caf_launchpad \
  -var-folder {{ destination_path }} \
  -tfstate_subscription_id {{ resources.caf_terraform.launchpad.subscription_id }} \
  -target_subscription {{ resources.caf_terraform.launchpad.subscription_id }} \
  -tfstate {{ resources.tfstates.platform.launchpad.tfstate }} \
  -launchpad \
  -env {{ resources.caf_terraform.launchpad.caf_environment }} \
  -level {{ level }} \
  -p ${TF_DATA_DIR}/{{ resources.tfstates.platform.launchpad.tfstate }}.tfplan \
  -a plan

```

If the plan is not successfull you need to come back to the yaml contoso.caf.platform.yaml, fix the values, re-execute the rover ignite and then rover plan.


```bash 
# On success plan, execute

rover \
{% if ((resources.platform_identity.azuread_identity_mode != "logged_in_user") and (credentials_tfstate_exists.rc == 0)) %}
  --impersonate-sp-from-keyvault-url {{ keyvaults.cred_level0.vault_uri }} \
{% endif %}
  -lz {{ landingzones_folder }}/caf_launchpad \
  -var-folder {{ destination_path }} \
  -tfstate_subscription_id {{ resources.caf_terraform.launchpad.subscription_id }} \
  -target_subscription {{ resources.caf_terraform.launchpad.subscription_id }} \
  -tfstate {{ resources.tfstates.platform.launchpad.tfstate }} \
  -launchpad \
  -env {{ resources.caf_terraform.launchpad.caf_environment }} \
  -level {{ level }} \
  -p ${TF_DATA_DIR}/{{ resources.tfstates.platform.launchpad.tfstate }}.tfplan \
  -a apply

```

Execute a rover logout and rover login in order to make sure your azure sessions has the Azure groups membership updated.

```bash
rover logout

rover login -t {{ resources.platform_identity.tenant_name }}

# On success, re-execute the rover ignite

rover ignite \
  --playbook {{ base_templates_folder }}/ansible/ansible.yaml \
  -e base_templates_folder={{ base_templates_folder }} \
  -e resource_template_folder={{resource_template_folder}} \
  -e config_folder={{ config_folder }} \
  -e landingzones_folder={{ landingzones_folder }}

```

# Next steps

When you have successfully deployed the launchpad you can  move to the next step.

{% if resources.platform_identity.azuread_identity_mode == 'service_principal' %}
 [Deploy the credentials landing zone](../credentials/readme.md)
{% else %}
 [Deploy the management services](../../level1/management/readme.md)
{% endif %}
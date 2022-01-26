# Launchpad - {{ config.caf_terraform.launchpad.caf_environment }}

## Pre-requisites

This scenario requires the following privileges:

| Component          | Privileges         |
|--------------------|--------------------|
| Active Directory   | None               |
| Azure subscription | Subscription owner |

## Deployment

{% if config.caf_terraform.billing_subscription_role_delegations is defined %}
### Pre-requisite

Elevate your credentials to the tenant root level to have enough privileges to create the management group hierarchy.

```bash
{% if config.caf_terraform.billing_subscription_role_delegations.enable %}
# Login to the subscription {{ config.caf_terraform.launchpad.subscription_name }} with the user {{ config.caf_terraform.billing_subscription_role_delegations.azuread_user_ea_account_owner }}
{% else %}
# Login to the subscription {{ config.caf_terraform.launchpad.subscription_name }} with an account owner.
{% endif %}
rover login -t {{ config.platform_identity.tenant_name }}
az rest --method post --url "/providers/Microsoft.Authorization/elevateAccess?api-version=2016-07-01"

```
{% endif %}

### Launchpad

```bash
{% if config.caf_terraform.billing_subscription_role_delegations is defined %}
{% if config.caf_terraform.billing_subscription_role_delegations.enable %}
# Login to the subscription {{ config.caf_terraform.launchpad.subscription_name }} with the user {{ config.caf_terraform.billing_subscription_role_delegations.azuread_user_ea_account_owner }}
{% else %}
# Login to the subscription {{ config.caf_terraform.launchpad.subscription_name }} with an account owner.
{% endif %}
{% endif %}
rover login -t {{ config.platform_identity.tenant_name }} -s {{ config.caf_terraform.launchpad.subscription_id }}

cd /tf/caf/landingzones
git fetch origin
git checkout {{ config.gitops.caf_landingzone_branch }}

rover \
{% if ((config.platform_identity.azuread_identity_mode != "logged_in_user") and (credentials_tfstate_exists.rc == 0)) %}
  --impersonate-sp-from-keyvault-url {{ keyvaults.cred_level0.vault_uri }} \
{% endif %}
  -lz /tf/caf/landingzones/caf_launchpad \
  -var-folder {{ destination_base }}/{{ config.configuration_folders.platform.destination_relative_path }}/{{ level }}/{{ base_folder }} \
  -tfstate_subscription_id {{ config.caf_terraform.launchpad.subscription_id }} \
  -target_subscription {{ config.caf_terraform.launchpad.subscription_id }} \
  -tfstate {{ config.tfstates.platform.launchpad.tfstate }} \
  -log-severity {{ config.gitops.rover_log_error }} \
  -launchpad \
  -env {{ config.caf_terraform.launchpad.caf_environment }} \
  -level {{ level }} \
  -p ${TF_DATA_DIR}/{{ config.tfstates.platform.launchpad.tfstate }}.tfplan \
  -a plan

```

If the plan is not successfull you need to come back to the yaml contoso.caf.platform.yaml, fix the values, re-execute the rover ignite and then rover plan.


```bash 
# On success plan, execute

rover \
{% if ((config.platform_identity.azuread_identity_mode != "logged_in_user") and (credentials_tfstate_exists.rc == 0)) %}
  --impersonate-sp-from-keyvault-url {{ keyvaults.cred_level0.vault_uri }} \
{% endif %}
  -lz /tf/caf/landingzones/caf_launchpad \
  -var-folder {{ destination_base }}/{{ config.configuration_folders.platform.destination_relative_path }}/{{ level }}/{{ base_folder }} \
  -tfstate_subscription_id {{ config.caf_terraform.launchpad.subscription_id }} \
  -target_subscription {{ config.caf_terraform.launchpad.subscription_id }} \
  -tfstate {{ config.tfstates.platform.launchpad.tfstate }} \
  -log-severity {{ config.gitops.rover_log_error }} \
  -launchpad \
  -env {{ config.caf_terraform.launchpad.caf_environment }} \
  -level {{ level }} \
  -p ${TF_DATA_DIR}/{{ config.tfstates.platform.launchpad.tfstate }}.tfplan \
  -a apply

```

```bash
# On success, re-execute the rover ignite

rover ignite \
  --playbook /tf/caf/landingzones/templates/platform/ansible.yaml \
  -e base_templates_folder={{ base_templates_folder }} \
  -e resource_template_folder={{resource_template_folder}} \
  -e config_folder={{ config_folder }}

```

Execute a rover logout and rover login in order to make sure your azure sessions has the Azure groups membership updated.

```bash
rover logout

rover login -t {{ config.platform_identity.tenant_name }}

```

# Next steps

When you have successfully deployed the launchpad you can  move to the next step.

{% if config.platform_identity.azuread_identity_mode == 'service_principal' %}
 [Deploy the credentials landing zone](../credentials/readme.md)
{% else %}
 [Deploy the management services](../../level1/management/readme.md)
{% endif %}
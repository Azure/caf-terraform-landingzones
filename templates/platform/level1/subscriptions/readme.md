
### Platform subscriptions
Set-up the subscription delegations for platform and landingzone subscriptions

```bash
# For manual bootstrap:
# Login to the subscription {{ config.caf_terraform.launchpad.subscription_name }} with the user {{ config.caf_terraform.billing_subscription_role_delegations.azuread_user_ea_account_owner }}
rover login -t {{ config.platform_identity.tenant_name }} -s {{ config.caf_terraform.launchpad.subscription_id }}

rover \
{% if platform_subscriptions_details.eslz is defined %}
{% if config.platform_identity.azuread_identity_mode != "logged_in_user" %}
  --impersonate-sp-from-keyvault-url {{ keyvaults[tfstate_object.identity_aad_key].vault_uri }} \
{% endif %}
{% endif %}
  -lz {{ landingzones_folder }}/caf_solution \
  -var-folder {{ destination_path }} \
  -tfstate_subscription_id {{ config.caf_terraform.launchpad.subscription_id }} \
  -tfstate {{ config.tfstates.platform.platform_subscriptions.tfstate }} \
  -env {{ config.caf_terraform.launchpad.caf_environment }} \
  -level {{ level }} \
  -p ${TF_DATA_DIR}/{{ config.tfstates.platform.platform_subscriptions.tfstate }}.tfplan \
  -a plan

```


# Next steps

When you have successfully deployed the subscriptions management landing zone, you can move to the next step:

[Deploy the management services](../../level1/management/readme.md)
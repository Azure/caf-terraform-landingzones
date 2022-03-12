
### Platform subscriptions
Set-up the subscription delegations for platform and landingzone subscriptions

```bash
# For manual bootstrap:
# Login to the subscription {{ resources.caf_launchpad.subscription_name }} with the user {{ resources.billing_subscription_role_delegations.azuread_user_ea_account_owner }}
rover login -t {{ resources.azure_landing_zones.identity.tenant_name }} -s {{ resources.caf_launchpad.subscription_id }}

rover \
{% if resources.azure_landing_zones.identity.azuread_identity_mode != "logged_in_user" and keyvaults is defined %}
  --impersonate-sp-from-keyvault-url {{ keyvaults[tfstate_object.identity_aad_key].vault_uri }} \
{% endif %}
  -lz {{ landingzones_folder }}/caf_solution \
  -var-folder {{ destination_path }} \
  -tfstate_subscription_id {{ resources.caf_launchpad.subscription_id }} \
  -tfstate {{ tfstate_object.tfstate }} \
  -env {{ resources.caf_environment }} \
  -level {{ tfstate_object.level }} \
  -p ${TF_DATA_DIR}/{{ tfstate_object.tfstate }}.tfplan \
  -a plan

```


# Next steps

When you have successfully deployed the subscriptions management landing zone, you can move to the next step:

[Deploy the management services](../../level1/management/readme.md)
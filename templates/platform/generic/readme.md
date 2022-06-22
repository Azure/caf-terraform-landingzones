
```bash
#Note: close previous session if you logged with a different service principal using --impersonate-sp-from-keyvault-url
rover logout

# login a with a user member of the caf-maintainers group
rover login -t {{ resources.azure_landing_zones.identity.tenant_name }}

rover \
{% if resources.azure_landing_zones.identity.azuread_identity_mode != "logged_in_user" and keyvaults is defined %}
  --impersonate-sp-from-keyvault-url {{ keyvaults[ tfstate_object.identity_aad_key].vault_uri }} \
{% elif resources.azure_landing_zones.identity.azuread_identity_mode != "logged_in_user" and keyvault_scl is defined %}
  --impersonate-sp-from-keyvault-url {{ keyvault_scl.stdout }} \
{% endif %}
  -lz /tf/caf/landingzones/caf_solution \
  -var-folder {{ destination_path }} \
  -tfstate_subscription_id {{ resources.caf_launchpad.subscription_id }} \
{% if platform_subscriptions is defined %}
{% if platform_subscriptions[resources[tfstate_resource].resources.keys() | first] is defined %}
  -target_subscription {{ platform_subscriptions[resources[tfstate_resource].resources.keys() | first].subscription_id }} \
{% else %}
  -target_subscription {{ resources.caf_launchpad.subscription_id }} \
{% endif %}
{% else %}
  -target_subscription {{ resources.caf_launchpad.subscription_id }} \
{% endif %}
  -tfstate {{ tfstate_object.tfstate }} \
  -env {{ resources.caf_environment }} \
  -level {{ level }} \
  -w {{ tfstate_object.workspace | default('tfstate') }} \
  -p ${TF_DATA_DIR}/{{ tfstate_object.tfstate }}.tfplan \
  -a plan

```


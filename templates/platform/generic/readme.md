
```bash
#Note: close previous session if you logged with a different service principal using --impersonate-sp-from-keyvault-url
rover logout

# login a with a user member of the caf-maintainers group
rover login -t {{ config.platform_identity.tenant_name }}

rover \
{% if config.platform_identity.azuread_identity_mode != "logged_in_user" and keyvaults is defined %}
  --impersonate-sp-from-keyvault-url {{ keyvaults[ tfstate_object.identity_aad_key].vault_uri }} \
{% endif %}
  -lz /tf/caf/landingzones/caf_solution \
  -var-folder {{ destination_path }} \
  -tfstate_subscription_id {{ config.caf_terraform.launchpad.subscription_id }} \
{% if platform_subscriptions_details is defined %}
  -target_subscription {{ platform_subscriptions_details[resources.subscriptions.keys() | first].subscription_id }} \
{% elif subscriptions.platform_subscriptions[resources.subscriptions.keys() | first].subscription_id is defined %}
  -target_subscription {{ subscriptions.platform_subscriptions[resources.subscriptions.keys() | first].subscription_id }} \
{% else %}
  -target_subscription {{ config.caf_terraform.launchpad.subscription_id }} \
{% endif %}
  -tfstate {{ tfstate_object.tfstate }} \
  -env {{ config.caf_terraform.launchpad.caf_environment }} \
  -level {{ level }} \
  -w {{ tfstate_object.workspace | default('tfstate') }} \
  -p ${TF_DATA_DIR}/{{ tfstate_object.tfstate }}.tfplan \
  -a plan

```


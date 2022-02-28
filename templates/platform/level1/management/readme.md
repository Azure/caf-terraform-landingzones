
# Management
Deploy the management services

```bash
#Note: close previous session if you logged with a different service principal using --impersonate-sp-from-keyvault-url
rover logout

# login a with a user member of the caf-maintainers group
{% if platform_subscriptions_details is defined %}
rover login -t {{ resources.platform_identity.tenant_name }} -s {{ platform_subscriptions_details.management.subscription_id }}
{% elif subscriptions.platform_subscriptions.management.subscription_id is defined %}
rover login -t {{ resources.platform_identity.tenant_name }} -s {{ subscriptions.platform_subscriptions.management.subscription_id }}
{% else %}
rover login -t {{ resources.platform_identity.tenant_name }} -s {{ resources.caf_terraform.launchpad.subscription_id }}
{% endif %}

rover \
{% if platform_subscriptions_details.eslz is defined %}
{% if keyvaults is defined and resources.platform_identity.azuread_identity_mode != "logged_in_user" %}
  --impersonate-sp-from-keyvault-url {{ keyvaults[tfstate_object.identity_aad_key].vault_uri }} \
{% endif %}
{% endif %}
  -lz {{ landingzones_folder }}/caf_solution \
  -var-folder {{ destination_path }} \
  -tfstate_subscription_id {{ resources.caf_terraform.launchpad.subscription_id }} \
{% if platform_subscriptions_details is defined %}
  -target_subscription {{ platform_subscriptions_details.management.subscription_id }} \
{% elif subscriptions.platform_subscriptions.management.subscription_id is defined %}
  -target_subscription {{ subscriptions.platform_subscriptions.management.subscription_id }} \
{% else %}
  -target_subscription {{ resources.caf_terraform.launchpad.subscription_id }} \
{% endif %}
  -tfstate {{ resources.tfstates.platform.management.tfstate }} \
  -env {{ resources.caf_terraform.launchpad.caf_environment }} \
  -level {{ level }} \
  -p ${TF_DATA_DIR}/{{ resources.tfstates.platform.management.tfstate }}.tfplan \
  -a plan

```


# Next steps

When you have successfully deployed the management landing zone, you can move to the next step:

{% if resources.platform_core_setup.enterprise_scale is defined %}
 [Deploy Enterprise Scale](../../level1/eslz/readme.md)
{% else %}
 [Deploy Connectivity](../../level2/connectivity/readme.md)
{% endif %}

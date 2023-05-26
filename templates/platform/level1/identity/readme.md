
# Identity
Deploy the identity services

```bash
#Note: close previous session if you logged with a different service principal using --impersonate-sp-from-keyvault-url
rover logout

# login a with a user member of the caf-maintainers group
{% if platform_subscriptions_details is defined %}
rover login -t {{ resources.azure_landing_zones.identity.tenant_name }} -s {{ platform_subscriptions_details.identity.subscription_id }}
{% elif subscriptions.platform_subscriptions.identity.subscription_id is defined %}
rover login -t {{ resources.azure_landing_zones.identity.tenant_name }} -s {{ subscriptions.platform_subscriptions.identity.subscription_id }}
{% else %}
rover login -t {{ resources.azure_landing_zones.identity.tenant_name }} -s {{ resources.caf_launchpad.subscription_id }}
{% endif %}

rover \
{% if keyvaults is defined and resources.azure_landing_zones.identity.azuread_identity_mode != "logged_in_user" %}
  --impersonate-sp-from-keyvault-url {{ keyvaults[tfstate_object.identity_aad_key].vault_uri }} \
{% endif %}
  -lz {{ landingzones_folder }}/caf_solution \
  -var-folder {{ destination_path }} \
  -tfstate_subscription_id {{ resources.caf_launchpad.subscription_id }} \
{% if platform_subscriptions_details is defined %}
  -target_subscription {{ platform_subscriptions_details.identity.subscription_id }} \
{% elif subscriptions.platform_subscriptions.identity.subscription_id is defined %}
  -target_subscription {{ subscriptions.platform_subscriptions.identity.subscription_id }} \
{% else %}
  -target_subscription {{ resources.caf_launchpad.subscription_id }} \
{% endif %}
  -tfstate {{ resources.tfstates.platform.identity.tfstate }} \
  -env {{ resources.caf_environment }} \
  -level {{ level }} \
  -p ${TF_DATA_DIR}/{{ resources.tfstates.platform.identity.tfstate }}.tfplan \
  -a plan

```


# Next steps

{% for key in bootstrap.deployments[deployment_mode].alz.keys() %}
[Deploy Enterprise Scale - {{key}}](../../level1/alz/{{key}}/readme.md)
{% endfor %}

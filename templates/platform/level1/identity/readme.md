
# Identity
Deploy the identity services

```bash
#Note: close previous session if you logged with a different service principal using --impersonate-sp-from-keyvault-url
rover logout

# login a with a user member of the caf-maintainers group
{% if platform_subscriptions_details is defined %}
rover login -t {{ config.platform_identity.tenant_name }} -s {{ platform_subscriptions_details.identity.subscription_id }}
{% elif subscriptions.platform_subscriptions.identity.subscription_id is defined %}
rover login -t {{ config.platform_identity.tenant_name }} -s {{ subscriptions.platform_subscriptions.identity.subscription_id }}
{% else %}
rover login -t {{ config.platform_identity.tenant_name }} -s {{ config.caf_terraform.launchpad.subscription_id }}
{% endif %}

rover \
{% if platform_subscriptions_details.eslz is defined %}
{% if keyvaults is defined and config.platform_identity.azuread_identity_mode != "logged_in_user" %}
  --impersonate-sp-from-keyvault-url {{ keyvaults.cred_identity.vault_uri }} \
{% endif %}
{% endif %}
  -lz /tf/caf/landingzones/caf_solution \
  -var-folder {{ destination_base }}/{{ config.configuration_folders.platform.destination_relative_path }}/{{ level }}/{{ base_folder }} \
  -tfstate_subscription_id {{ config.caf_terraform.launchpad.subscription_id }} \
{% if platform_subscriptions_details is defined %}
  -target_subscription {{ platform_subscriptions_details.identity.subscription_id }} \
{% elif subscriptions.platform_subscriptions.identity.subscription_id is defined %}
  -target_subscription {{ subscriptions.platform_subscriptions.identity.subscription_id }} \
{% else %}
  -target_subscription {{ config.caf_terraform.launchpad.subscription_id }} \
{% endif %}
  -tfstate {{ config.tfstates.platform.identity.tfstate }} \
  -log-severity {{ config.gitops.rover_log_error }} \
  -env {{ config.caf_terraform.launchpad.caf_environment }} \
  -level {{ level }} \
  -p ${TF_DATA_DIR}/{{ config.tfstates.platform.identity.tfstate }}.tfplan \
  -a plan

```


# Next steps

 [Deploy Enterprise Scale](../../level1/eslz/readme.md)

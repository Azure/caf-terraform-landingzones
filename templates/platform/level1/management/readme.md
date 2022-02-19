
# Management
Deploy the management services

```bash
#Note: close previous session if you logged with a different service principal using --impersonate-sp-from-keyvault-url
rover logout

# login a with a user member of the caf-maintainers group
{% if platform_subscriptions_details is defined %}
rover login -t {{ config.platform_identity.tenant_name }} -s {{ platform_subscriptions_details.management.subscription_id }}
{% elif subscriptions.platform_subscriptions.management.subscription_id is defined %}
rover login -t {{ config.platform_identity.tenant_name }} -s {{ subscriptions.platform_subscriptions.management.subscription_id }}
{% else %}
rover login -t {{ config.platform_identity.tenant_name }} -s {{ config.caf_terraform.launchpad.subscription_id }}
{% endif %}

rover \
{% if platform_subscriptions_details.eslz is defined %}
{% if keyvaults is defined and config.platform_identity.azuread_identity_mode != "logged_in_user" %}
  --impersonate-sp-from-keyvault-url {{ keyvaults.cred_management.vault_uri }} \
{% endif %}
{% endif %}
  -lz /tf/caf/landingzones/caf_solution \
  -var-folder {{ destination_base }}/{{ config.configuration_folders.platform.destination_relative_path }}/{{ level }}/{{ base_folder }} \
  -tfstate_subscription_id {{ config.caf_terraform.launchpad.subscription_id }} \
{% if platform_subscriptions_details is defined %}
  -target_subscription {{ platform_subscriptions_details.management.subscription_id }} \
{% elif subscriptions.platform_subscriptions.management.subscription_id is defined %}
  -target_subscription {{ subscriptions.platform_subscriptions.management.subscription_id }} \
{% else %}
  -target_subscription {{ config.caf_terraform.launchpad.subscription_id }} \
{% endif %}
  -tfstate {{ config.tfstates.platform.management.tfstate }} \
  -log-severity {{ config.gitops.rover_log_error }} \
  -env {{ config.caf_terraform.launchpad.caf_environment }} \
  -level {{ level }} \
  -p ${TF_DATA_DIR}/{{ config.tfstates.platform.management.tfstate }}.tfplan \
  -a plan

```


# Next steps

When you have successfully deployed the management landing zone, you can move to the next step:

{% if config.platform_core_setup.enterprise_scale.enable %}
 [Deploy Enterprise Scale](../../level1/eslz/readme.md)
{% else %}
 [Deploy Connectivity](../../level2/connectivity/readme.md)
{% endif %}

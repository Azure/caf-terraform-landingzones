# Virtual Wan

```bash
# login a with a user member of the caf-platform-maintainers group
rover login -t {{ config.platform_identity.tenant_name }}

cd {{ landingzones_folder }}
git fetch origin
git checkout {{ resources.gitops.caf_landingzone_branch }}

rover \
{% if keyvaults is defined and config.platform_identity.azuread_identity_mode != "logged_in_user" %}
  --impersonate-sp-from-keyvault-url {{ keyvaults.cred_connectivity.vault_uri }} \
{% endif %}
  -lz {{ landingzones_folder }}/caf_solution \
  -var-folder {{ destination_path }} \
  -tfstate_subscription_id {{ config.caf_terraform.launchpad.subscription_id }} \
{% if platform_subscriptions_details is defined %}
  -target_subscription {{ platform_subscriptions_details.connectivity.subscription_id }} \
{% else %}
  -target_subscription {{ config.caf_terraform.launchpad.subscription_id }} \
{% endif %}
  -tfstate {{ config.tfstates.platform.virtual_wans[deployment].tfstate }} \
  -env {{ config.caf_terraform.launchpad.caf_environment }} \
  -level {{ level }} \
  -p ${TF_DATA_DIR}/{{ config.tfstates.platform.virtual_wans[deployment].tfstate }}.tfplan \
  -a plan

```

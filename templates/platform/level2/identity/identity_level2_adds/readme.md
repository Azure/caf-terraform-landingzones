
### Identity - Active Directory Domain Controllers (ADDS)

Deploy 2 domain controllers in the primary region

```bash
# login a with a user member of the caf-maintainers group
rover login -t {{ config.platform_identity.tenant_name }}

cd {{ destination_base }}/landingzones
git fetch origin
git checkout {{ resources.gitops.landingzones }}

rover \
{% if keyvaults is defined and config.platform_identity.azuread_identity_mode != "logged_in_user" %}
  --impersonate-sp-from-keyvault-url {{ keyvaults.cred_identity.vault_uri }} \
{% endif %}
  -lz {{ destination_base }}/landingzones/caf_solution \
  -var-folder {{ destination_path }} \
  -tfstate_subscription_id {{ config.caf_terraform.launchpad.subscription_id }} \
{% if platform_subscriptions_details is defined %}
  -target_subscription {{ platform_subscriptions_details.identity.subscription_id }} \
{% else %}
  -target_subscription {{ config.caf_terraform.launchpad.subscription_id }} \
{% endif %}
  -tfstate {{ config.tfstates.platform.identity_level2_adds[deployment].tfstate }} \
  -env {{ config.caf_terraform.launchpad.caf_environment }} \
  -level {{ level }} \
  -p ${TF_DATA_DIR}/{{ config.tfstates.platform.identity_level2_adds[deployment].tfstate }}.tfplan \
  -a plan

```

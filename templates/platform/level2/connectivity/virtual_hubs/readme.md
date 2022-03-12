# Virtual hubs

## Select the correct branch for the landingzones code

Note you need to adjust the branch {{ resources.gitops.caf_landingzone_branch }} to deploy the connectivity services

## {{ deployment }}

```bash
# login a with a user member of the caf-platform-maintainers group
rover login -t {{ resources.azure_landing_zones.identity.tenant_name }}

cd {{ landingzones_folder }}
git fetch origin
git checkout {{ resources.gitops.caf_landingzone_branch }}

rover \
{% if keyvaults is defined and resources.azure_landing_zones.identity.azuread_identity_mode != "logged_in_user" %}
  --impersonate-sp-from-keyvault-url {{ keyvaults.cred_connectivity.vault_uri }} \
{% endif %}
  -lz {{ landingzones_folder }}/caf_solution \
  -var-folder {{ destination_path }} \
  -tfstate_subscription_id {{ resources.caf_launchpad.subscription_id }} \
{% if platform_subscriptions_details is defined %}
  -target_subscription {{ platform_subscriptions_details.connectivity.subscription_id }} \
{% else %}
  -target_subscription {{ resources.caf_launchpad.subscription_id }} \
{% endif %}
  -tfstate {{ resources.tfstates.platform.virtual_hubs[deployment].tfstate }} \
  -log-severity ERROR \
  -env {{ resources.caf_environment }} \
  -level {{ level }} \
  -p ${TF_DATA_DIR}/{{ resources.tfstates.platform.virtual_hubs[deployment].tfstate }}.tfplan \
  -a plan

```

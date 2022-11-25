# Azure Subscription Vending Machine (asvm)

```bash
# login a with a user member of the caf-platform-maintainers group
rover login -t {{ azure_landing_zones.identity.tenant_name }}

cd {{ landingzones_folder }}
git fetch origin
git checkout {{ resources[deployment].gitops.caf_landingzone_branch }}

rover \
{% if keyvaults is defined and keyvaults[tfstate_object.identity_aad_key] is defined and azure_landing_zones.identity.azuread_identity_mode != "logged_in_user" %}
  --impersonate-sp-from-keyvault-url {{ keyvaults[tfstate_object.identity_aad_key].vault_uri }} \
{% endif %}
  -lz {{ landingzones_folder }}/caf_solution \
  -var-folder {{ destination_path }} \
  -tfstate_subscription_id {{ caf_launchpad.subscription_id }} \
  -target_subscription {{ caf_launchpad.subscription_id }} \
  -tfstate {{ resources.tfstates.platform.asvm.tfstate }} \
  -env {{ caf_environment }} \
  -level {{ level }} \
  -p ${TF_DATA_DIR}/{{ resources.tfstates.platform.asvm.tfstate }}.tfplan \
  -a plan

```


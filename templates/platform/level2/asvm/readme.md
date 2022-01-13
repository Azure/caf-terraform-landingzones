# Azure Subscription Vending Machine (asvm)

```bash
# login a with a user member of the caf-platform-maintainers group
rover login -t {{ config.platform_identity.tenant_name }}

cd {{ config.configuration_folders.platform.destination_base_path }}/landingzones
git fetch origin
git checkout {{ connectivity_express_routes.gitops.caf_landingzone_branch }}

rover \
{% if keyvaults is defined and config.platform_identity.azuread_identity_mode != "logged_in_user" %}
  --impersonate-sp-from-keyvault-url {{ keyvaults.cred_level0.vault_uri }} \
{% endif %}
  -lz {{ config.configuration_folders.platform.destination_base_path }}/landingzones/caf_solution \
  -var-folder {{ config.configuration_folders.platform.destination_base_path }}/{{ config.configuration_folders.platform.destination_relative_path }}/{{ level }}/{{ base_folder }} \
  -tfstate_subscription_id {{ config.caf_terraform.launchpad.subscription_id }} \
  -target_subscription {{ config.caf_terraform.launchpad.subscription_id }} \
  -tfstate {{ config.tfstates.platform.asvm.tfstate }} \
  -env {{ config.caf_terraform.launchpad.caf_environment }} \
  -level {{ level }} \
  -p ${TF_DATA_DIR}/{{ config.tfstates.platform.asvm.tfstate }}.tfplan \
  -a plan

```


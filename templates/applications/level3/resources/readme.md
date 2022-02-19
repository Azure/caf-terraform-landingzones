
### Deploy base resources in {{ asvm_folder }}

```bash
rover login -t {{ config.platform_identity.tenant_name }}

unset ARM_SKIP_PROVIDER_REGISTRATION

cd /tf/caf/landingzones
git pull
git checkout {{ resources.gitops.landingzones }}

rover \
{% if config.platform_identity.azuread_identity_mode != "logged_in_user" %}
  --impersonate-sp-from-keyvault-url {{ keyvaults.cred_subscription_creation_landingzones.vault_uri }} \
{% endif %}
  -lz /tf/caf/landingzones/caf_solution \
  -var-folder {{ destination_path }} \
  -tfstate_subscription_id {{ config.caf_terraform.launchpad.subscription_id }} \
  -target_subscription {{ asvm_subscriptions_details[asvm_folder].subscription_id }} \
  -tfstate {{ config.tfstates['asvm'][asvm_folder].resources.tfstate }} \
  --workspace {{ config.tfstates['asvm'][asvm_folder].workspace }} \
  -log-severity {{ config.gitops.rover_log_error }} \
  -env {{ config.caf_terraform.launchpad.caf_environment }} \
  -level {{ level }} \
  -p ${TF_DATA_DIR}/{{ config.tfstates['asvm'][asvm_folder].resources.tfstate }}.tfplan \
  -a plan

rover logout

```

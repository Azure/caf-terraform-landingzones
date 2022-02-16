
```bash
rover login -t {{ config.platform_identity.tenant_name }}

unset ARM_SKIP_PROVIDER_REGISTRATION

cd {{landingzones_folder}}
git pull
git checkout {{ resources.gitops.caf_landingzone_branch }}

rover \
{% if config.platform_identity.azuread_identity_mode != "logged_in_user" and keyvaults is defined %}
  --impersonate-sp-from-keyvault-url {{ keyvaults.cred_subscription_creation_landingzones.vault_uri }} \
{% endif %}
  -lz {{landingzones_folder}}/caf_solution \
  -var-folder {{ destination_path }} \
  -tfstate_subscription_id {{ config.caf_terraform.launchpad.subscription_id }} \
{% if asvm_subscriptions_details[subscription_key].subscription_id is defined %}
  -target_subscription {{ asvm_subscriptions_details[subscription_key].subscription_id }} \
{% endif %}
  -tfstate {{ tfstate_object.tfstate }} \
  --workspace {{ tfstate_object.workspace }} \
  -env {{ config.caf_terraform.launchpad.caf_environment }} \
  -level {{ level }} \
  -p ${TF_DATA_DIR}/{{ tfstate_object.tfstate }}.tfplan \
  -a plan

rover logout

```

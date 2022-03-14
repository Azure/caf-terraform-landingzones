
```bash
rover login -t {{ resources.azure_landing_zones.identity.tenant_name }}

unset ARM_SKIP_PROVIDER_REGISTRATION

cd {{landingzones_folder}}
git pull
git checkout {{ resources.gitops.caf_landingzone_branch }}

rover \
{% if resources.azure_landing_zones.identity.azuread_identity_mode != "logged_in_user" and keyvault_scl is defined %}
  --impersonate-sp-from-keyvault-url {{ keyvault_scl.stdout }} \
{% endif %}
  -lz {{landingzones_folder}}/caf_solution \
  -var-folder {{ destination_path }} \
  -tfstate_subscription_id {{ resources.caf_launchpad.subscription_id }} \
{% if asvm_subscriptions_details[subscription_key].subscription_id is defined %}
  -target_subscription {{ asvm_subscriptions_details[subscription_key].subscription_id }} \
{% endif %}
  -tfstate {{ tfstate_object.tfstate }} \
  --workspace {{ tfstate_object.workspace }} \
  -env {{ resources.caf_environment }} \
  -level {{ level }} \
  -p ${TF_DATA_DIR}/{{ tfstate_object.tfstate }}.tfplan \
  -a plan

rover logout

```


### Create storage containers for the landingzone

```bash
rover login -t {{ azure_landing_zones.identity.tenant_name }}

cd {{landingzones_folder}}
git pull
git checkout {{ resources[deployment].gitops.caf_landingzone_branch }}

rover \
{% if azure_landing_zones.identity.azuread_identity_mode != "logged_in_user" and keyvault_scl is defined %}
  --impersonate-sp-from-keyvault-url {{ keyvault_scl.stdout }} \
{% endif %}
  -lz {{landingzones_folder}}/caf_solution \
  -var-folder {{ destination_path }} \
  -tfstate_subscription_id {{ caf_launchpad.subscription_id }} \
  -target_subscription {{caf_launchpad.subscription_id }} \
  -tfstate {{ tfstate_object.tfstate }} \
  --workspace {{ tfstate_object.workspace | default('tfstate') }} \
  -env {{ caf_environment }} \
  -level {{ level }} \
  -p ${TF_DATA_DIR}/{{ tfstate_object.tfstate }}.tfplan \
  -a plan

rover logout

```

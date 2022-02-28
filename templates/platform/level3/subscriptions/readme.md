
### Create storage containers for the landingzone

```bash
rover login -t {{ resources.platform_identity.tenant_name }}

cd {{landingzones_folder}}
git pull
git checkout {{ resources.gitops.caf_landingzone_branch }}

rover \
{% if resources.platform_identity.azuread_identity_mode != "logged_in_user" and keyvault_scl is defined %}
  --impersonate-sp-from-keyvault-url {{ keyvault_scl.stdout }} \
{% endif %}
  -lz {{landingzones_folder}}/caf_solution \
  -var-folder {{ destination_path }} \
  -tfstate_subscription_id {{ resources.caf_terraform.launchpad.subscription_id }} \
  -target_subscription {{resources.caf_terraform.launchpad.subscription_id }} \
  -tfstate {{ tfstate_object.tfstate }} \
  --workspace {{ tfstate_object.workspace | default('tfstate') }} \
  -env {{ resources.caf_terraform.launchpad.caf_environment }} \
  -level {{ level }} \
  -p ${TF_DATA_DIR}/{{ tfstate_object.tfstate }}.tfplan \
  -a plan

rover logout

```

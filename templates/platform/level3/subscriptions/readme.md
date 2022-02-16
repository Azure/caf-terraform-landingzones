
### Create storage containers for the landingzone

```bash
rover login -t {{ config.platform_identity.tenant_name }}

cd {{landingzones_folder}}
git pull
git checkout {{ resources.gitops.caf_landingzone_branch }}

rover \
{% if config.platform_identity.azuread_identity_mode != "logged_in_user"  and keyvaults is defined %}
  --impersonate-sp-from-keyvault-url {{ keyvaults.cred_subscription_creation_landingzones.vault_uri }} \
{% endif %}
  -lz {{landingzones_folder}}/caf_solution \
  -var-folder {{ destination_path }} \
  -tfstate_subscription_id {{ config.caf_terraform.launchpad.subscription_id }} \
  -target_subscription {{config.caf_terraform.launchpad.subscription_id }} \
  -tfstate {{ tfstate_object.tfstate }} \
  --workspace {{ tfstate_object.workspace | default('tfstate') }} \
  -env {{ config.caf_terraform.launchpad.caf_environment }} \
  -level {{ level }} \
  -p ${TF_DATA_DIR}/{{ tfstate_object.tfstate }}.tfplan \
  -a plan

rover logout

```

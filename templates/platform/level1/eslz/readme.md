# Enterprise scale

## Deploy Enterprise Scale

Note you need to adjust the branch to deploy Enterprise Scale to {{ resources.platform_core_setup.private_lib[tfstate_object.eslz_version].caf_landingzone_branch }}

```bash
az account clear
# login a with a user member of the caf-platform-maintainers group
rover login -t {{ resources.platform_identity.tenant_name }}

cd {{ landingzones_folder }}
git fetch origin
git checkout {{ resources.platform_core_setup.private_lib[tfstate_object.eslz_version].caf_landingzone_branch }}

rover \
{% if keyvaults is defined and resources.platform_identity.azuread_identity_mode != "logged_in_user" %}
  --impersonate-sp-from-keyvault-url {{ keyvaults[tfstate_object.identity_aad_key].vault_uri }} \
{% endif %}
  -lz {{ landingzones_folder }}/caf_solution/add-ons/caf_eslz \
  -var-folder {{ destination_path }} \
  -tfstate_subscription_id {{ resources.caf_terraform.launchpad.subscription_id }} \
  -tfstate {{ tfstate_object.tfstate }} \
  -env {{ resources.caf_terraform.launchpad.caf_environment }} \
  -level {{ tfstate_object.level }} \
  -p ${TF_DATA_DIR}/{{ tfstate_object.tfstate }}.tfplan \
  -a plan

```

# Next steps

[Deploy asvm](../../level2/asvm/readme.md)
{% if bootstrap.deployments.scale_out_domains.identity_level2 is defined %}
{% for key in bootstrap.deployments.scale_out_domains.identity_level2.keys() %}
[Deploy identity_level2 - {{key}}](../../{{resources['identity_level2_' + key].relative_destination_folder}}/readme.md)
{% endfor %}
{% endif %}
[Deploy Connectivity](../../level2/connectivity/virtual_wans/readme.md)

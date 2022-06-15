# Enterprise scale

## Deploy Enterprise Scale

Note you need to adjust the branch to deploy Enterprise Scale to {{ resources.variables_azure_landing_zones.private_lib[tfstate_object.alz_version].caf_landingzone_branch }}

```bash
az account clear
# login a with a user member of the caf-platform-maintainers group
rover login -t {{ resources.azure_landing_zones.identity.tenant_name }}

cd {{ landingzones_folder }}
git fetch origin
git checkout {{ resources.variables_azure_landing_zones.private_lib[tfstate_object.alz_version].caf_landingzone_branch }}

rover \
{% if keyvaults is defined and resources.azure_landing_zones.identity.azuread_identity_mode != "logged_in_user" %}
  --impersonate-sp-from-keyvault-url {{ keyvaults[tfstate_object.identity_aad_key].vault_uri }} \
{% endif %}
  -lz {{ landingzones_folder }}/caf_solution/add-ons/caf_eslz \
  -var-folder {{ destination_path }} \
  -tfstate_subscription_id {{ resources.caf_launchpad.subscription_id }} \
  -target_subscription {{ resources.caf_launchpad.subscription_id }} \
  -tfstate {{ tfstate_object.tfstate }} \
  -env {{ resources.caf_environment }} \
  -level {{ tfstate_object.level }} \
  -p ${TF_DATA_DIR}/{{ tfstate_object.tfstate }}.tfplan \
  -a plan

```

# Next steps

[Deploy asvm](../../level2/asvm/readme.md)
{% if resources.deployments[stage].scale_out_domains[region].identity_level2 is defined %}
{% for key in resources.deployments[stage].scale_out_domains[region].identity_level2.keys() %}
[Deploy identity_level2 - {{key}}](../../{{resources['identity_level2_' + key].relative_destination_folder}}/readme.md)
{% endfor %}
{% endif %}
[Deploy Connectivity](../../level2/connectivity/virtual_wans/readme.md)

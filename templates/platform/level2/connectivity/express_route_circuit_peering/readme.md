
# Express Route Circuit Peerings for {{ circuit }}

```bash
# login a with a user member of the caf-platform-maintainers group
rover login -t {{ resources.platform_identity.tenant_name }}

cd {{ landingzones_folder }}
git fetch origin
git checkout {{ connectivity_express_routes.gitops.caf_landingzone_branch }}

rover \
{% if keyvaults is defined and resources.platform_identity.azuread_identity_mode != "logged_in_user" %}
  --impersonate-sp-from-keyvault-url {{ keyvaults.cred_connectivity.vault_uri }} \
{% endif %}
  -lz {{ landingzones_folder }}/caf_solution \
  -var-folder {{ destination_base }}/{{ resources.configuration_folders.platform.destination_relative_path }}/{{ level }}/{{ base_folder }}/express_route_circuit_peering/{{ circuit }} \
  -tfstate_subscription_id {{ resources.caf_terraform.launchpad.subscription_id }} \
{% if platform_subscriptions_details is defined %}
  -target_subscription {{ platform_subscriptions_details.connectivity.subscription_id }} \
{% else %}
  -target_subscription {{ resources.caf_terraform.launchpad.subscription_id }} \
{% endif %}
  -tfstate {{ resources.tfstates.platform.express_route_circuit_peerings[circuit].tfstate }} \
  -env {{ resources.caf_terraform.launchpad.caf_environment }} \
  -level {{ level }} \
  -p ${TF_DATA_DIR}/{{ resources.tfstates.platform.express_route_circuit_peerings[circuit].tfstate }}.tfplan \
  -a plan

```


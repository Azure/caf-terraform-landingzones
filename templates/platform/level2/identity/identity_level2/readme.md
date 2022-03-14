
# Identity
Deploy the identity services

```bash
#Note: close previous session if you logged with a different service principal using --impersonate-sp-from-keyvault-url
rover logout

# login a with a user member of the caf-maintainers group
rover login -t {{ resources.azure_landing_zones.identity.tenant_name }}

rover \
{% if resources.azure_landing_zones.identity.azuread_identity_mode != "logged_in_user" %}
  --impersonate-sp-from-keyvault-url {{ keyvaults.cred_identity.vault_uri }} \
{% endif %}
  -lz {{ landingzones_folder }}/caf_solution \
  -var-folder {{ destination_path }} \
  -tfstate_subscription_id {{ resources.caf_launchpad.subscription_id }} \
  -target_subscription {{ platform_subscriptions_details.identity.subscription_id }} \
  -tfstate {{ resources.tfstates.platform.identity_level2[deployment].tfstate }} \
  -log-severity {{ resources.gitops.rover_log_error }} \
  -env {{ resources.caf_environment }} \
  -level {{ level }} \
  -p ${TF_DATA_DIR}/{{ resources.tfstates.platform.identity_level2[deployment].tfstate }}.tfplan \
  -a plan

```


# Next steps

 [Deploy Enterprise Scale](../../level1/alz/readme.md)

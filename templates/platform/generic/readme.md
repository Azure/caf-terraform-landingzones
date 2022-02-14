
```bash
#Note: close previous session if you logged with a different service principal using --impersonate-sp-from-keyvault-url
rover logout

# login a with a user member of the caf-maintainers group
rover login -t {{ config.platform_identity.tenant_name }}

rover \
{% if config.platform_identity.azuread_identity_mode != "logged_in_user" %}
  --impersonate-sp-from-keyvault-url {{ keyvaults.cred_identity.vault_uri }} \
{% endif %}
  -lz /tf/caf/landingzones/caf_solution \
  -var-folder {{ destination_path }} \
  -tfstate_subscription_id {{ config.caf_terraform.launchpad.subscription_id }} \
{% if config.subscriptions[resources.subscriptions.keys() | first ].subscription_id is defined %}
  -target_subscription {{ config.subscriptions[resources.subscriptions.keys() | first ].subscription_id }} \
{% endif %}
  -tfstate {{ config.tfstates.platform[resources.deployments.tfstate.keys() | first][resources.deployments.tfstate.values() | first].tfstate }} \
  -log-severity {{ config.gitops.rover_log_error }} \
  -env {{ config.caf_terraform.launchpad.caf_environment }} \
  -level {{ level }} \
  -p ${TF_DATA_DIR}/{{ config.tfstates.platform[resources.deployments.tfstate.keys() | first][resources.deployments.tfstate.values() | first].tfstate }}.tfplan \
  -a plan

```


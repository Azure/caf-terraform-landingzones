
### Generate asvm for {{ asvm_folder }}

```bash
rover login -t {{ config.platform_identity.tenant_name }}

ARM_SKIP_PROVIDER_REGISTRATION=true && rover \
{% if config.platform_identity.azuread_identity_mode != "logged_in_user" %}
  --impersonate-sp-from-keyvault-url {{ keyvaults.cred_subscription_creation_landingzones.vault_uri }} \
{% endif %}
  -lz /tf/caf/landingzones/caf_solution \
  -var-folder {{ destination_path }} \
  -tfstate_subscription_id {{ config.caf_terraform.launchpad.subscription_id }} \
  -tfstate {{ config.tfstates["asvm"][asvm_folder].subscriptions.tfstate }} \
  --workspace {{ config.tfstates["asvm"][asvm_folder].workspace }} \
  -env {{ config.caf_terraform.launchpad.caf_environment }} \
  -level {{ level }} \
  -p ${TF_DATA_DIR}/{{  config.tfstates["asvm"][asvm_folder].subscriptions.tfstate }}.tfplan \
  -a plan

rover logout

```
Once you have executed the rover apply to create the subscription, you need to re-execute the rover ignite to generate the instructions for the next steps.

Note you need to logout and login as a caf_maintainer group member

```bash
rover login -t {{ config.platform_identity.tenant_name }}

rover ignite \
  --playbook /tf/caf/starter/templates/landingzones/ansible.yaml \
  -e base_templates_folder={{ base_templates_folder }} \
  -e resource_template_folder={{ resource_template_folder }} \
  -e config_folder={{ config_folder }} \
  -e destination_base_path={{ destination_base_path }} \
  -e config_folder_platform={{ config_folder_platform }}

```


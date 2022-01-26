
### Generate launchpad credentials

```bash
# For manual bootstrap:
# Login to the subscription {{ config.caf_terraform.launchpad.subscription_name }} with the user {{ config.caf_terraform.billing_subscription_role_delegations.azuread_user_ea_account_owner }}
rover login -t {{ config.platform_identity.tenant_name }}

rover \
{% if ((config.platform_identity.azuread_identity_mode != "logged_in_user") and (credentials_tfstate_exists.rc == 0)) %}
  --impersonate-sp-from-keyvault-url {{ keyvaults.cred_identity.vault_uri }} \
{% endif %}
  -lz /tf/caf/landingzones/caf_solution \
  -var-folder {{ destination_base }}/{{ config.configuration_folders.platform.destination_relative_path }}/{{ level }}/{{ base_folder }} \
  -tfstate_subscription_id {{ config.caf_terraform.launchpad.subscription_id }} \
  -target_subscription {{ config.caf_terraform.launchpad.subscription_id }} \
  -tfstate {{ config.tfstates.platform.launchpad_credentials.tfstate }} \
  -launchpad \
  -log-severity {{ config.gitops.rover_log_error }} \
  -env {{ config.caf_terraform.launchpad.caf_environment }} \
  -level {{ level }} \
  -p ${TF_DATA_DIR}/{{ config.tfstates.platform.launchpad_credentials.tfstate }}.tfplan \
  -a plan

```

If the plan is not successfull you need to come back to the yaml contoso.caf.platform.yaml, fix the values, re-execute the rover ignite and then rover plan.


```bash 
# On success plan, execute

rover \
{% if ((config.platform_identity.azuread_identity_mode != "logged_in_user") and (credentials_tfstate_exists.rc == 0)) %}
  --impersonate-sp-from-keyvault-url {{ keyvaults.cred_identity.vault_uri }} \
{% endif %}
  -lz /tf/caf/landingzones/caf_solution \
  -var-folder {{ destination_base }}/{{ config.configuration_folders.platform.destination_relative_path }}/{{ level }}/{{ base_folder }} \
  -tfstate_subscription_id {{ config.caf_terraform.launchpad.subscription_id }} \
  -target_subscription {{ config.caf_terraform.launchpad.subscription_id }} \
  -tfstate {{ config.tfstates.platform.launchpad_credentials.tfstate }} \
  -launchpad \
  -log-severity {{ config.gitops.rover_log_error }} \
  -env {{ config.caf_terraform.launchpad.caf_environment }} \
  -level {{ level }} \
  -p ${TF_DATA_DIR}/{{ config.tfstates.platform.launchpad_credentials.tfstate }}.tfplan \
  -a apply

```

```bash
# On success, re-execute the rover ignite

rover ignite \
  --playbook /tf/caf/landingzones/templates/platform/ansible.yaml \
  -e base_templates_folder={{ base_templates_folder }} \
  -e resource_template_folder={{resource_template_folder}} \
  -e config_folder={{ config_folder }}

```

Now if you refresh the readme of the credentials deployment, you will notice the rover command has been updated to impersonate the execution of the rover based on the credentials that have just been created and stored in the keyvault. The goal here is to execute the deployment steps using the same privileges that will be used later when using a pipeline.

Just re-execute the plan/apply command as above and you will notice the rover will login as the identity service principal. When executed, execute a rover logout as the next step will be executed under a different security context.

# Next steps

When you have successfully deployed the launchpad you can  move to the next step.

{% if config.caf_terraform.billing_subscription_role_delegations.enable %}
 [[Deploy the billing subscription role delegation](../billing_subscription_role_delegations/readme.md)
{% else %}
 [Deploy the subscription services](../../level1/subscriptions/readme.md)
{% endif %}

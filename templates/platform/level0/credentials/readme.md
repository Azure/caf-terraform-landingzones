
### Generate launchpad credentials

```bash
# For manual bootstrap:
# Login to the subscription {{ resources.caf_launchpad.subscription_name }} with the user {{ resources.billing_subscription_role_delegations.azuread_user_ea_account_owner }}
rover login -t {{ resources.azure_landing_zones.identity.tenant_name }}

rover \
{% if resources.azure_landing_zones.identity.azuread_identity_mode != "logged_in_user" and keyvaults is defined %}
  --impersonate-sp-from-keyvault-url {{ keyvaults[tfstate_object.identity_aad_key].vault_uri }} \
{% endif %}
  -lz {{ landingzones_folder }}/caf_solution \
  -var-folder {{ destination_path }} \
  -tfstate_subscription_id {{ resources.caf_launchpad.subscription_id }} \
  -target_subscription {{ resources.caf_launchpad.subscription_id }} \
  -tfstate {{ resources.tfstates.platform.launchpad_credentials.tfstate }} \
  -launchpad \
  -env {{ resources.caf_environment }} \
  -level {{ level }} \
  -p ${TF_DATA_DIR}/{{ resources.tfstates.platform.launchpad_credentials.tfstate }}.tfplan \
  -a plan

```

If the plan is not successfull you need to come back to the yaml ignite.yaml, fix the values, re-execute the rover ignite and then rover plan.


```bash 
# On success plan, execute

rover \
{% if resources.azure_landing_zones.identity.azuread_identity_mode != "logged_in_user" and keyvaults is defined %}
  --impersonate-sp-from-keyvault-url {{ keyvaults[tfstate_object.identity_aad_key].vault_uri }} \
{% endif %}
  -lz {{ landingzones_folder }}/caf_solution \
  -var-folder {{ destination_path }} \
  -tfstate_subscription_id {{ resources.caf_launchpad.subscription_id }} \
  -target_subscription {{ resources.caf_launchpad.subscription_id }} \
  -tfstate {{ resources.tfstates.platform.launchpad_credentials.tfstate }} \
  -launchpad \
  -env {{ resources.caf_environment }} \
  -level {{ level }} \
  -p ${TF_DATA_DIR}/{{ resources.tfstates.platform.launchpad_credentials.tfstate }}.tfplan \
  -a apply

```

```bash
# On success, re-execute the rover ignite

ansible-playbook $(readlink -f ./landingzones/templates/ansible/ansible.yaml) \
  --extra-vars "@$(readlink -f ./platform/definition/ignite.yaml)"

```

Now if you refresh the readme of the credentials deployment, you will notice the rover command has been updated to impersonate the execution of the rover based on the credentials that have just been created and stored in the keyvault. The goal here is to execute the deployment steps using the same privileges that will be used later when using a pipeline.

Just re-execute the plan/apply command as above and you will notice the rover will login as the identity service principal. When executed, execute a rover logout as the next step will be executed under a different security context.

# Next steps

When you have successfully deployed the launchpad you can  move to the next step.

{% if resources.billing_subscription_role_delegations.enable %}
 [[Deploy the billing subscription role delegation](../billing_subscription_role_delegations/readme.md)
{% else %}
 [Deploy the subscription services](../../level1/subscriptions/readme.md)
{% endif %}

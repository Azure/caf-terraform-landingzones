
### billing_subscription_role_delegations
Set-up the subscription delegations for platform and landingzone subscriptions

```bash
# Login to the subscription {{ config.caf_terraform.launchpad.subscription_name }} with the user {{ config.caf_terraform.billing_subscription_role_delegations.azuread_user_ea_account_owner }}
rover login -t {{ config.platform_identity.tenant_name }}

rover \
  -lz /tf/caf/landingzones/caf_solution \
  -var-folder {{ config.configuration_folders.platform.destination_base_path }}/{{ config.configuration_folders.platform.destination_relative_path }}/level0/billing_subscription_role_delegations \
  -tfstate_subscription_id {{ config.caf_terraform.launchpad.subscription_id }} \
  -tfstate {{ config.tfstates.platform.billing_subscription_role_delegations.tfstate }} \
  -target_subscription {{ config.caf_terraform.launchpad.subscription_id }} \
  -log-severity {{ config.gitops.rover_log_error }} \
  -launchpad \
  -env {{ config.caf_terraform.launchpad.caf_environment }} \
  -level {{ level }} \
  -p ${TF_DATA_DIR}/{{ config.tfstates.platform.billing_subscription_role_delegations.tfstate }}.tfplan \
  -a plan

rover logout

```

# Run rover ignite to generate the next level configuration files

To execute this step you need to login with on of the CAF maintainers:
{% for maintainer in config.platform_identity.caf_platform_maintainers %}
  - {{ maintainer }}
{% endfor %}

```bash

rover login -t {{ config.platform_identity.tenant_name }}

rover ignite \
  --playbook /tf/caf/starter/templates/platform/ansible.yaml \
  -e base_templates_folder={{ base_templates_folder }} \
  -e resource_template_folder={{resource_template_folder}} \
  -e config_folder={{ config_folder }}

```

# Next steps

When you have successfully deployed the level0 components, you can move to the next step.

[Deploy the subscriptions](../../level1/subscriptions/readme.md)

### billing_subscription_role_delegations
Set-up the subscription delegations for platform and landingzone subscriptions

```bash
# Login to the subscription {{ resources.caf_launchpad.subscription_name }} with the user {{ resources.billing_subscription_role_delegations.azuread_user_ea_account_owner }}
rover login -t {{ resources.azure_landing_zones.identity.tenant_name }}

rover \
  -lz {{ landingzones_folder }}/caf_solution \
  -var-folder {{ destination_base }}/{{ resources.configuration_folders.platform.destination_relative_path }}/level0/billing_subscription_role_delegations \
  -tfstate_subscription_id {{ resources.caf_launchpad.subscription_id }} \
  -tfstate {{ resources.tfstates.platform.billing_subscription_role_delegations.tfstate }} \
  -target_subscription {{ resources.caf_launchpad.subscription_id }} \
  -launchpad \
  -env {{ resources.caf_environment }} \
  -level {{ level }} \
  -p ${TF_DATA_DIR}/{{ resources.tfstates.platform.billing_subscription_role_delegations.tfstate }}.tfplan \
  -a plan

rover logout

```

# Run rover ignite to generate the next level configuration files

To execute this step you need to login with on of the CAF maintainers:
{% for maintainer in resources.azure_landing_zones.identity.caf_platform_maintainers %}
  - {{ maintainer }}
{% endfor %}

```bash

rover login -t {{ resources.azure_landing_zones.identity.tenant_name }}

rover ignite \
  --playbook {{ landingzones_folder }}/ansible.yaml \
  -e base_templates_folder={{ base_templates_folder }} \
  -e resource_template_folder={{resource_template_folder}} \
  -e config_folder={{ config_folder }} \
  -e landingzones_folder={{ landingzones_folder }}

```

# Next steps

When you have successfully deployed the level0 components, you can move to the next step.

[Deploy the subscriptions](../../level1/subscriptions/readme.md)
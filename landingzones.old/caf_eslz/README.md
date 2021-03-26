# Cloud Adoption Framework for Azure - Landing zones on Terraform - Enterprise-Scale

The foundations landing zone allows you to manage the core components of an environment:

* Management groups
* Policies

Foundations landing zone operates at **level 1**.

For a review of the hierarchy approach of Cloud Adoption Framework for Azure landing zones on Terraform, you can refer to [the following documentation](../../documentation/code_architecture/hierarchy.md).

</BR>

## Components

CAF eslz leverages the enterprise-scale module in order to deploy its core components.

For full description on enterprise_scale module usage, please [refer to the repository](https://github.com/Azure/terraform-azurerm-caf-enterprise-scale)

This is currently work in progress.
Use the following configuration file in order to get started with the enterprise-scale module integration:

```bash
# This example will setup the complete enterprise-scale fundamentals management groups and policies. Please make sure you have appropriate privileges on the tenant and subscription

rover -lz /tf/caf/public/landingzones/caf_eslz \
  -var-folder /tf/caf/public/landingzones/caf_eslz/scenario/100 \
  -level level1 \
  -a [plan|apply|destroy]

# This example will setup custom enterprise-scale management groups and policies. Please make sure you have appropriate privileges on the tenant and subscription

rover -lz /tf/caf/public/landingzones/caf_eslz \
  -var-folder /tf/caf/public/landingzones/caf_eslz/scenario/200 \
  -level level1 \
  -a [plan|apply|destroy]

# If the tfstates are stored in a different subscription you need to execute the following command
rover -lz /tf/caf/public/landingzones/caf_eslz \
  -tfstate_subscription_id <ID of the subscription> \
  -var-folder /tf/caf/public/landingzones/caf_foundations/scenario/200 \
  -level level1 \
  -a apply
```

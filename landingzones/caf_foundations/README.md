# Cloud Adoption Framework for Azure - Landing zones on Terraform - Foundations

The foundations landing zone allows you to manage the core components of an environment:

* Management groups
* Policies
* Auditing and Accounting, deployment or connection to existing ones.

Foundations landing zone operates at **level 1**.

For a review of the hierarchy approach of Cloud Adoption Framework for Azure landing zones on Terraform, you can refer to [the following documentation](../../documentation/code_architecture/hierarchy.md).

</BR>

## Components

CAF foundations landing zone leverages the enterprise-scale module in order to deploy its core components.

## Deploying CAF foundations

By default, the content of this landing zone is empty unless you specify a configuration file to enable it.

```bash
#  To deploy the CAF foundations in passthrough mode
rover -lz /tf/caf/landingzones/caf_foundations \
-level level1 \
-a apply
```

## Deploying CAF foundations with enterprise-scale (experimental)

This is currently work in progress.
Use the following configuration file in order to get started with the enterprise-scale module integration:

```bash
rover -lz /tf/caf/landingzones/caf_foundations \
-var-folder /tf/caf/landingzones/caf_foundations/scenario/200 \
-level level1 \
-a apply
```

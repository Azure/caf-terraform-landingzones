# Cloud Adoption Framework for Azure - Landing zones on Terraform - Shared services

The Shared services landing zone allows you to management components on Microsoft Azure, typically:

* Monitoring
* Azure Site Recovery
* Azure Backup
* Azure Automation

Shared services landing zone operates at **level 2**.

It is **important** to deploy shared services landing zone, even in passthrough mode as it will export some shared parameters and settings from level1 landing zones.

For a review of the hierarchy approach of Cloud Adoption Framework for Azure landing zones on Terraform, you can refer to [the following documentation](../../documentation/code_architecture/hierarchy.md).

## Deploying shared services

By default, the content of this landing zone is empty unless you specify a configuration file to enable it.

```bash
rover -lz /tf/caf/landingzones/caf_shared_services \
-level level2 \
-a apply
```

You can deploy an example with Azure Site Recovery configuration and Automation:

```bash
rover -lz /tf/caf/landingzones/caf_shared_services \
-level level2 \
-var-folder /tf/caf/landingzones/caf_shared_services/scenario/100 \
-a apply
```

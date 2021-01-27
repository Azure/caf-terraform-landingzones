# Cloud Adoption Framework for Azure - Landing zones on Terraform - Solutions

The solutions landing zone developed in order to cater infrastructure part of your application. This LZ will keep on improving to support all possible workload regardless of technology varies from IaaS, PaaS and container. Solutions LZ should be able to deploy majority of your workloads reside in level 3.

* App Service (including App Service Environment)
* Azure Kubernetes Service (AKS)
* Azure Databricks
* Azure SQL Database
* Azure Application Gateway
* Azure Redis Cache
* Azure Keyvault
* Azure Virtual Machine
* Azure Machine Learning
* Azure Synapse

Solutions landing zone operates at **level 3**.

For a review of the hierarchy approach of Cloud Adoption Framework for Azure landing zones on Terraform, you can refer to [the following documentation](../../documentation/code_architecture/hierarchy.md).

## Deploying solutions

By default, the content of this landing zone is empty unless you specify a configuration file to enable it.

```bash
rover -lz /tf/caf/public/landingzones/caf_solutions \
-level level3 \
-a apply
```


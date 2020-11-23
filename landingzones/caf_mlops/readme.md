# Cloud Adoption Framework for Azure - Landing zones on Terraform - MLOps

The mlops landing zone allows you to deploy a simple machine learning workspace on Azure.

* Machine Learning Workspace
* App insights
* Key Vault
* Storage Account

MLOps landing zone operates at **level 3**.

For a review of the hierarchy approach of Cloud Adoption Framework for Azure landing zones on Terraform, you can refer to [the following documentation](../../documentation/code_architecture/hierarchy.md).
                                              |

## Deploying CAF networking

Once you have picked a scenario for test, you can deploy it using:

```bash
rover -lz /tf/caf/landingzones/caf_mlops\
-level level3 \
-var-folder /tf/caf/landingzones/caf_mlops/scenario/100 \
-a apply
```

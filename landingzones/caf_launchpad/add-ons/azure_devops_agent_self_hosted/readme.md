# Cloud Adoption Framework for Azure - Landing zones on Terraform - Azure Devops (Self Hosted Agent) add-on

The Azure Devops add-ons allow you to setup you Azure Devops environment as a platform to automate all your subsequent landing zone deployment from level 0 until level 4 through Azure pipelines with self hosted agents deployed on Azure VMs.

* Azure Devops:
  - PAT Token Management
  - Agent Pools (Organization and Project Level)
  - Variable Groups
  - Pipelines
  - Service Endpoint

* Azure:
  - Virtual Machines: to host Azure Devops self hosted agent (level 0-4)
  - Storage Account: to store custom scripts for VMs extension to connect with Azure Devops

Azure Devops (Self Hosted Agent) add-on landing zone operates at **level 0**

For a review of the hierarchy approach of Cloud Adoption Framework for Azure landing zones on Terraform, you can refer to [the following documentation](../../documentation/code_architecture/hierarchy.md).

## Dependencies

Landing zone:
* CAF Launchpad

## Deployment

```bash
# Deploy
rover -lz /tf/caf/public/landingzones/caf_launchpad/add-ons/azure_devops_agent_self_hosted/ \
  -var-file /tf/caf/public/landingzones/caf_launchpad/add-ons/azure_devops_agent_self_hosted/configuration/devops_agents.tfvars \
  -level level0 \
  -a apply

# Destroy
rover -lz /tf/caf/landingzones/caf_launchpad/add-ons/azure_devops_agent_self_hosted/ -var-file /tf/caf/landingzones/caf_launchpad/add-ons/azure_devops_agent_self_hosted/configuration/devops_agents.tfvars -a destroy
```
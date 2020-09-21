# Add-n to deploy an Azure devops self-hosted agent on a vistual machine

## Dependencies

Landing zone:
* CAF Foundations

## Deployment

```bash
# Deploy
rover -lz /tf/caf/landingzones/caf_launchpad/add-ons/azure_devops_agent_self_hosted/ -var-file /tf/caf/landingzones/caf_launchpad/add-ons/azure_devops_agent_self_hosted/configuration/devops_agents.tfvars -a apply

# Destroy
rover -lz /tf/caf/landingzones/caf_launchpad/add-ons/azure_devops_agent_self_hosted/ -var-file /tf/caf/landingzones/caf_launchpad/add-ons/azure_devops_agent_self_hosted/configuration/devops_agents.tfvars -a destroy
```
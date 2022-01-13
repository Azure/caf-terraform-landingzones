# Cloud Adoption Framework for Azure - Landing zones on Terraform - Azure Devops Agent add-on

The Azure Devops Agent add-ons is the continuation of Self Hosted Agent implementation for Azure Devops environment that deployed in Azure Devops add on LZ. This will set up the underlying resources required for Agent in Azure.

* Azure Virtual Machine to host the Agent
* Azure VM Extension to connect the VM to Azure Devops self hosted agent
* Storage account to put the script for VM Extension
* Key Vault to store the SSH key of the VM

Azure Devops (Self Hosted Agent) add-on landing zone operates base on agent level for example for agent level0 will operates at **level 0** and agent level1 will operates at **level 1**

For a review of the hierarchy approach of Cloud Adoption Framework for Azure landing zones on Terraform, you can refer to [the following documentation](../../documentation/code_architecture/hierarchy.md).

## Dependencies

Landing zone:
* CAF Launchpad
* Azure DevOps add on (example: scenario 200-contoso_demo)

## Deployment

### Deploy the Azure Devops agent for level0
```bash
rover -lz /tf/caf/caf_launchpad/add-ons/azure_devops_agent \
  -tfstate level0_azure_devops_agents.tfstate \
  -var-folder /tf/caf/caf_launchpad/add-ons/azure_devops_agent/scenario/200-contoso_demo/level0 \
  -parallelism 30 \
  -level level0 \
  -env sandpit \
  -a apply
```

### Deploy the Azure Devops agent for level1
```bash
rover -lz /tf/caf/caf_launchpad/add-ons/azure_devops_agent \
  -tfstate azdo-agent-level1.tfstate \
  -var-folder /tf/caf/caf_launchpad/add-ons/azure_devops_agent/scenario/200-contoso_demo/level1 \
  -parallelism 30 \
  -level level1 \
  -env sandpit \
  -a apply


# If the tfstates are stored in a different subscription you need to execute the following command

rover -lz /tf/caf/caf_launchpad/add-ons/azure_devops_agent \
  -tfstate_subscription_id <ID of the subscription> \
  -tfstate azdo-agent-level1.tfstate \
  -var-folder /tf/caf/caf_launchpad/add-ons/azure_devops_agent/scenario/200-contoso_demo/level1 \
  -parallelism 30 \
  -level level1 \
  -env sandpit \
  -a apply
```
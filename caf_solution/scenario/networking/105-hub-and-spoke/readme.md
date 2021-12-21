# CAF landing zones for Terraform - Secure Hub and Spoke with Azure Firewall

This scenario deploys the networking hub across multiple regions

The networking landing zone allows you to deploy most networking topologies on Microsoft Azure. The same landing zone used with different parameters should allow you to deploy most network configurations.

* Hub and spoke
* Virtual WAN
* Application DMZ scenario
* Any custom network topology based on virtual networks or virtual WAN
* Library of network security groups definition

Networking landing zone operates at **level 2**.

For a review of the hierarchy approach of Cloud Adoption Framework for Azure landing zones on Terraform, you can refer to [the following documentation](../../../../documentation/code_architecture/hierarchy.md).

## Architecture diagram

This example allows you to deploy the following topology:

![101-example](../../documentation/img/105-hub-and-spoke.png)


## Components deployed by this example

| Component | Type of resource | Purpose |
|--|--|--|
| vnet-hub-re1, vnet-spoke-re2 | Resource group | resource group to host the virtual network |
| hub-re1, spoke-re1 | Virtual network | virtual networks for hub and spokeshub |
| AzureFirewallSubnet,jumphost, webapp-presentation-tier | Virtual Subnets | virtual subnets |
| azure_bastion_nsg, , jumphost_nsg | Network security groups | network security groups that can be attached to virtual subnets. |
| hub_re1_TO_spoke_re1, and spoke_re1_TO_hub_re1 | Virtual network peering | Peering between hub-re1 and spoke-re1 |
| azfwre1 | Azure Firewall | Azure Firewall in Hub network |
| az_fw_re1_pip1 | Public IP address | Public IP address used by Azure Firewall |
| default_to_firewall_re1 | Route table | Route table to host route entries |
| 0-0-0-0-through-firewall-re1 | Route table entry | Route all traffic to Azure Firewall in hub |


## Customizing this example

Please review the configuration files and make sure you are deploying in the expected region and with the expected settings.

## Deploying this example

Once you have picked a scenario for test, you can deploy it using:

```bash
rover -lz /tf/caf/caf_networking \
-level level2 \
-var-folder /tf/caf/caf_networking/scenario/105-hub-and-spoke \
-a apply
```

# CAF landing zones for Terraform - Single region hub virtual network

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

![100-example](../../documentation/img/100-single-region-hub.png)


## Components deployed by this example

| Component                                                                        | Type of resource        | Purpose                                                          |
|----------------------------------------------------------------------------------|-------------------------|------------------------------------------------------------------|
| vnet-hub-re1                                                                     | Resource group          | resource group to host the virtual network                       |
| vnet_hub_re1                                                                     | Virtual network         | virtual network used as a hub                                    |
| GatewaySubnet,AzureFirewallSubnet,AzureBastionSubnet, jumpbox, private_endpoints | Virtual Subnets         | virtual subnets                                                  |
| azure_bastion_nsg, empty_nsg, application_gateway, api_management, jumpbox       | Network security groups | network security groups that can be attached to virtual subnets. |


## Customizing this example

Please review the configuration files and make sure you are deploying in the expected region and with the expected settings.

## Deploying this example

Once you have picked a scenario for test, you can deploy it using:

```bash
rover -lz /tf/caf/caf_networking \
-level level2 \
-var-folder /tf/caf/caf_networking/scenario/100-single-region-hub \
-a apply
```

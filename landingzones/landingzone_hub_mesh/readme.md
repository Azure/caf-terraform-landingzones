# Introduction to hub and spoke mesh landing zone

Welcome to Azure Terraform hub and spoke topology architecture series.

This landing zone demo is a quick hub and spoke setup in order to setup a hub-spoke architecture for you to use in demo/POC.

**WARNING! This is demo-quality and code should have major refactoring at Terraform 0.13 using iterative structure to make it more reusable.**

For more reference on the Hub and Spoke topology using Azure Virtual WAN, please refer to the [Architecture Center](https://docs.microsoft.com/en-us/azure/virtual-wan)

## Capabilities

This landing zone allows you to easily create a Virtual WAN (Standard SKU) environment as well as flexible structure to onboard new HUB iteratively with its associated features:

- [Azure Firewall](https://docs.microsoft.com/en-us/azure/virtual-wan/howto-firewall)
- [Site to Site Gateway](https://docs.microsoft.com/en-us/azure/virtual-wan/virtual-wan-site-to-site-portal)
- [Point to Site Gateway](https://docs.microsoft.com/en-us/azure/virtual-wan/virtual-wan-point-to-site-portal)
- [Express Route Gateway](https://docs.microsoft.com/en-us/azure/virtual-wan/virtual-wan-expressroute-portal)
- [Peering Virtual Network to the region hub](https://docs.microsoft.com/en-us/azure/virtual-wan/virtual-wan-about)
- [Inter-hub and VNet-to-VNet transiting through the virtual hub](https://docs.microsoft.com/en-us/azure/virtual-wan/virtual-wan-global-transit-network-architecture)

## Prerequisites

This landing zone is a "level 2" type of landing zone, which **requires** you have deployed the foundations. The supported lower level landing zone is **landingzone_caf_foundations** which can be found in the same release and must have been applied successfully **before** applying this one.

## Overall architecture

The following diagram shows the environment we are deploying for this POC:

![Overall hub spoke demo diagram](../../_pictures/hub_spoke/virtual_wan_lz.png)

## Getting Started

To deploy a landing zone, use the execution environnement as described at the root of the landing zone repository.

## Deploying this landing zone

```
rover -lz /tf/caf/landingzones/landingzone_hub_mesh -a plan
```
Review the configuration and if you are ok with it, deploy it by running:
```
rover -lz /tf/caf/landingzones/landingzone_hub_mesh -a apply
```
Have fun playing with the landing zone an once you are done, you can simply delete the deployment using:
```
rover -lz /tf/caf/landingzones/landingzone_hub_mesh -a destroy
```

More details about this landing zone can also be found in the landing zone folder and its blueprints subfolders.

## Contribute

Pull requests are welcome to evolve the framework and integrate new features.

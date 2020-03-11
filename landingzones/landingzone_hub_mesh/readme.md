# Introduction to hub and spoke mesh landing zone

Welcome to Azure Terraform hub and spoke topology architecture series.

This landing zone demo is a quick hub and spoke setup in order to setup a hub-spoke architecture for you to use in demo/POC.

For more reference on the Hub and Spoke topology for Microsoft Azure, please refer to the [Architecture Center]()

## Prerequisites

This landing zone is a "level 2" type of landing zone, which **requires** you have deployed the foundations. The supported lower level landing zone is **landingzone_caf_foundations** which can be found in the same release and must have been applied successfully **before** applying this one.

## Overall architecture

The following diagram shows the environment we are deploying for this POC:

![Overall hub spoke demo diagram](../../_pictures/hub_spoke/hubspoke_overall.png)

## Getting Started

To deploy a landing zone, use the execution environnement as described at the root of the landing zone repository.

## Deploying this landing zone

```
rover /tf/caf/landingzones/landingzone_hub_mesh plan
```
Review the configuration and if you are ok with it, deploy it by running:
```
rover /tf/caf/landingzones/landingzone_hub_mesh apply
```
Have fun playing with the landing zone an once you are done, you can simply delete the deployment using:
```
rover /tf/caf/landingzones/landingzone_hub_mesh destroy
```

More details about this landing zone can also be found in the landing zone folder and its blueprints subfolders.

## Contribute

Pull requests are welcome to evolve the framework and integrate new features.

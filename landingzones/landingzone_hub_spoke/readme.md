# Introduction to Hub-spoke network topology in Azure landing zone

Welcome to Azure Cloud Adoption Framework Series.

This landing zone is an implementation of the following reference architecture: <https://docs.microsoft.com/en-us/azure/architecture/reference-architectures/hybrid-networking/hub-spoke>
. Current edition does not implement spoke virtual networks or resources but shall be added later.

## Prerequisites

This landing zone is a "level 2" type of landing zone, which **requires** you have deployed  the foundations. The supported lower level landing zone is **landingzone_caf_foundations** which can be found in the same release and must have been applied successfully **before** applying this one.

## Overall architecture

The following diagram shows the environment we are deploying for this POC:

![DMZ](../../_pictures/hub_spoke/hybrid-network-hub-spoke.png)

## Getting Started

To deploy a landing zone, use the execution environnement as described at the root of the landing zone repository.

## Deploying this landing zone

```
rover /tf/caf/landingzones/landingzone_hub_spoke plan
```
Review the configuration and if you are ok with it, deploy it by running:
```
rover /tf/caf/landingzones/landingzone_hub_spoke apply
```
Have fun playing with the landing zone an once you are done, you can simply delete the deployment using:
```
rover /tf/caf/landingzones/landingzone_hub_spoke destroy
```

More details about this landing zone can also be found in the landing zone folder and its blueprints sub-folders.

## Contribute

Pull requests are welcome to evolve the framework and integrate new features.

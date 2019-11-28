# Introduction to hub and spoke demo landing zone

Welcome to Azure Terraform hub and spoke topology architecture demo.

This landing zone demo is a simplified hub and spoke architecture for you to use in demo/POC.

The choice of multiple blueprints and virtual networks might not fit all customer scenario but should illustrate how to compose an environnement and provide a code base to create your desired topology.

## Overall architecture

The following diagram shows the environment we are deploying for this POC:

![Overall hub spoke demo diagram](https://github.com/aztfmod/landingzones/blob/master/landingzone_vdc_demo/docs/diagram-overall.png)

## Getting Started

To deploy a landing zone, use the execution environement as described at the root of the landing zone repository.

## Deploying this landing zone

```
./rover landingzones/landingzone_vdc_demo plan
```
Review the configuration and if you are ok with it, deploy it by running:
```
./rover landingzones/landingzone_vdc_demo apply
```
Have fun playing with the landing zone an once you are done, you can simply delete the deployment using:
```
./rover landingzones/landingzone_vdc_demo destroy
```

More details about this landing zone can also be found in the landing zone folder and its blueprints subfolders.

<br/>

# Contribute
Pull requests are welcome to evolve the framework and integrate new features.

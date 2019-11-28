# Introduction 
Welcome to Azure Terraform VDC demo.

The VDC landing zone demo is a simplified Virtual Datacenter Prototype for you to use in demo/POC, feel free to use/reuse/hack and contribute.

# Overall architecture
The following diagram shows the environment we are deploying for this POC: 
![Overall VDC Demo Diagram](https://github.com/aztfmod/landingzones/blob/master/landingzone_vdc_demo/docs/diagram-overall.png)


# Getting Started
To deploy a landingzone, install the rover on your machine as described in the Readme of the rover git repository

https://github.com/aztfmod/rover

## Deploy your first landingzone (vdc_demo) 

```
./rover.sh landingzones/landingzone_vdc_demo plan
```
Review the configuration and if you are ok with it, deploy it by running: 
```
./rover.sh landingzones/landingzone_vdc_demo apply
```
Have fun playing with the landing zone an once you are done, you can simply delete the deployment using: 
```
./rover.sh landingzones/landingzone_vdc_demo destroy
```
More details about the landing zone can be found in the landing zone folder ./landingzone_vdc_demo and its blueprints subfolders

<br/>

# Contribute
Pull requests are welcome to evolve the framework and integrate new features.

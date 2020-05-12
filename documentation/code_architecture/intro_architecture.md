# Introduction to Azure Landing Zones components

Azure Landing Zones assist deployment of a complete Azure environment based on the [Azure Cloud Adoption Framework](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/). The solution in this repository consists of the following components:

![Overview](../../_pictures/code_architecture/components.png)

## DevOps Toolset

In order to bootstrap an environment, we provide the following minimal DevOps components tools.

### rover

[Source here](https://github.com/aztfmod/rover)

The "rover" is part of the fundamental tool set of the Azure Cloud Adoption Framework Landing Zones, fascilitating deployment of all the landing zones in a consistent and automated way.

+ It is a Docker container running on all platforms transparently: Windows, Linux, Mac.
+ Allows validated **versioned** tool set
+ Preserves stability across components versions
+ Facilitates testing different versions of binaries (new version of Terraform, Azure CLI, etc.)
+ Facilitates the transition to CI/CD
+ Simplifies setup across DevOps teams ensuring everyone has a consistent environment and set of tools
+ Integrates standard Cloud Adoption Framework and demo landing zones

![Rover](../../_pictures/code_architecture/rover.png)

### launchpad

[Source here](https://github.com/aztfmod/level0)

Launchpad is the toolbox to deploy and manage the fundamentals of a deployment:

+ Manage the Terraform states
+ Manage different environments (subscriptions, accounts, etc.)
+ Bootstrap initial blueprints

![Launchpad](../../_pictures/code_architecture/launchpad.png)

In order to manage different subscriptions and environment, the launchpad relies on **level0 blueprints**

A level0 blueprint is the foundation of account and subscription management.  A level0 blueprint defines:

+ How to store and retrieve the Terraform state
+ Core secrets protection for the Terraform state
+ Management of the principals or identities for a complex environnement
+ How to access/partition the different subscriptions

Currently we support an open source version of [level0 blueprints](https://github.com/aztfmod/level0). We are currently working on a [Terraform Cloud](https://www.terraform.io/docs/cloud/index.html) edition of level0 blueprint, feel free to join the corresponding working Channel on Teams.

## Modules

[Source here](https://github.com/aztfmod/)

Cloud Adoption Framework maintains a set of curated modules. We mainly use module to enforce a consistent set of configuration settings and requirements.

Modules must have a strong versioning, in the CAF modules, we use semantic versioning, and all modules are published on the [Hashicorp Terraform registry](https://registry.terraform.io/modules/aztfmod)

![Modules](../../_pictures/code_architecture/modules.png)

## Blueprints, or services

[Source here](https://github.com/aztfmod/blueprints)

A blueprint is a reusable set of infrastructure components put together to deliver a service. In its structure, it calls a set of modules, and may call resources directly in order to stitch components together.

![Blueprints](../../_pictures/code_architecture/blueprints.png)

## Landing zone

[Source here](https://github.com/aztfmod/landginzones)

A landing zone is a composite of multiple blueprints and resources delivering a full application environment.

The landing zone is **responsible** for the **Terraform state**, and exports outputs to be reused by other landing zones.

The delivery of a full landing zone might be decomposed in multiples levels in order to manage different personas and contain the blast radius a mistake could incur in one landing zone.

![Landingzone](../../_pictures/code_architecture/landingzone.png)

[Back to summary](../README.md)
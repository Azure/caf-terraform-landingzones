![landingzones](https://github.com/Azure/caf-terraform-landingzones/workflows/landingzones/badge.svg)

# Azure Cloud Adoption Framework landing zones for Terraform

Microsoft [Cloud Adoption Framework for Azure](https://aka.ms/caf) provides you with guidance and best practices to adopt Azure.

A landing zone is a segment of a cloud environment, that has been preprovisioned through code, and is dedicated to the support of one or more workloads. Landing zones provide access to foundational tools and controls to establish a compliant place to innovate and build new workloads in the cloud, or to migrate existing workloads to the cloud. Landing zones use defined sets of cloud services and best practices to set you up for success.

Components parts of the Cloud Adoption Framework for Azure Terraform landing zones:

![caf_elements](./_pictures/caf_elements.png)

## Goals

Cloud Adoption Framework for Azure Terraform landing zones is an Open Source project with the following objectives:

* Enable the community with a set of sample reusable landing zones.
* Standardize deployments using battlefield-proven components.
* Accelerate the setup of complex environments on Azure.
* Propose an enterprise-grade approach to adopting Terraform on Microsoft Azure using Cloud Adoption Framework.
* Propose a prescriptive guidance on how to enable DevOps for infrastructure as code on Microsoft Azure.
* Foster a community of Azure *Terraformers* using a common set of practices and sharing best practices.

## Getting started

See our [Getting Started](./documentation/getting_started/getting_started.md)

## Documentation

More details on how to develop, deploy and operate with landing zones can be found in the reference section [here](./documentation/README.md)

## Sample landing zones

Currently we provide you with the following sample landing zones:

| Name                                                                       | Purpose | Depends on | Tested with launchpad
| -------------------------------------------------------------------------- | ---------------- | -- | -- |
| [landingzone_caf_foundations](./landingzones/landingzone_caf_foundations)  | setup all the fundamentals for a subscription (logging, accounting, security.). You can find all details of the caf_foundations landing zone [Here](./landingzones/landingzone_caf_foundations/readme.md) | N/A | launchpad_opensource_light, launchpad_opensource |
| [landingzone_hub_spoke](./landingzones/landingzone_hub_spoke)              | example of [hub and spoke environment](https://docs.microsoft.com/en-us/azure/architecture/reference-architectures/hybrid-networking/hub-spoke) documentation [here](./landingzones/landingzone_hub_spoke/readme.md) | landingzone_caf_foundations | launchpad_opensource_light, launchpad_opensource |
| [landingzone_vdc_demo](./landingzones/landingzone_vdc_demo)                | setup a demo environment of a hub-spoke topology including shared services, as well as various DMZ (ingress, egress, transit). You can find all details of the vdc_demo landing zone [Here](./landingzones/landingzone_vdc_demo/readme.md)| landingzone_caf_foundations | launchpad_opensource_light, launchpad_opensource |
| [landingzone_secure_vnet_dmz](./landingzones/landingzone_secure_vnet_dmz)  | (preview) this is an early implementation of the reference architecture [secure_vnet_dmz](https://docs.microsoft.com/en-gb/azure/architecture/reference-architectures/dmz/secure-vnet-dmz). This is a work in progress used to illustrate landing zone creation process as described [here](./documentation/code_architecture/how_to_code_a_landingzone.md) . You can find all details of the secure vnet dmz landing zone [Here](./landingzones/landingzone_secure_vnet_dmz/readme.md)| landingzone_caf_foundations | launchpad_opensource_light, launchpad_opensource |
| [landingzone_starter](./landingzones/landingzone_starter)                  | this is an empty landing zones to use as a template to develop a level 2 landing zone. You can find all details of the starter landing zone [Here](./landingzones/landingzone_starter/readme.md)| landingzone_caf_foundations | launchpad_opensource_light, launchpad_opensource |

## Repositories

| Repo | Description |
| -----| ------------|
| [caf-terraform-landingzones](https://github.com/azure/caf-terraform-landingzones) (You are here!) | landing zones repo with sample and core documentations |
| [rover](https://github.com/aztfmod/rover) | devops toolset for operating landing zones |
| [launchpads](https://github.com/aztfmod/level0) | launchpads to support landing zones deployments |
| [azure_caf_provider](https://github.com/aztfmod/terraform-provider-azurecaf) | custom provider for naming conventions |
| [modules](https://registry.terraform.io/modules/aztfmod) | set of curated modules available in the Terraform registry |


## Community

Feel free to open an issue for feature or bug, or to submit a PR.

In case you have any question, you can reach out to tf-landingzones at microsoft dot com.

You can also reach us on [Gitter](https://gitter.im/aztfmod/community?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)

## Contributing

This project welcomes contributions and suggestions.  Most contributions require you to agree to a
Contributor License Agreement (CLA) declaring that you have the right to, and actually do, grant us
the rights to use your contribution. For details, visit https://cla.opensource.microsoft.com.

When you submit a pull request, a CLA bot will automatically determine whether you need to provide
a CLA and decorate the PR appropriately (e.g., status check, comment). Simply follow the instructions
provided by the bot. You will only need to do this once across all repos using our CLA.

## Code of conduct

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/).
For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or
contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.

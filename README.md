![landingzones](https://github.com/Azure/caf-terraform-landingzones/workflows/landingzones/badge.svg)
![landingzones-vnext](https://github.com/Azure/caf-terraform-landingzones/workflows/landingzones-vnext/badge.svg?branch=vnext)
[![VScodespaces](https://img.shields.io/endpoint?url=https%3A%2F%2Faka.ms%2Fvso-badge)](https://online.visualstudio.com/environments/new?name=caf%20landing%20zones&repo=azure/caf-terraform-landingzones)
[![Gitter](https://badges.gitter.im/aztfmod/community.svg)](https://gitter.im/aztfmod/community?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)


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

See our [Getting Started](./documentation/getting_started/getting_started.md) on your laptop, or on the web with [Getting Started on VSCodespaces](./documentation/getting_started/getting_started_codespaces.md).

See our [Getting Started Video](https://www.youtube.com/watch?v=t1exCkWft60)

## Documentation

More details on how to develop, deploy and operate with landing zones can be found in the reference section [here](./documentation/README.md)

## Sample landing zones

Currently we provide you with the following sample landing zones:

| Name                                                                      | Purpose                                                                                                                                                                                                   |
|---------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [landingzone_caf_foundations](./landingzones/landingzone_caf_foundations) | setup all the fundamentals for a subscription (logging, accounting, security.). You can find all details of the caf_foundations landing zone [Here](./landingzones/landingzone_caf_foundations/readme.md) |
| [landingzone_networking](./landingzones/landingzone_networking)           | enables creation of any Azure networking combination of Virtual Networks-based hub-and-spoke topologies or Azure Virtual WAN based topologies.                                                            |
| [launchpad](./landingzones/launchpad) | provides the state management capabilities and security features leveraging Azure storage for the backend, provides secret management and modular approach to support plugin for Azure DevOps automated pipeline creation (and others)        |

## Repositories

| Repo                                                                                              | Description                                                |
|---------------------------------------------------------------------------------------------------|------------------------------------------------------------|
| [caf-terraform-landingzones](https://github.com/azure/caf-terraform-landingzones) (You are here!) | landing zones repo with sample and core documentations     |
| [rover](https://github.com/aztfmod/rover)                                                         | devops toolset for operating landing zones                 |
| [azure_caf_provider](https://github.com/aztfmod/terraform-provider-azurecaf)                      | custom provider for naming conventions                     |
| [modules](https://registry.terraform.io/modules/aztfmod)                                          | set of curated modules available in the Terraform registry |

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

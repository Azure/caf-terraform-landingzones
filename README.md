![landingzones](https://github.com/Azure/caf-terraform-landingzones/workflows/landingzones/badge.svg)
[![Gitter](https://badges.gitter.im/aztfmod/community.svg)](https://gitter.im/aztfmod/community?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)

# Cloud Adoption Framework for Azure landing zones on Terraform

Microsoft [Cloud Adoption Framework for Azure](https://docs.microsoft.com/azure/cloud-adoption-framework/overview) provides you with guidance and best practices to adopt Azure.

A landing zone is a segment of a cloud environment, that has been pre-provisioned through code, and is dedicated to the support of one or more workloads. Landing zones provide access to foundational tools and controls to establish a compliant place to innovate and build new workloads in the cloud, or to migrate existing workloads to the cloud. Landing zones use defined sets of cloud services and best practices to set you up for success.

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

When starting an enterprise deployment, we recommend you start creating a configuration repository where you craft the configuration files for your environments.

You can find the [starter repository here](https://github.com/Azure/caf-terraform-landingzones-starter) and our sample configuration [onboarding video here](https://www.youtube.com/watch?v=M5BXm30IpdY)

## Documentation

More details on how to develop, deploy and operate with landing zones can be found in the reference section [here](./documentation/README.md)

## Sample landing zones

Currently we provide you with the following core sample landing zones:

| Name | Level | Purpose |
|--|--|--|
| [caf_launchpad](./caf_launchpad) |  0 | provides the state management capabilities and security features leveraging Azure storage for the backend, provides secret management and modular approach to support plugin for Azure DevOps automated pipeline creation (and others) |
| [caf_solution](./caf_solution) | 1-4 | "universal" landing zone that allow you to compose with any object from the CAF module and beyond. |


## Repositories

| Repo                                                                                              | Description                                                |
|---------------------------------------------------------------------------------------------------|------------------------------------------------------------|
| [starter kit](https://github.com/azure/caf-terraform-landingzones-starter)                        | landing zones configuration repository                     |
| [caf-terraform-landingzones](https://github.com/azure/caf-terraform-landingzones) (You are here!) | landing zones repo with sample and core documentations     |
| [rover](https://github.com/aztfmod/rover)                                                         | devops toolset for operating landing zones                 |
| [azure_caf_provider](https://github.com/aztfmod/terraform-provider-azurecaf)                      | custom provider for naming conventions                     |
| [module](https://github.com/aztfmod/terraform-azurerm-caf)                                        | CAF universal module available in the Terraform registry   |

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

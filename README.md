![landingzones](https://github.com/Azure/caf-terraform-landingzones/workflows/landingzones/badge.svg)
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

## What's new in this release

This release is relying extensively on Terraform 0.13 capabilities (module iterations, conditional modules, variables validation, etc.).

Those new features allow more complex and more dynamic code composition. The following concepts are used:

* **No-code environment composition**: a landing zone environment can be composed customizing variable files and code must be robust enough to accommodate combinations and composition.
* **Flexible foundations to meet customer needs**: everything is customizable at all layers.
* **Key-based configuration and customization**: all configuration objects will call each other based on the object keys.
* **Iteration-based objects deployment**: a landing zone calls all its modules, iterating on complex objects for technical resources deployment.
* **Enterprise-scale support**: added support for foundations landing zones to optionally leverage Azure Enterprise-scale module.
* **Terraform Cloud/Enterprise bootstrap**: added initial support for Hashicorp Terraform Cloud/Enterprise to support environment bootstrap.

## Getting started

See our [Getting Started](./documentation/getting_started/getting_started.md) on your laptop, or on the web with [Getting Started on VSCodespaces](./documentation/getting_started/getting_started_codespaces.md).

See our [Getting Started Video](https://www.youtube.com/watch?v=t1exCkWft60)

## Sample configuration repository

When starting an enterprise deployment, we recommend you start creating a configuration repository where you start crafting you configuration environment.

You can find the [starter repository here](https://github.com/Azure/caf-terraform-landingzones-starter) and our sample configuration [onboarding video here](https://www.youtube.com/watch?v=M5BXm30IpdY)

## Documentation

More details on how to develop, deploy and operate with landing zones can be found in the reference section [here](./documentation/README.md)

## Sample landing zones

Currently we provide you with the following core sample landing zones:

| Name                                                      | Purpose                                                                                                                                                                                                                                |
|-----------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [caf_foundations](./landingzones/caf_foundations)         | setup all the fundamentals for a subscription (logging, accounting, security.). You can find all details of the caf_foundations landing zone [Here](./landingzones/landingzone_caf_foundations/readme.md)                              |
| [caf_networking](./landingzones/caf_networking)           | enables creation of any Azure networking combination of Virtual Networks-based hub-and-spoke topologies or Azure Virtual WAN based topologies.                                                                                         |
| [caf_shared_services](./landingzones/caf_shared_services) | provides shared services like monitoring, Azure Backup, Azure Site Recovery etc.                                                                                                                                                       |
| [caf_launchpad](./landingzones/caf_launchpad)             | provides the state management capabilities and security features leveraging Azure storage for the backend, provides secret management and modular approach to support plugin for Azure DevOps automated pipeline creation (and others) |

For each landing zones, we provide different level of configuration examples to meet different purposes:
| level | scenario                                                                                                                               | requirements                                       |
|-------|----------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------|
| 100   | Start with this one! basic functionalities and features, no RBAC or security hardening - for demo and simple POC                       | working on any subscription with Owner permissions |
| 200   | intermediate functionalities includes diagnostics features and Azure Active Directory groups                                           | may need custom AAD permissions                    |
| 300   | advanced functionalities, includes RBAC features, virtual network and private link scenario and reduced portal view for hardened items | need custom AAD permissions                        |
| 400   | advanced functionalities, includes RBAC features and security hardening                                                                | need custom AAD permissions                        |

## Landing zone solutions

Once you deploy the core components, you can leverage the following additional solution landing zones (work in progress!):

| Solution                  | URL                                                   |
|---------------------------|-------------------------------------------------------|
| Azure Kubernetes Services | https://github.com/aztfmod/landingzone_aks            |
| Data and Analytics        | https://github.com/aztfmod/landingzone_data_analytics |
| SAP HANA on Azure         | Coming Soon                                           |
| Shared Image Gallery      | Coming soon                                           |

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

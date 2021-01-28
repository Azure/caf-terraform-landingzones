## v9.0.2009 (September 2020)

BREAKING CHANGES:

* Iterating on our new key-based iterative model to simplify deployment and maintenance, this is a major refactoring that will bring compatibility with enterprise-scale landing zones and extensible platform for construction sets (solutions and applications) deployed on top of core landing zones.

FEATURES:
* **added support for azurerm 2.28 :** On all sample landing zones [azurerm provider](https://github.com/terraform-providers/terraform-provider-azurerm/releases/tag/v2.28.0)

## v8.0.2008 (August 2020)

BREAKING CHANGES:

* We have fully migrated the codebase to Terraform 0.13 and refactored the code rely on a new key-based iterative model to simplify deployment and maintenance. We also leverage new features like conditions and iterations on modules, variables validation, etc.

FEATURES:

* **added support for azurerm 2.25 :** On all sample landing zones [azurerm provider](https://github.com/terraform-providers/terraform-provider-azurerm/releases/tag/v2.25.0)
* **landingzone_caf_foundations :** Refactoring foundations to use new key-based iterative model, enabling support for multi-regions foundations.
* **landingzone_networking :** Refactoring networking landing zones to use new key-based iterative model, this is enabling support for all networking models in only one landing zone.


## v7.0.2007 (July 2020)

BREAKING CHANGES:

* Update to rover syntax, as documented in landing zones, syntax is now: rover -lz <lz name> -a <plan|apply|delete> (refer to Getting started and landing zones readmes)

FEATURES:

* **launchpad:** introduced support for Azure DevOps Addons and Azure DevOps self hosted agents.
* **added support for azurerm 2.20 :** On all sample landing zones [azurerm provider](https://github.com/terraform-providers/terraform-provider-azurerm/releases/tag/v2.20.0)
* **rover :** upgrade to rover 2007: - support for Terraform 0.29 - [#61](https://github.com/aztfmod/rover/issues/61)
* **rover :** support for rover in Azure Container Instance - [#62](https://github.com/aztfmod/rover/issues/62)
* **landingzone_caf_foundations :** Fixed passing in the list of supported services- [#61](https://github.com/Azure/caf-terraform-landingzones/issues/61)

## v6.0.2006 (June 2020)

BREAKING CHANGES:

* New launchpad. You must destroy the 2005:1510 first before redeploying this version of the launchpad.

FEATURES:

* **feature:** Update new Azure Activity Logs capability [#39](https://github.com/Azure/caf-terraform-landingzones/issues/39)
* **feature:** New landing_zone for networking using hub spoke with Azure Virtual WAN [#41](https://github.com/Azure/caf-terraform-landingzones/issues/41)
* **feature:** Support for NSG naming, extended fields, and update to address-prefixes [#44](https://github.com/Azure/caf-terraform-landingzones/issues/44)
* **feature:** Added support for [Visual Studio Codespaces](https://online.visualstudio.com/environments/new?name=caf%20landing%20zones&repo=azure/caf-terraform-landingzones)
* **workspace:** Increased command history, tab size set to 2 and eol settings.
* **rover :** upgrade to rover 2006 - support for Terraform 0.28 - added toolset for development and bootstrap process, decoupling launchpad and rover.
* **added support for azurerm 2.16 :** On all sample landing zones [azurerm provider](https://github.com/terraform-providers/terraform-provider-azurerm/releases/tag/v2.16.0)
* **documentation :** Iterating on documentation, adding clarifications on component roles, modules engineering criteria, architecture and delivery techniques.

DEPRECATED:
* launchpad command has been merged into the rover command. See getting started.

## v5.1.2005 (May 2020)

FEATURES:

* **rover :** upgrade to rover 2005.1510 - improved support for Azure DevOps and GitHub Actions
* **added support for azurerm 2.11 :** On all sample landing zones [azurerm provider](https://github.com/terraform-providers/terraform-provider-azurerm/releases/tag/v2.11.0)
* **documentation :** revamp doc and added guidance on Azure DevOps and GitHub actions pipelines [#28](https://github.com/Azure/caf-terraform-landingzones/issues/28)

## v5.0.2005 (May 2020)

FEATURES:

* **rover :** upgrade to rover 2005.1314 - improved support for Azure DevOps and GitHub Actions
* **added support for azurerm 2.9 :** On all sample landing zones [azurerm provider](https://github.com/terraform-providers/terraform-provider-azurerm/releases/tag/v2.9.0)
* **documentation :** added guidance and documentation on LZ hierarchy and delivery [#32](https://github.com/Azure/caf-terraform-landingzones/pull/32)
* **devops :** added GitHub actions workflows to implement integration tests on public repository [25](https://github.com/Azure/caf-terraform-landingzones/issues/25)

BUGFIXES:

* **landingzone_caf_foundations :** Avoid creating unnecessary policy definitions [#33](https://github.com/Azure/caf-terraform-landingzones/pull/33)
* **landingzone_hub_spoke :** Setting "enable_bastion = false" not working [#34](https://github.com/Azure/caf-terraform-landingzones/issues/34)
* **rover :** launchpad opensource light fails to deploy successfully [#18](
https://github.com/aztfmod/landingzones/issues/18)

## v3.0.2003 (March 2020)

FEATURES:

* **rover :** upgrade to rover 2004.0211 - added support for Terraform v0.12.24
* **added support for azurecaf provider :** Overall usage of new [azurecaf provider](https://github.com/aztfmod/terraform-provider-azurecaf) for naming convention
* **landingzone_hub_spoke :** introducing landingzone_hub_spoke as a sample of hub and spoke topology [#13](
https://github.com/Azure/caf-terraform-landingzones/issues/13)
* **landingzone_caf_foundations :** Added toggle feature for management group deployment control (disabled by default)
* **landingzone_caf_foundations :** Added support for azurerm 2.4 [#23](
https://github.com/Azure/caf-terraform-landingzones/issues/23)
* **landingzone_vdc_demo:** Added support for azurerm 2.4 [#23](
https://github.com/Azure/caf-terraform-landingzones/issues/23)
* **landingzone_secure_vnet_dmz:** Added support for azurerm 2.4 [#23](
https://github.com/Azure/caf-terraform-landingzones/issues/23)

## v2.2.2002 (February 2020)

FEATURES:

* **landingzone_starter :** introducing landingzone_starter as a level 2 landing zone for deployment on top of caf_foundations.
* **landingzone_secure_vnet_dmz :** introducing landingzone_secure_vnet_dmz as a new example for landing zone authoring relasted to [documentation](./documentation/code_architecture/how_to_code_a_landingzone.md) for deployment on top of caf_foundations.

## v2.1.2002 (February 2020)

FEATURES:

* **landingzone_vdc_demo :** refactor to use landingzone_caf_foundations as lower level [#12](
https://github.com/aztfmod/landingzones/issues/12)
* **landingzone_vdc_demo :** refresh of module versions to latest [#12](
https://github.com/aztfmod/landingzones/issues/12)
* **overall :** upgrade to latest azurerm provider [1.44](https://github.com/terraform-providers/terraform-provider-azurerm/blob/v1.44.0/CHANGELOG.md)

BUGFIXES:

* **rover :** launchpad opensource light fails to deploy successfully [#18](
https://github.com/aztfmod/landingzones/issues/18)

## v2.0.2002 (February 2020)

FEATURES:

* **landingzone_caf_foundations :** adding support for azurerm 1.42 provider, azuread provider 0.7
* **landingzone_vdc_demo :** adding support for azurerm 1.42 provider, azuread provider 0.7
* **rover:** rollup upgrade to support workspaces [#15](https://github.com/aztfmod/landingzones/pull/15)
* **launchpad:** Support for launchpad destroy [#16](
https://github.com/aztfmod/level0/issues/16)
* **rover:** Upgrade to rover version 2002.0320 - Supporting: - Terraform 0.12.20 (https://github.com/hashicorp/terraform/releases/tag/v0.12.20)
* **rover:** Using "4ops.terraform" extension for improved support of Terraform 0.12 syntax. [#16](https://github.com/aztfmod/landingzones/issues/16)

## v1.1.1912 (January 2020)

FEATURES:

* **landingzone_caf_foundations :** Major refactoring to support governance, security and accounting.

IMPROVEMENTS:

* **rover:** Support for non root containers in Visual Studio Code Development Containers (>v1.40)

* **rover:** Upgrade to rover version 2001.1006 - Supporting: - Terraform 0.12.19 (https://github.com/hashicorp/terraform/releases/tag/v0.12.19) - azurerm provider 1.40 (https://github.com/terraform-providers/terraform-provider-azurerm/blob/v1.40.0/CHANGELOG.md )

* **rover:** Restructured the folder hierarchy in landing zones to ease integration and development on standard landing zones.

* **documentation:** Instructions on rover updates for non root container and Docker volumes cleanup.

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

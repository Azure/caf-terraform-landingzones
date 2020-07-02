##create the RG for the virtual WAN
resource "azurecaf_naming_convention" "rg_virtualwan" {
  name          = var.virtual_hub_config.virtual_wan.resource_group_name
  prefix        = local.prefix != "" ? local.prefix : null
  resource_type = "azurerm_resource_group"
  convention    = local.global_settings.convention
  max_length    = 25
}

resource "azurecaf_naming_convention" "virtualwan" {
  name          = var.virtual_hub_config.virtual_wan.name
  prefix        = local.prefix != "" ? local.prefix : null
  resource_type = "azurerm_virtual_network"
  # need to create a naming convention method for it
  convention = local.global_settings.convention
  max_length = 25
}

resource "azurerm_resource_group" "rg_virtualwan" {
  name     = azurecaf_naming_convention.rg_virtualwan.result
  location = local.global_settings.location_map.region1
  tags     = local.tags
}

## Create the global private DNS zone
resource "azurerm_dns_zone" "connectivity_dns" {
  name                = var.virtual_hub_config.virtual_wan.dns_name
  resource_group_name = azurerm_resource_group.rg_virtualwan.name
  tags                = local.tags
}

## Create the global virtual WAN
resource "azurerm_virtual_wan" "vwan" {
  name                = azurecaf_naming_convention.virtualwan.result
  resource_group_name = azurerm_resource_group.rg_virtualwan.name
  location            = local.global_settings.location_map.region1
  tags                = local.tags

  type                              = lookup(var.virtual_hub_config.virtual_wan, "type", null)
  disable_vpn_encryption            = lookup(var.virtual_hub_config.virtual_wan, "disable_vpn_encryption", null)
  allow_branch_to_branch_traffic    = lookup(var.virtual_hub_config.virtual_wan, "allow_branch_to_branch_traffic", null)
  allow_vnet_to_vnet_traffic        = lookup(var.virtual_hub_config.virtual_wan, "allow_vnet_to_vnet_traffic", null)
  office365_local_breakout_category = lookup(var.virtual_hub_config.virtual_wan, "office365_local_breakout_category", null)
}

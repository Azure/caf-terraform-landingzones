##create the RG for the virtual WAN
resource "azurerm_resource_group" "rg_virtualwan" {
  name     = "${local.prefix}${var.resource_groups_virtual_hubs.hub1.name}"
  location = local.global_settings.location_map.region1
  tags     = local.global_settings.tags_hub
}

## Create the global private DNS zone
resource "azurerm_dns_zone" "connectivity_dns" {
  name                = var.virtual_hub_config.virtual_wan.dns_name
  resource_group_name = azurerm_resource_group.rg_virtualwan.name
  tags                = local.global_settings.tags_hub
}

## Create the global virtual WAN
resource "azurerm_virtual_wan" "vwan" {
  name                = var.virtual_hub_config.virtual_wan.name
  resource_group_name = azurerm_resource_group.rg_virtualwan.name
  location            = local.global_settings.location_map.region1
  tags                = local.global_settings.tags_hub

  disable_vpn_encryption = lookup(var.virtual_hub_config.virtual_wan, "disable_vpn_encryption", null)
  allow_branch_to_branch_traffic = lookup(var.virtual_hub_config.virtual_wan, "allow_branch_to_branch_traffic", null)
  allow_vnet_to_vnet_traffic = lookup(var.virtual_hub_config.virtual_wan, "allow_vnet_to_vnet_traffic", null)
  office365_local_breakout_category = lookup(var.virtual_hub_config.virtual_wan, "office365_local_breakout_category", null)
}

## create a virtual hub with settings for a region
module "virtual_hub_region1" {
    source = "./virtual_hub"
    
    global_settings                     = local.global_settings
    prefix                              = local.prefix
    caf_foundations_accounting          = local.caf_foundations_accounting
    
    location                            = var.virtual_hub_config.virtual_wan.hub1.region
    virtual_hub_config                  = var.virtual_hub_config.virtual_wan.hub1

    rg                                  = azurerm_resource_group.rg_virtualwan.name
    vwan_id                             = azurerm_virtual_wan.vwan.id
}

module "virtual_hub_region2" {
    source = "./virtual_hub"
  
    global_settings                     = local.global_settings
    prefix                              = local.prefix
    caf_foundations_accounting          = local.caf_foundations_accounting
    
    location                            = var.virtual_hub_config.virtual_wan.hub2.region
    virtual_hub_config                  = var.virtual_hub_config.virtual_wan.hub2

    rg                                  = azurerm_resource_group.rg_virtualwan.name
    vwan_id                             = azurerm_virtual_wan.vwan.id
}
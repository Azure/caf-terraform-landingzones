## TODO TF13: loop iterate on the module
## create a virtual hub with settings for a region
module "virtual_hub_region1" {
  source = "./virtual_hub"

  global_settings            = local.global_settings
  prefix                     = local.prefix
  caf_foundations_accounting = local.caf_foundations_accounting

  location           = var.virtual_hub_config.virtual_wan.hubs.hub1.region
  virtual_hub_config = var.virtual_hub_config.virtual_wan.hubs.hub1

  resource_group_name           = azurerm_resource_group.rg_virtualwan.name
  firewall_resource_groupe_name = var.virtual_hub_config.virtual_wan.hubs.hub1.firewall_resource_groupe_name
  vwan_id                       = azurerm_virtual_wan.vwan.id
  tags                          = local.tags
}

module "virtual_hub_region2" {
  source = "./virtual_hub"

  global_settings            = local.global_settings
  prefix                     = local.prefix
  caf_foundations_accounting = local.caf_foundations_accounting

  location           = var.virtual_hub_config.virtual_wan.hubs.hub2.region
  virtual_hub_config = var.virtual_hub_config.virtual_wan.hubs.hub2

  resource_group_name           = azurerm_resource_group.rg_virtualwan.name
  firewall_resource_groupe_name = var.virtual_hub_config.virtual_wan.hubs.hub2.firewall_resource_groupe_name
  vwan_id                       = azurerm_virtual_wan.vwan.id
  tags                          = local.tags
}


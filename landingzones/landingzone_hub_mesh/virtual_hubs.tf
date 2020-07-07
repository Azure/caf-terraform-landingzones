## create a virtual hub with settings for a region
module "virtual_hub" {
  source = "./virtual_hub"
  for_each = var.virtual_hub_config.virtual_wan.hubs
  
  global_settings            = local.global_settings
  prefix                     = local.prefix
  caf_foundations_accounting = local.caf_foundations_accounting

  location           = each.value.region
  virtual_hub_config = each.value

  resource_group_name           = azurerm_resource_group.rg_virtualwan.name
  firewall_resource_groupe_name = each.value.firewall_resource_groupe_name
  vwan_id                       = azurerm_virtual_wan.vwan.id
  tags                          = local.tags
}
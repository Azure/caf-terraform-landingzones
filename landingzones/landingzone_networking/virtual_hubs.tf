## create a virtual hub with settings for a region
locals {
  hubs = flatten(
    [
      for vwan_keys, vwan in var.vwans : [
        for hub_keys, hub in vwan.hubs : {
          key                = vwan_keys
          vwan               = vwan_keys
          resource_group_key = vwan.resource_group_key
          hub_key            = hub_keys
          hub                = hub
        }
      ]
  ])
}

module "virtual_hub" {
  source = "./virtual_hub"

  for_each = {
    for hub in local.hubs : "${hub.key}.${hub.hub_key}" => hub
  }

  global_settings            = local.global_settings
  prefix                     = local.prefix
  caf_foundations_accounting = local.caf_foundations_accounting

  location           = each.value.hub.region
  virtual_hub_config = each.value.hub

  resource_group_name           = azurerm_resource_group.rg[each.value.resource_group_key].name
  firewall_resource_groupe_name = each.value.hub.firewall_resource_groupe_name
  vwan_id                       = azurerm_virtual_wan.vwan[each.value.vwan].id
  tags                          = local.tags
}
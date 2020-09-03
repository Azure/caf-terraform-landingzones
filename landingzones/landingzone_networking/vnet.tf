module "vnets" {
  source  = "aztfmod/caf-virtual-network/azurerm"
  version = "3.1.0"

  for_each = var.vnets

  convention              = local.global_settings.convention
  resource_group_name     = azurerm_resource_group.rg[each.value.resource_group_key].name
  prefix                  = local.prefix
  location                = lookup(each.value, "location", azurerm_resource_group.rg[each.value.resource_group_key].location)
  networking_object       = each.value
  tags                    = local.tags
  diagnostics_map         = local.caf_foundations_accounting[each.value.location].diagnostics_map
  log_analytics_workspace = local.caf_foundations_accounting[each.value.location].log_analytics_workspace
  diagnostics_settings    = lookup(each.value, "diagnostics", var.diagnostics.vnet)
  ddos_id                 = ""
}
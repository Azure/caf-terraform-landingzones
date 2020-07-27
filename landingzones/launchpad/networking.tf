
module "virtual_network" {
  source  = "aztfmod/caf-virtual-network/azurerm"
  version = "~> 3.1.0"

  for_each = var.networking

  prefix                    = local.global_settings.prefix
  convention                = lookup( var.diagnostics_settings, "convention", local.global_settings.convention)
  location                  = azurerm_resource_group.rg[each.value.resource_group_key].location
  resource_group_name       = azurerm_resource_group.rg[each.value.resource_group_key].name
  networking_object         = each.value
  tags                      = local.tags
  diagnostics_map           = module.diagnostics.diagnostics_map
  diagnostics_settings      = each.value.diags
  log_analytics_workspace   = module.log_analytics.object
}


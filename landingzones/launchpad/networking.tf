
module "virtual_network" {
  source  = "aztfmod/caf-virtual-network/azurerm"
  version = "~> 3.1.0"

  prefix                    = local.global_settings.prefix
  convention                = lookup( var.diagnostics_settings, "convention", local.global_settings.convention)
  location                  = azurerm_resource_group.rg[var.networking[var.launchpad_key_names.networking].resource_group_key].location
  resource_group_name       = azurerm_resource_group.rg[var.networking[var.launchpad_key_names.networking].resource_group_key].name
  networking_object         = var.networking[var.launchpad_key_names.networking]
  tags                      = local.tags
  diagnostics_map           = module.diagnostics.diagnostics_map
  diagnostics_settings      = var.networking[var.launchpad_key_names.networking].diags
  log_analytics_workspace   = module.log_analytics.object
}


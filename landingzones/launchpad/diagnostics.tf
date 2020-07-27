
module "diagnostics" {

  source  = "aztfmod/caf-diagnostics-logging/azurerm"
  version = "~> 2.1.0"

  name                  = var.diagnostics_settings.resource_diagnostics_name
  convention            = lookup( var.diagnostics_settings, "convention", local.global_settings.convention)
  resource_group_name   = azurerm_resource_group.rg[var.diagnostics_settings.resource_group_key].name
  prefix                = local.prefix_start_alpha
  location              = lookup( var.diagnostics_settings, "location", azurerm_resource_group.rg[var.diagnostics_settings.resource_group_key].location)
  tags                  = local.tags

  enable_event_hub      = var.diagnostics_settings.azure_diagnostics_logs_event_hub
}
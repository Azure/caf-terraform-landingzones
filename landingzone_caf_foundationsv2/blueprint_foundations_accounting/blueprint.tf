#Create the resource groups to host the blueprint
module "resource_group_hub" {
  source  = "aztfmod/caf-resource-group/azurerm"
  version = "0.1.1"
  
  prefix          = var.prefix
  resource_groups = var.resource_groups_hub
  tags            = local.tags
}

#Specify the subscription logging repositories 
module "activity_logs" {
  source  = "aztfmod/caf-activity-logs/azurerm"
  version = "1.0.0"
  
  convention          = var.convention
  name                = var.accounting_settings.azure_activity_logs_name
  logs_rentention     = var.accounting_settings.azure_activity_logs_retention
  enable_event_hub    = var.accounting_settings.azure_activity_logs_event_hub
  prefix              = var.prefix
  resource_group_name = module.resource_group_hub.names["HUB-CORE-SEC"]
  location            = var.location
  tags                = local.tags
}

#Specify the operations diagnostic logging repositories 
module "diagnostics_logging" {
  source  = "aztfmod/caf-diagnostics-logging/azurerm"
  version = "1.0.0"

  convention            = var.convention
  name                  = var.accounting_settings.azure_diagnostics_logs_name
  enable_event_hub      = var.accounting_settings.azure_diagnostics_logs_event_hub
  prefix                = var.prefix
  resource_group_name   = module.resource_group_hub.names["HUB-OPERATIONS"]
  location              = var.location
  tags                  = local.tags
}

#Create the Azure Monitor - Log Analytics workspace
module "log_analytics" {
  source  = "aztfmod/caf-log-analytics/azurerm"
  version = "1.0.0"

  convention          = var.convention
  prefix              = var.prefix
  name                = var.accounting_settings.analytics_workspace_name
  solution_plan_map   = var.accounting_settings.solution_plan_map
  resource_group_name = module.resource_group_hub.names["HUB-OPERATIONS"]
  location            = var.location
  tags                = local.tags
}

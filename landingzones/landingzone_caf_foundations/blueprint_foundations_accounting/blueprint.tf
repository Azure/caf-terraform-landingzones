#Create the resource groups to host the blueprint
resource "azurecaf_naming_convention" "rg_coresec_name" {  
  name    = var.resource_groups_hub.HUB-CORE-SEC.name
  prefix  = var.prefix
  resource_type    = "rg"
  max_length = 50
  convention  = var.convention
}

resource "azurecaf_naming_convention" "rg_operations_name" {  
  name    = var.resource_groups_hub.HUB-OPERATIONS.name
  prefix  = var.prefix
  resource_type    = "rg"
  max_length = 50
  convention  = var.convention
}

resource "azurerm_resource_group" "rg_coresec" {
  name     = azurecaf_naming_convention.rg_coresec_name.result
  location = var.resource_groups_hub.HUB-CORE-SEC.location
  tags     = local.tags
}

resource "azurerm_resource_group" "rg_operations" {
  name     = azurecaf_naming_convention.rg_operations_name.result
  location = var.resource_groups_hub.HUB-OPERATIONS.location
  tags     = local.tags
}

#Specify the subscription logging repositories 
module "activity_logs" {
  source  = "aztfmod/caf-activity-logs/azurerm"
  version = "2.0.0"
  
  convention          = var.convention
  name                = var.accounting_settings.azure_activity_logs_name
  logs_rentention     = var.accounting_settings.azure_activity_logs_retention
  enable_event_hub    = var.accounting_settings.azure_activity_logs_event_hub
  prefix              = var.prefix
  resource_group_name = azurerm_resource_group.rg_coresec.name
  location            = var.location
  tags                = local.tags
}

#Specify the operations diagnostic logging repositories 
module "diagnostics_logging" {
  source  = "aztfmod/caf-diagnostics-logging/azurerm"
  version = "2.0.1"

  convention            = var.convention
  name                  = var.accounting_settings.azure_diagnostics_logs_name
  enable_event_hub      = var.accounting_settings.azure_diagnostics_logs_event_hub
  prefix                = var.prefix
  resource_group_name   = azurerm_resource_group.rg_operations.name
  location              = var.location
  tags                  = local.tags
}

#Create the Azure Monitor - Log Analytics workspace
module "log_analytics" {
  source  = "aztfmod/caf-log-analytics/azurerm"
  version = "2.0.1"

  convention          = var.convention
  prefix              = var.prefix
  name                = var.accounting_settings.analytics_workspace_name
  solution_plan_map   = var.accounting_settings.solution_plan_map
  resource_group_name = azurerm_resource_group.rg_operations.name
  location            = var.location
  tags                = local.tags
}
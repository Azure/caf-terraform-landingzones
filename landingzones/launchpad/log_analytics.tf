
module "log_analytics" {
    source  = "aztfmod/caf-log-analytics/azurerm"
    version = "~> 2.3.0"

    name                              = var.log_analytics.resource_log_analytics_name
    convention                        = lookup( var.log_analytics, "convention", local.global_settings.convention)
    solution_plan_map                 = var.log_analytics.solutions_maps
    resource_group_name               = azurerm_resource_group.rg[var.log_analytics.resource_group_key].name
    prefix                            = local.prefix_start_alpha
    location                          = lookup( var.log_analytics, "location", azurerm_resource_group.rg[var.log_analytics.resource_group_key].location)
    tags                              = local.tags   
}

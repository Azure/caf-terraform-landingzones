resource "azurerm_log_analytics_solution" "sentinel" {

  solution_name         = "SecurityInsights"
  location              = var.location
  resource_group_name   = var.rg
  workspace_resource_id = var.log_analytics.id
  workspace_name        = var.log_analytics.name

  // tags = var.tags
  // Tags not implemented in TF for azurerm_log_analytics_solution

  plan {
    product   = "OMSGallery/SecurityInsights"
    publisher = "Microsoft"
  }
}
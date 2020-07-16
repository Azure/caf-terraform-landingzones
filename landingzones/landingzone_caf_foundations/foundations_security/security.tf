#Create the Azure Security Center workspace
module "security_center" {
  count  = var.security_settings.enable_security_center ? 1 : 0
  source = "github.com/aztfmod/terraform-azurerm-caf-security-center?ref=vnext"
  # source  = "aztfmod/caf-security-center/azurerm"
  # version = "1.0.0"

  asc_config   = var.security_settings.security_center
  scope_id     = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
  workspace_id = var.log_analytics.id
}

#Create the Azure Sentinel Configuration
module "sentinel" {
  count  = var.security_settings.enable_sentinel ? 1 : 0
  source = "./sentinel"

  log_analytics = var.log_analytics
  rg            = var.resource_groups_hub.name
  location      = var.location
}

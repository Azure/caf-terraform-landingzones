#Create the Azure Security Center workspace
module "security_center" {
  source  = "aztfmod/caf-security-center/azurerm"
  version = "1.0.0"
  
  enable_security_center  = var.security_settings.enable_security_center
  contact_email           = var.security_settings.security_center.contact_email
  contact_phone           = var.security_settings.security_center.contact_phone
  scope_id                = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
  workspace_id            = var.log_analytics.id
}

#Create the Azure Sentinel Configuration
module "sentinel" {
  source = "./sentinel"
  
  enable_sentinel         = var.security_settings.enable_sentinel
  log_analytics           = var.log_analytics
  rg                      = var.resource_groups_hub["HUB-OPERATIONS"]
  location                = var.location
}

module "foundations" {
  source  = "aztfmod/caf/azurerm"
  version = "~> 0.4"

  current_landingzone_key     = var.landingzone.key
  tenant_id                   = var.tenant_id
  tags                        = local.tags
  diagnostics                 = local.diagnostics
  global_settings             = local.global_settings
  tfstates                    = local.tfstates
  diagnostic_storage_accounts = var.diagnostic_storage_accounts
  logged_user_objectId        = var.logged_user_objectId
  logged_aad_app_objectId     = var.logged_aad_app_objectId
  resource_groups             = var.resource_groups
  keyvaults                   = var.keyvaults
  log_analytics               = var.log_analytics
  event_hub_namespaces        = var.event_hub_namespaces
}
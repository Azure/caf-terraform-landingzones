module "foundations" {
  source  = "aztfmod/caf/azurerm"
  version = "~>5.1.0"

  current_landingzone_key     = var.landingzone.key
  tenant_id                   = var.tenant_id
  tags                        = local.tags
  diagnostics                 = local.remote.diagnostics
  global_settings             = local.global_settings
  tfstates                    = local.tfstates
  diagnostics_definition      = var.diagnostics_definition
  diagnostics_destinations    = var.diagnostics_destinations
  diagnostic_storage_accounts = var.diagnostic_storage_accounts
  logged_user_objectId        = var.logged_user_objectId
  logged_aad_app_objectId     = var.logged_aad_app_objectId
  resource_groups             = var.resource_groups
  keyvaults                   = var.keyvaults
  log_analytics               = var.log_analytics
  event_hub_namespaces        = var.event_hub_namespaces
}

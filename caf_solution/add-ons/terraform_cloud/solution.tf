module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "~>5.6.0"

  providers = {
    azurerm.vhub = azurerm.vhub
  }
  azuread                     = local.azuread
  current_landingzone_key     = var.landingzone.key
  tenant_id                   = var.tenant_id
  tfstates                    = local.tfstates
  tags                        = local.tags
  global_settings             = local.global_settings
  diagnostics                 = local.diagnostics
  diagnostic_storage_accounts = var.diagnostic_storage_accounts
  logged_user_objectId        = var.logged_user_objectId
  logged_aad_app_objectId     = var.logged_aad_app_objectId
  managed_identities          = var.managed_identities
  resource_groups             = var.resource_groups
  security                    = local.security
  keyvaults                   = var.keyvaults
  keyvault_access_policies    = var.keyvault_access_policies
  role_mapping                = var.role_mapping

  # Pass the remote objects you need to connect to.
  remote_objects = {
    keyvaults          = local.remote.keyvaults
  }
}
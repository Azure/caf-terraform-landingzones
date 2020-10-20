module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "~> 0.4"

  current_landingzone_key     = var.landingzone.key
  tenant_id                   = var.tenant_id
  tfstates                    = local.tfstates
  tags                        = local.tags
  global_settings             = local.global_settings
  diagnostics                 = local.diagnostics
  diagnostic_storage_accounts = var.diagnostic_storage_accounts
  logged_user_objectId        = var.logged_user_objectId
  logged_aad_app_objectId     = var.logged_aad_app_objectId
  resource_groups             = var.resource_groups
  storage_accounts            = var.storage_accounts
  azuread_groups              = var.azuread_groups
  keyvaults                   = var.keyvaults
  keyvault_access_policies    = var.keyvault_access_policies
  role_mapping                = var.role_mapping
  custom_role_definitions     = var.custom_role_definitions
  azuread_apps                = var.azuread_apps
  compute = {
    virtual_machines = var.virtual_machines
  }
  storage = {
    storage_account_blobs = var.storage_account_blobs
  }

  remote_objects = {
    keyvaults          = local.remote.keyvaults[var.landingzone.key]
    networking         = local.remote.networking[var.landingzone.key]
    managed_identities = local.remote.managed_identities[var.landingzone.key]
  }
}

module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "~>5.6.8"

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
  resource_groups             = var.resource_groups
  storage_accounts            = var.storage_accounts
  keyvaults                   = var.keyvaults
  keyvault_access_policies    = var.keyvault_access_policies
  managed_identities          = var.managed_identities
  role_mapping                = var.role_mapping
  custom_role_definitions     = var.custom_role_definitions
  var_folder_path             = var.var_folder_path
  compute = {
    virtual_machines = var.virtual_machines
  }
  storage = {
    storage_account_blobs = var.storage_account_blobs
    storage_containers    = var.storage_containers
  }

  # Pass the remote objects you need to connect to.
  remote_objects = {
    keyvaults          = local.remote.keyvaults
    vnets              = local.remote.vnets
    managed_identities = local.remote.managed_identities
    azuread_groups     = local.remote.azuread_groups
    resource_groups    = local.remote.resource_groups
  }
}

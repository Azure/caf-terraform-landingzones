module "landingzones_shared_services" {
  source  = "aztfmod/caf/azurerm"
  version = "~> 0.4"

  current_landingzone_key = var.landingzone.key
  tenant_id               = var.tenant_id
  tags                    = local.tags
  diagnostics             = local.diagnostics
  global_settings         = local.global_settings
  tfstates                = local.tfstates
  logged_user_objectId    = var.logged_user_objectId
  logged_aad_app_objectId = var.logged_aad_app_objectId

  resource_groups = var.resource_groups
  shared_services = {
    recovery_vaults = var.recovery_vaults
    automations     = var.automations
  }

  # Pass the remote objects you need to connect to.
  remote_objects = {
    vnets = local.remote.vnets
  }
}
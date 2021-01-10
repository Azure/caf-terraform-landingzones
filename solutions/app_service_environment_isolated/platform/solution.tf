module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "~> 4.21"

  current_landingzone_key     = var.landingzone.key
  tenant_id                   = var.tenant_id
  tfstates                    = local.tfstates
  tags                        = local.tags
  global_settings             = local.global_settings
  diagnostics                 = local.diagnostics
  logged_user_objectId        = var.logged_user_objectId
  logged_aad_app_objectId     = var.logged_aad_app_objectId
  resource_groups             = var.resource_groups
  webapp = {
    app_service_environments  = var.app_service_environments
    app_service_plans         = var.app_service_plans
  }

  remote_objects = {
    vnets                     = local.remote.vnets
    private_dns               = local.remote.private_dns
  }
}

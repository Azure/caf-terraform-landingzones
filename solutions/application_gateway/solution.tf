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
  keyvaults                   = var.keyvaults
  keyvault_access_policies    = var.keyvault_access_policies
  managed_identities          = var.managed_identities

  security = {
    keyvault_certificates = var.keyvault_certificates
  }

  networking = {
    application_gateways              = var.application_gateways
    application_gateway_applications  = var.application_gateway_applications
  }

  remote_objects = {
    azuread_groups                   = local.remote.azuread_groups
    vnets                            = local.remote.vnets
    private_dns                      = local.remote.private_dns
    public_ip_addresses              = local.remote.public_ip_addresses
    application_gateways             = local.remote.application_gateways
    application_gateway_applications = local.remote.application_gateway_applications
    app_services                     = local.remote.app_services
  }
}

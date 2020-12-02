module "mlops" {
  source  = "aztfmod/caf/azurerm"
  version = "~> 0.4"

  current_landingzone_key  = var.landingzone.key
  tags                     = local.tags
  diagnostics              = local.diagnostics
  global_settings          = local.global_settings
  tfstates                 = local.tfstates
  tenant_id                = var.tenant_id
  logged_user_objectId     = var.logged_user_objectId
  logged_aad_app_objectId  = var.logged_aad_app_objectId
  resource_groups          = var.resource_groups
  keyvaults                = var.keyvaults
  keyvault_access_policies = var.keyvault_access_policies
  storage_accounts         = var.storage_accounts

  database = {
    machine_learning_workspaces = var.machine_learning_workspaces
  }

  webapp = {
    azurerm_application_insights = var.azurerm_application_insights
    app_service_plans            = var.app_service_plans
    app_services                 = var.app_services
  }

  remote_objects = {
    azuread_groups                   = local.remote.azuread_groups
    managed_identities               = local.remote.managed_identities
    vnets                            = local.remote.vnets
    azurerm_firewalls                = local.remote.azurerm_firewalls
    virtual_wans                     = local.remote.virtual_wans
    private_dns                      = local.remote.private_dns
    application_gateways             = local.remote.application_gateways
    application_gateway_applications = local.remote.application_gateway_applications
    public_ip_addresses              = local.remote.public_ip_addresses
  }

}

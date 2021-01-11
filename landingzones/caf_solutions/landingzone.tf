module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "~> 4.21"

  current_landingzone_key     = var.landingzone.key
  tags                        = local.tags
  diagnostics                 = local.diagnostics
  global_settings             = local.global_settings
  tfstates                    = local.tfstates
  tenant_id                   = var.tenant_id
  logged_user_objectId        = var.logged_user_objectId
  logged_aad_app_objectId     = var.logged_aad_app_objectId
  resource_groups             = var.resource_groups
  storage_accounts            = var.storage_accounts
  azuread_groups              = var.azuread_groups
  keyvaults                   = var.keyvaults
  keyvault_access_policies    = var.keyvault_access_policies
  managed_identities          = var.managed_identities
  role_mapping                = var.role_mapping
  custom_role_definitions     = var.custom_role_definitions

  webapp = {
    azurerm_application_insights = var.azurerm_application_insights
    app_service_environments     = var.app_service_environments
    app_service_plans            = var.app_service_plans
    app_services                 = var.app_services
  }

  networking = {
    application_gateways              = var.application_gateways
    application_gateway_applications  = var.application_gateway_applications
  }

  database = {
    azurerm_redis_caches  = var.azurerm_redis_caches
    mssql_servers         = var.mssql_servers
    mssql_databases       = var.mssql_databases
    mssql_elastic_pools   = var.mssql_elastic_pools
  }

  security = {
    keyvault_certificates = var.keyvault_certificates
  }

  remote_objects = {
    azuread_groups                   = local.remote.azuread_groups
    managed_identities               = local.remote.managed_identities
    vnets                            = local.remote.vnets
    private_dns                      = local.remote.private_dns
    public_ip_addresses              = local.remote.public_ip_addresses
    app_service_environments         = local.remote.app_service_environments
    app_service_plans                = local.remote.app_service_plans
    app_services                     = local.remote.app_services
    mssql_servers                    = local.remote.mssql_servers
    mssql_elastic_pools              = local.remote.mssql_elastic_pools
    application_gateways             = local.remote.application_gateways
    application_gateway_applications = local.remote.application_gateway_applications
  }
}

module "solution" {
  source  = "aztfmod/caf/azurerm"
  version = "5.7.4"
  # source = "git::https://github.com/aztfmod/terraform-azurerm-caf.git?ref=main"

  providers = {
    azurerm.vhub = azurerm.vhub
  }

  aadb2c                                = var.aadb2c
  apim                                  = local.apim
  azuread                               = local.azuread
  cloud                                 = local.cloud
  cognitive_services                    = local.cognitive_services
  communication                         = local.communication
  compute                               = local.compute
  current_landingzone_key               = try(var.landingzone.key, var.landingzone[var.backend_type].key)
  custom_role_definitions               = var.custom_role_definitions
  data_factory                          = local.data_factory
  data_protection                       = local.data_protection
  data_sources                          = var.data_sources
  database                              = local.database
  diagnostic_storage_accounts           = var.diagnostic_storage_accounts
  diagnostics_definition                = var.diagnostics_definition
  diagnostics_destinations              = var.diagnostics_destinations
  event_hub_auth_rules                  = var.event_hub_auth_rules
  event_hub_consumer_groups             = var.event_hub_consumer_groups
  event_hub_namespace_auth_rules        = var.event_hub_namespace_auth_rules
  event_hub_namespaces                  = var.event_hub_namespaces
  event_hubs                            = var.event_hubs
  global_settings                       = local.global_settings
  identity                              = local.identity
  iot                                   = local.iot
  keyvault_access_policies              = var.keyvault_access_policies
  keyvault_access_policies_azuread_apps = var.keyvault_access_policies_azuread_apps
  keyvault_certificate_issuers          = var.keyvault_certificate_issuers
  keyvaults                             = var.keyvaults
  log_analytics                         = var.log_analytics
  logged_aad_app_objectId               = var.logged_aad_app_objectId
  logged_user_objectId                  = var.logged_user_objectId
  logic_app                             = local.logic_app
  managed_identities                    = var.managed_identities
  messaging                             = local.messaging
  networking                            = local.networking
  purview                               = local.purview
  random_strings                        = var.random_strings
  remote_objects                        = local.remote
  resource_groups                       = var.resource_groups
  role_mapping                          = var.role_mapping
  security                              = local.security
  shared_services                       = local.shared_services
  storage                               = local.storage
  storage_accounts                      = var.storage_accounts
  subscription_billing_role_assignments = var.subscription_billing_role_assignments
  subscriptions                         = var.subscriptions
  tags                                  = local.tags
  tenant_id                             = var.tenant_id
  tfstates                              = var.tfstates
  user_type                             = var.user_type
  var_folder_path                       = var.var_folder_path
  webapp                                = local.webapp
  maps                                  = local.maps

  diagnostics = {
    diagnostic_event_hub_namespaces = try(local.diagnostics.diagnostic_event_hub_namespaces, var.diagnostic_event_hub_namespaces)
    diagnostic_log_analytics        = try(local.diagnostics.diagnostic_log_analytics, var.diagnostic_log_analytics)
    diagnostic_storage_accounts     = try(local.diagnostics.diagnostic_storage_accounts, var.diagnostic_storage_accounts)
    diagnostics_definition          = local.diagnostics.diagnostics_definition
    diagnostics_destinations        = local.diagnostics.diagnostics_destinations
    event_hub_namespaces            = local.diagnostics.event_hub_namespaces
    log_analytics                   = local.diagnostics.log_analytics
    storage_accounts                = local.diagnostics.storage_accounts
  }

}

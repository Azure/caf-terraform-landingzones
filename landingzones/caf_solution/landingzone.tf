module "solution" {
  source = "git::https://github.com/aztfmod/terraform-azurerm-caf.git?ref=5.3.0_preview"

  azuread_api_permissions               = var.azuread_api_permissions
  azuread_apps                          = var.azuread_apps
  azuread_groups                        = var.azuread_groups
  azuread_roles                         = var.azuread_roles
  azuread_users                         = var.azuread_users
  compute                               = var.compute
  current_landingzone_key               = var.landingzone.key
  custom_role_definitions               = var.custom_role_definitions
  database                              = var.database
  event_hub_namespaces                  = var.event_hub_namespaces
  global_settings                       = local.global_settings
  keyvault_access_policies              = var.keyvault_access_policies
  keyvault_certificate_issuers          = var.keyvault_certificate_issuers
  keyvaults                             = var.keyvaults
  log_analytics                         = var.log_analytics
  logged_aad_app_objectId               = var.logged_aad_app_objectId
  logged_user_objectId                  = var.logged_user_objectId
  managed_identities                    = var.managed_identities
  networking                            = var.networking
  remote_objects                        = local.remote_objects
  resource_groups                       = var.resource_groups
  role_mapping                          = var.role_mapping
  security                              = var.security
  shared_services                       = var.shared_services
  storage_accounts                      = var.storage_accounts
  subscription_billing_role_assignments = var.subscription_billing_role_assignments
  subscriptions                         = var.subscriptions
  tags                                  = var.tags
  tenant_id                             = var.tenant_id
  tfstates                              = var.tfstates
  user_type                             = var.user_type
  webapp                                = var.webapp

  diagnostics = {
    diagnostic_event_hub_namespaces = try(local.diagnostics.diagnostic_event_hub_namespaces, var.diagnostic_event_hub_namespaces)
    diagnostic_log_analytics        = try(local.diagnostics.diagnostic_log_analytics, var.diagnostic_log_analytics)
    diagnostic_storage_accounts     = try(local.diagnostics.diagnostic_storage_accounts, var.diagnostic_storage_accounts)
  }

}

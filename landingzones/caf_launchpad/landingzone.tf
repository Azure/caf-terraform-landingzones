module "launchpad" {
  source  = "aztfmod/caf/azurerm"
  version = "~> 0.4"

  current_landingzone_key               = var.landingzone.key
  tenant_id                             = var.tenant_id
  tags                                  = local.tags
  global_settings                       = local.global_settings
  enable                                = var.enable
  logged_user_objectId                  = var.logged_user_objectId
  logged_aad_app_objectId               = var.logged_aad_app_objectId
  user_type                             = var.user_type
  log_analytics                         = var.log_analytics
  event_hub_namespaces                  = var.event_hub_namespaces
  diagnostics_definition                = var.diagnostics_definition
  diagnostics_destinations              = var.diagnostics_destinations
  resource_groups                       = var.resource_groups
  keyvaults                             = var.keyvaults
  keyvault_access_policies              = var.keyvault_access_policies
  keyvault_access_policies_azuread_apps = var.keyvault_access_policies_azuread_apps
  subscriptions                         = var.subscriptions
  compute = {
    virtual_machines = var.virtual_machines
    bastion_hosts    = var.bastion_hosts
  }
  networking = {
    vnets                             = var.vnets
    network_security_group_definition = var.network_security_group_definition
    public_ip_addresses               = var.public_ip_addresses
    azurerm_routes                    = var.azurerm_routes
    route_tables                      = var.route_tables
  }
  storage_accounts            = var.storage_accounts
  diagnostic_storage_accounts = var.diagnostic_storage_accounts
  azuread_apps                = var.azuread_apps
  azuread_api_permissions     = var.azuread_api_permissions
  azuread_groups              = var.azuread_groups
  azuread_roles               = var.azuread_roles
  azuread_users               = var.azuread_users
  managed_identities          = var.managed_identities
  custom_role_definitions     = var.custom_role_definitions
  role_mapping                = var.role_mapping
}

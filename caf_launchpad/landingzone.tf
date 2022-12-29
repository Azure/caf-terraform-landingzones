module "launchpad" {
  source = "../aztfmod"

  providers = {
    azurerm.vhub = azurerm.vhub
  }

  current_landingzone_key               = var.landingzone.key
  custom_role_definitions               = var.custom_role_definitions
  enable                                = var.enable
  event_hub_namespaces                  = var.event_hub_namespaces
  global_settings                       = local.global_settings
  keyvault_access_policies              = var.keyvault_access_policies
  keyvault_access_policies_azuread_apps = var.keyvault_access_policies_azuread_apps
  keyvaults                             = var.keyvaults
  log_analytics                         = var.log_analytics
  logged_aad_app_objectId               = var.logged_aad_app_objectId
  logged_user_objectId                  = var.logged_user_objectId
  managed_identities                    = var.managed_identities
  remote_objects                        = local.remote
  resource_groups                       = var.resource_groups
  role_mapping                          = var.role_mapping
  storage_accounts                      = var.storage_accounts
  subscriptions                         = var.subscriptions
  tags                                  = local.tags
  tenant_id                             = var.tenant_id
  user_type                             = var.user_type

  azuread = {
    azuread_api_permissions             = var.azuread_api_permissions
    azuread_applications                = var.azuread_applications
    azuread_apps                        = var.azuread_apps
    azuread_credential_policies         = var.azuread_credential_policies
    azuread_groups                      = var.azuread_groups
    azuread_groups_membership           = var.azuread_groups_membership
    azuread_roles                       = var.azuread_roles
    azuread_service_principal_passwords = var.azuread_service_principal_passwords
    azuread_service_principals          = var.azuread_service_principals
    azuread_users                       = var.azuread_users
  }

  diagnostics = {
    diagnostics_definition          = try(var.diagnostics.diagnostics_definition, var.diagnostics_definition)
    diagnostics_destinations        = try(var.diagnostics.diagnostics_destinations, var.diagnostics_destinations)
    diagnostic_event_hub_namespaces = try(var.diagnostics.diagnostic_event_hub_namespaces, var.diagnostic_event_hub_namespaces)
    diagnostic_log_analytics        = try(var.diagnostics.diagnostic_log_analytics, var.diagnostic_log_analytics)
    diagnostic_storage_accounts     = try(var.diagnostics.diagnostic_storage_accounts, var.diagnostic_storage_accounts)
  }

  compute = {
    bastion_hosts    = try(var.compute.bastion_hosts, var.bastion_hosts)
    container_groups = var.container_groups
    virtual_machines = try(var.compute.virtual_machines, var.virtual_machines)
  }

  networking = {
    azurerm_routes                    = try(var.networking.azurerm_routes, var.azurerm_routes)
    network_profiles                  = var.network_profiles
    network_security_group_definition = try(var.networking.network_security_group_definition, var.network_security_group_definition)
    public_ip_addresses               = try(var.networking.public_ip_addresses, var.public_ip_addresses)
    route_tables                      = try(var.networking.route_tables, var.route_tables)
    virtual_hub_connections           = try(var.networking.virtual_hub_connections, var.virtual_hub_connections)
    vnets                             = try(var.networking.vnets, var.vnets)
    private_dns                       = try(var.networking.private_dns, var.private_dns)
    private_endpoints                 = try(var.networking.private_endpoints, var.private_endpoints)
  }

  security = {
    keyvault_keys = var.keyvault_keys
  }
}

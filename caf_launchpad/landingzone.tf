module "launchpad" {
  source  = "aztfmod/caf/azurerm"
  version = "~>5.4.0"

  #source = "git::https://github.com/aztfmod/terraform-azurerm-caf.git?ref=5.4.0"
  #source = "../../aztfmod"

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
    virtual_machines = try(var.compute.virtual_machines, var.virtual_machines)
    bastion_hosts    = try(var.compute.bastion_hosts, var.bastion_hosts)
  }

  networking = {
    vnets                             = try(var.networking.vnets, var.vnets)
    network_security_group_definition = try(var.networking.network_security_group_definition, var.network_security_group_definition)
    public_ip_addresses               = try(var.networking.public_ip_addresses, var.public_ip_addresses)
    azurerm_routes                    = try(var.networking.azurerm_routes, var.azurerm_routes)
    route_tables                      = try(var.networking.route_tables, var.route_tables)
  }

  security = {
    keyvault_keys = var.keyvault_keys
  }
}

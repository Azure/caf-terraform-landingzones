module "networking" {
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
  networking = {
    application_gateways                                    = var.application_gateways
    application_gateway_applications                        = var.application_gateway_applications
    vnets                                                   = var.vnets
    vnet_peerings                                           = var.vnet_peerings
    vhub_peerings                                           = var.vhub_peerings
    network_security_group_definition                       = var.network_security_group_definition
    azurerm_firewall_network_rule_collection_definition     = var.azurerm_firewall_network_rule_collection_definition
    azurerm_firewall_application_rule_collection_definition = var.azurerm_firewall_application_rule_collection_definition
    azurerm_firewall_nat_rule_collection_definition         = var.azurerm_firewall_nat_rule_collection_definition
    azurerm_firewalls                                       = var.azurerm_firewalls
    public_ip_addresses                                     = var.public_ip_addresses
    route_tables                                            = var.route_tables
    azurerm_routes                                          = var.azurerm_routes
    virtual_wans                                            = var.virtual_wans
    ddos_services                                           = var.ddos_services
    private_dns                                             = var.private_dns
  }
  compute = {
    virtual_machines           = var.virtual_machines
    bastion_hosts              = var.bastion_hosts
    azure_container_registries = var.azure_container_registries
  }
  storage_accounts   = var.storage_accounts
  managed_identities = var.managed_identities

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

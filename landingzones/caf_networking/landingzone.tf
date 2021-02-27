module "networking" {
  source  = "aztfmod/caf/azurerm"
  version = "~>5.2.0"

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
    application_gateway_applications                        = var.application_gateway_applications
    application_gateways                                    = var.application_gateways
    azurerm_firewall_application_rule_collection_definition = var.azurerm_firewall_application_rule_collection_definition
    azurerm_firewall_nat_rule_collection_definition         = var.azurerm_firewall_nat_rule_collection_definition
    azurerm_firewall_network_rule_collection_definition     = var.azurerm_firewall_network_rule_collection_definition
    azurerm_firewalls                                       = var.azurerm_firewalls
    azurerm_routes                                          = var.azurerm_routes
    ddos_services                                           = var.ddos_services
    dns_zone_records                                        = var.dns_zone_records
    dns_zones                                               = var.dns_zones
    express_route_circuit_authorizations                    = var.express_route_circuit_authorizations
    express_route_circuits                                  = var.express_route_circuits
    network_security_group_definition                       = var.network_security_group_definition
    private_dns                                             = var.private_dns
    private_endpoints                                       = var.private_endpoints
    public_ip_addresses                                     = var.public_ip_addresses
    route_tables                                            = var.route_tables
    vhub_peerings                                           = var.vhub_peerings
    virtual_network_gateways                                = var.virtual_network_gateways
    virtual_wans                                            = var.virtual_wans
    vnet_peerings                                           = var.vnet_peerings
    vnets                                                   = var.vnets
  }
  compute = {
    azure_container_registries = var.azure_container_registries
    bastion_hosts              = var.bastion_hosts
    virtual_machines           = var.virtual_machines
  }
  storage_accounts   = var.storage_accounts
  managed_identities = var.managed_identities

  remote_objects = {
    application_gateway_applications = local.remote.application_gateway_applications
    application_gateways             = local.remote.application_gateways
    azuread_groups                   = local.remote.azuread_groups
    azurerm_firewalls                = local.remote.azurerm_firewalls
    keyvaults                        = local.remote.keyvaults
    managed_identities               = local.remote.managed_identities
    private_dns                      = local.remote.private_dns
    public_ip_addresses              = local.remote.public_ip_addresses
    virtual_wans                     = local.remote.virtual_wans
    vnets                            = local.remote.vnets
  }

}

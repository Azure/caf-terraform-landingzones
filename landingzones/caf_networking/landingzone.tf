module "landingzones_networking" {
  # source  = "aztfmod/caf-enterprise-scale/azurerm"
  # version = "~>0.3"
  source = "../../../aztfmod/es"

  tags                     = local.tags
  diagnostics              = local.diagnostics
  global_settings          = local.global_settings
  tfstates                 = local.tfstates
  logged_user_objectId     = var.logged_user_objectId
  logged_aad_app_objectId  = var.logged_aad_app_objectId
  resource_groups          = var.resource_groups
  keyvaults                = var.keyvaults
  keyvault_access_policies = var.keyvault_access_policies
  networking = {
    application_gateways                                    = var.application_gateways
    application_gateway_applications                        = var.application_gateway_applications
    vnets                                                   = var.vnets
    networking_objects                                      = {}
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

}
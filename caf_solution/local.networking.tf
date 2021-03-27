locals {
  networking = merge(
    var.networking,
    {
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
      load_balancers                                          = var.load_balancers
      route_tables                                            = var.route_tables
      vhub_peerings                                           = var.vhub_peerings
      virtual_network_gateways                                = var.virtual_network_gateways
      virtual_wans                                            = var.virtual_wans
      vnet_peerings                                           = var.vnet_peerings
      vnets                                                   = var.vnets
    }
  )
}

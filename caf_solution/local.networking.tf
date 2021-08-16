locals {
  networking = merge(
    var.networking,
    {
      application_gateway_applications                        = var.application_gateway_applications
      application_gateway_waf_policies                        = var.application_gateway_waf_policies
      application_gateways                                    = var.application_gateways
      application_security_groups                             = var.application_security_groups
      azurerm_firewall_application_rule_collection_definition = var.azurerm_firewall_application_rule_collection_definition
      azurerm_firewall_nat_rule_collection_definition         = var.azurerm_firewall_nat_rule_collection_definition
      azurerm_firewall_network_rule_collection_definition     = var.azurerm_firewall_network_rule_collection_definition
      azurerm_firewall_policies                               = var.azurerm_firewall_policies
      azurerm_firewall_policy_rule_collection_groups          = var.azurerm_firewall_policy_rule_collection_groups
      azurerm_firewalls                                       = var.azurerm_firewalls
      azurerm_routes                                          = var.azurerm_routes
      ddos_services                                           = var.ddos_services
      dns_zone_records                                        = var.dns_zone_records
      dns_zones                                               = var.dns_zones
      domain_name_registrations                               = var.domain_name_registrations
      express_route_circuit_authorizations                    = var.express_route_circuit_authorizations
      express_route_circuits                                  = var.express_route_circuits
      front_door_waf_policies                                 = var.front_door_waf_policies
      front_doors                                             = var.front_doors
      ip_groups                                               = var.ip_groups
      load_balancers                                          = var.load_balancers
      local_network_gateways                                  = var.local_network_gateways
      nat_gateways                                            = var.nat_gateways
      network_security_group_definition                       = var.network_security_group_definition
      network_watchers                                        = var.network_watchers
      networking_interface_asg_associations                   = var.networking_interface_asg_associations
      private_dns                                             = var.private_dns
      private_endpoints                                       = var.private_endpoints
      public_ip_addresses                                     = var.public_ip_addresses
      route_tables                                            = var.route_tables
      vhub_peerings                                           = var.vhub_peerings
      virtual_hub_connections                                 = var.virtual_hub_connections
      virtual_hub_er_gateway_connections                      = var.virtual_hub_er_gateway_connections
      virtual_hub_route_tables                                = var.virtual_hub_route_tables
      virtual_hubs                                            = var.virtual_hubs
      virtual_network_gateway_connections                     = var.virtual_network_gateway_connections
      virtual_network_gateways                                = var.virtual_network_gateways
      virtual_wans                                            = var.virtual_wans
      vnet_peerings                                           = var.vnet_peerings
      vnets                                                   = var.vnets
      vpn_sites                                               = var.vpn_sites
      vpn_gateway_connections                                 = var.vpn_gateway_connections
    }
  )
}

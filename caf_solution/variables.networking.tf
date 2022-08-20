
variable "application_gateway_platforms" {
  default = {}
}
variable "application_gateways" {
  default = {}
}
variable "application_gateway_applications_v1" {
  default = {}
}
variable "application_gateway_applications" {
  default = {}
}
variable "application_gateway_waf_policies" {
  default = {}
}
variable "application_security_groups" {
  default = {}
}
variable "azurerm_firewalls" {
  default = {}
}
variable "azurerm_firewall_application_rule_collection_definition" {
  default = {}
}
variable "azurerm_firewall_nat_rule_collection_definition" {
  default = {}
}
variable "azurerm_firewall_network_rule_collection_definition" {
  default = {}
}
variable "azurerm_firewall_policies" {
  default = {}
}
variable "azurerm_firewall_policy_rule_collection_groups" {
  default = {}
}
variable "azurerm_routes" {
  default = {}
}
variable "cdn_profiles" {
  default = {}
}
variable "cdn_endpoints" {
  default = {}
}
variable "ddos_services" {
  default = {}
}
variable "dns_zones" {
  default = {}
}
variable "dns_zone_records" {
  default = {}
}
variable "domain_name_registrations" {
  default = {}
}
variable "express_route_circuits" {
  default = {}
}
variable "express_route_circuit_authorizations" {
  default = {}
}
variable "express_route_circuit_peerings" {
  default = {}
}
variable "express_route_connections" {
  default = {}
}
variable "load_balancers" {
  default = {}
}
variable "nat_gateways" {
  default = {}
}
variable "network_watchers" {
  default = {}
}
variable "networking" {
  default = {}
  type    = map(any)
}
variable "network_profiles" {
  default = {}
}
variable "front_door_waf_policies" {
  default = {}
}
variable "front_doors" {
  default = {}
}
variable "ip_groups" {
  default = {}
}
variable "local_network_gateways" {
  default = {}
}
variable "networking_interface_asg_associations" {
  default = {}
}
variable "network_security_group_definition" {
  default = {}
}
variable "private_endpoints" {
  default = {}
}
variable "private_dns" {
  default = {}
}
variable "private_dns_vnet_links" {
  default = {}
}
variable "public_ip_addresses" {
  default = {}
}
variable "route_tables" {
  default = {}
}
variable "virtual_network_gateway_connections" {
  default = {}
}
variable "virtual_network_gateways" {
  default = {}
}
variable "virtual_wans" {
  default = {}
}
variable "virtual_hubs" {
  default = {}
}
variable "vnets" {
  default = {}
}
variable "virtual_subnets" {
  default = {}
}
variable "vhub_peerings" {
  default = {}
}
variable "vnet_peerings" {
  default = {}
}
variable "vnet_peerings_v1" {
  default = {}
}
variable "virtual_hub_er_gateway_connections" {
  default = {}
}
variable "virtual_hub_route_table_routes" {
  default = {}
}
variable "virtual_hub_route_tables" {
  default = {}
}
variable "virtual_hub_connections" {
  default = {}
}
variable "vpn_sites" {
  default = {}
}
variable "vpn_gateway_connections" {
  default = {}
}
variable "lb" {
  default = {}
}
variable "lb_backend_address_pool" {
  default = {}
}
variable "lb_backend_address_pool_address" {
  default = {}
}
variable "network_interface_backend_address_pool_association" {
  default = {}
}
variable "public_ip_prefixes" {
  default = {}
}


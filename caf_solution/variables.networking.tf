
variable "application_gateways" {
  default = {}
}
variable "application_gateway_applications" {
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
variable "azurerm_routes" {
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
variable "express_route_circuits" {
  default = {}
}
variable "express_route_circuit_authorizations" {
  default = {}
}
variable "load_balancers" {
  default = {}
}
variable "network_watchers" {
  default = {}
}
variable "networking" {
  default = {}
  type    = map(any)
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
variable "public_ip_addresses" {
  default = {}
}
variable "route_tables" {
  default = {}
}
variable "virtual_network_gateways" {
  default = {}
}
variable "virtual_wans" {
  default = {}
}
variable "vnets" {
  default = {}
}
variable "vhub_peerings" {
  default = {}
}
variable "vnet_peerings" {
  default = {}
}
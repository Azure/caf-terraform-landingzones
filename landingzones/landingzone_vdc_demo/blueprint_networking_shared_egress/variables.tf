variable "prefix" {
  description = "(Optional) Prefix to uniquely identify the deployment"    
}

variable "networking_object" {
  description = "Network configuration"
}

variable "virtual_network_rg" {
  description = "(Required) Map of the resource groups to create"
}

variable "shared_services_vnet_object" {
}

variable "location" {
  description = "(Required) Define the region where the resource groups will be created"
}

variable "tags" {
  description = "tags for the deployment"
}

variable "ip_addr_config" {
  description = "IP address configuration object"
}

variable "az_fw_config" {
  description = "(Required) configuration object for Azure Firewall to be created"
}

variable "udr_object" {
  description = "(Required) UDR object to be created"
}

variable "log_analytics_workspace" {
}

variable "diagnostics_map" {
}

variable "resource_groups_shared_egress" {
}

variable "global_settings" {
  description = "global settings"
}
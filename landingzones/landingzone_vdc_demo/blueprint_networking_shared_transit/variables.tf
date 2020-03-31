# variable "virtual_network_rg" {
#   description = "(Required) Map of the resource groups to create"
#   type        = string
#   default = ""
# }

variable "location" {
  description = "(Required) Define the region where the resource groups will be created"
}

variable "tags" {
  description = "Tags for the deployment"
}

variable "ip_addr_config" {
  description = "(Required) IP address configuration object"
}

variable "gateway_config" {
  description = "(Required) configuration object of network gateway to be created"
}

variable "networking_object" {
  description = "Network configuration object"
}

variable "remote_network" {
  description = "Map of the remote network configuration"
}

variable "remote_network_connect" {
  description = "Determines if the Remote Network is to be connected after creation."
  type = bool
}

variable "connection_name" {
  description = "Name of the connection to the remote site."
}

variable "resource_groups_shared_transit" {
  description = "(Required) Resource group structure where to deploy the environment"
}

variable "networking_transit" {
  
}

variable "log_analytics_workspace" {
  
}

variable "diagnostics_map" {
  
}

variable "prefix" {
  description = "(Optional) Prefix to uniquely identify the deployment"    
}


variable "shared_services_vnet_object" {
  
}

variable "virtual_network_rg" {
  description = "(Required) Map of the resource groups to create"
}

variable "provision_gateway" {
  
}

variable "akv_config" {
  
}

variable "global_settings" {
  description = "global settings"
}

variable "logged_user_objectId" {
  
}
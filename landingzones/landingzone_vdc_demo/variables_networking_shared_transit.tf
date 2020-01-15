#### blueprint_networking_shared_transit

variable "public_ip_addr" {
    description = "(Required) configuration for the public IP address"  
}

variable "gateway_config" {
    description = "(Required) configuration object for the virtual network gateway"
}

variable "resource_groups_shared_transit" {
    description = "(Required) resource group for objects in networking transit"
}

variable "networking_transit" {
    description = "(Required) configuration object for transit virtual network"
}

variable "remote_network_connect" {
    description = "(Required) boolean to determine if the connection to remote network is attempted"  
}

variable "connection_name" {
    description = "(Required) name of the remote connection"  
}
variable "remote_network" {
    description = "(Required) name of the network to connect to" 
}

variable "provision_gateway" {
    description = "(Required) determines to deploy the remote network gateway"
    type = bool
}

variable "akv_config" {
    description = "(Required) Configuration object for Azure Key Vault"
}


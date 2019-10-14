#### blueprint_networking_egress

variable "networking_egress" {
    description = "Networking object for the egress"
}

variable "az_fw_name" {
  description = "(Required) name for the Azure Firewall to be created"
}

variable "udr_prefix" {
  description = "(Required) prefix for the user route table"
}

variable "udr_nexthop_type" {
  description = "(Required) next hop type for the user route table - can be of VirtualNetworkGateway, VnetLocal, Internet, VirtualAppliance and None" 
}

variable "udr_nexthop_ip" {
  description = "(Optional) next hop IP address for the user route table" 
}

variable "udr_route_name" {
  description = "(Required) name for the user route table"  
}

variable "subnets_to_udr" {
  description = "Subnet ID to be added to the user route object"
  default = ""
}

variable "ip_addr" {
  description = "(Required) configuration object of the public IP address used for Azure Firewall"
  
}

variable "ip_addr_diags" {
  description = "(Required) configuration object for the public IP address diagnostics"
  
}

variable "az_fw_diags" {
  description = "(Required) configuration object for the Azure Firewall diagnostics"
  
}

variable "resource_groups_shared_egress" {
    description = "(Required) name of the resource group where to deploy the egress objects"  
}

variable "ip_name" {
  description = "(Required) name of the public IP address used for Azure Firewall"  
}



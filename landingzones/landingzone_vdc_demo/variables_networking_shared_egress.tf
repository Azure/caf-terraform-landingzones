#### blueprint_networking_egress

variable "networking_egress" {
    description = "Networking object for the egress"
}

variable "az_fw_config" {
  description = "(Required) configuration object for the Azure Firewall to be created"
}

variable "udr_object" {
  description = "(Required) prefix for the user route table"
}

variable "ip_addr_config" {
  description = "(Required) configuration object of the public IP address used by Azure Firewall"
}

variable "resource_groups_shared_egress" {
    description = "(Required) name of the resource group where to deploy the egress objects"  
}



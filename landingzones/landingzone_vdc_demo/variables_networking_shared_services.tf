#### blueprint_networking_shared_services

variable "shared_services_vnet" {
  description = "Network configuration object for shared services"
}

variable "enable_ddos_standard" {
  description = "Switch to enable DDoS protection standard"
}

variable "ddos_name" {
  description = "DDos name"
}

variable "resource_groups_shared_services" {
  description = "resource group for networking shared services resources"
}

variable "bastion_config" {
  description = "(Required) Configuration object for the Azure Bastion service."
}

variable "enable_bastion" {
  description = "Switch to enable Azure Bastion // reserved for future use"
}

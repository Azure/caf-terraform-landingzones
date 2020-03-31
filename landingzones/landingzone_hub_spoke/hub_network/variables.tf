variable "prefix" {
  description = "(Optional) Prefix to uniquely identify the deployment"  
}

# variable "virtual_network_rg" {
#   description = "(Required) Map of the resource groups to create"
# }

# variable "location" {
#   description = "(Required) Define the region where the resource groups will be created"
# }

# variable "tags" {
#   description = "tags for the deployment"
# }

# variable "shared_services_vnet" {
#   description = "Network configuration"
# }

# variable "enable_network_watcher" {
#   description = "Enable network watcher for the subnet - this will deploy and configure a Linux VM with network watcher extensions."
#   default = false
# }

# variable "subnet_to_deploy_network_monitoring" {
#   description = "Name of the subnet (must be a valid subnet name if the shared services virtual network) wher to deploy the network watcher VM"
#   default = "" 
# }

# variable "log_analytics_workspace" {
  
# }

# variable "diagnostics_map" {
  
# }

# variable "enable_ddos_standard" {
#   description = "(Optional) boolean to switch on/off ddos standard"
# }

# variable "ddos_name" {

# }

# variable "resource_groups_shared_services" {
#   description = "(Required) Resource group to use to host all shared services blueprint resources."
# }

# variable "bastion_config" {
#   description = "(Required) Configuration object for the Azure Bastion service."
# }

# variable "enable_bastion" {
#   description = "Switch to enable Azure Bastion // reserved for future use"
# }

variable "global_settings" {
  description = "global settings"
}

variable "caf_foundations_accounting" {
    description = "caf_foundations_accounting"
}

variable "core_networking" {
    description = "core_networking"
}

variable "location" {
}

variable "rg_network" {
}

variable "logged_user_objectId" {
}
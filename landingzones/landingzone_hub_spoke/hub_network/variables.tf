variable "prefix" {
  description = "(Optional) Prefix to uniquely identify the deployment"  
}

# variable "virtual_network_rg" {
#   description = "(Required) Map of the resource groups to create"
# }

# variable "location" {
#   description = "(Required) Define the region where the resource groups will be created"
# }

variable "tags" {
  description = "tags for the deployment"
}



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
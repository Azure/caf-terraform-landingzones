variable "resource_group_name" {
    description = "(Required) The resource group to which the Application Gateway is being deployed"
}

variable "location" {
    description = "(Required) The geo location to which the Application Gateway is being deployed"
}

variable "subnet_id" {
    description = "(Required) The subnet to which the Application Gateway is being deployed"
}

# variable "publicip_id" {
#     description = "(Required) The public IP ID to to which the Application Gateway is being deployed"
# }

variable "appgw_object" {
    description = "(Required) Application Gateway Settings object"
}

variable "app_object" {
    description = "(Required) Application Gateway, Application Settings object"
}

variable "global_settings" {
  description = "global settings"  
}

variable "caf_foundations_accounting" {
  description = "caf_foundations_accounting settings"
}
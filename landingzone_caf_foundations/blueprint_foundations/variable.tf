
variable "prefix" {
  description = "(Optional) Prefix to uniquely identify the deployment"  
}

variable "resource_groups_hub" {
  description = "(Required) Contains the resource groups object to be created for hub"
}

# Example:
# resource_groups = {
#     apim          = { 
#                     name     = "-apim-demo"
#                     location = "southeastasia" 
#     },
#     networking    = {    
#                     name     = "-networking-demo"
#                     location = "eastasia" 
#     },
#     insights      = { 
#                     name     = "-insights-demo"
#                     location = "francecentral" 
#                     tags     = {
#                       project     = "Pattaya"
#                       approver     = "Gunter"
#                     }   
#     },
# }

variable "location" {
  description = "Azure region to create the resources"
  type        = string
}

# Example:
# location = "southeastasia"

variable "enable_security_center" {
  description = "Enable security cetner"
  type = bool
}

variable "security_center" {
  description = "Attributes: [contact_email,contact_phone]"
  type        = map(string)
}

# Example
# security_center = {
#     contact_email   = "email@email.com" 
#     contact_phone   = "9293829328"
# }

variable "analytics_workspace_name" {
  description = "(Required) Name for the log analytics workspace"
}

variable "tags_hub" {
  description = "map of the tags to be applied"
  type    = map(string)
}

variable "azure_activity_logs_retention" {
    description = "Retention period to keep the Azure Activity Logs in the Azure Storage Account"
}

variable "solution_plan_map" {
  description = "map structure with the list of log analytics solutions to be deployed"
}

variable "azure_diagnostics_logs_retention" {
  description = "Retention period to keep the diagnostics Logs in the Azure Storage Account"
}

variable "provision_rbac" {
  description = "(Optional) defines if the AAD roles and role assignments will be completed. This requires AAD privileged-acount"
  default = false
}

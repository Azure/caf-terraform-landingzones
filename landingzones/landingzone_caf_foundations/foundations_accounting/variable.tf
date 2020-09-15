
variable prefix {
  description = "(Optional) Prefix to uniquely identify the deployment"
}

variable resource_groups_hub {
  description = "(Required) Contains the resource groups object to be created for hub"
}

# Example:
# resource_groups = {
#     apim          = { 
#                     name     = "-apim-demo"
#                     location = "canadacentral" 
#     },
#     networking    = {    
#                     name     = "-networking-demo"
#                     location = "canadaeast" 
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

variable location {
  description = "Azure region to create the resources"
  type        = string
}

# Example:
# location = "canadacentral"

variable tags_hub {
  description = "map of the tags to be applied"
  type        = map(string)
}
variable tags {}

variable convention {

}

variable accounting_settings {

}
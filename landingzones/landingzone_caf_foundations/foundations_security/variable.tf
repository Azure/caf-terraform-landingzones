variable security_settings {}

variable location {
  description = "Azure region to create the resources"
  type        = string
}

variable tags_hub {

}

variable tags {}

variable log_analytics {

}

variable resource_groups_hub {
  description = "(Required) Contains the resource groups object to be created for hub"
}
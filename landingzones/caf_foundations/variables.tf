# Map of the remote data state
variable lowerlevel_storage_account_name {}
variable lowerlevel_container_name {}
variable lowerlevel_key {}
variable lowerlevel_resource_group_name {}

variable tfstate_storage_account_name {}
variable tfstate_container_name {}
variable tfstate_key {}
variable tfstate_resource_group_name {}

variable landingzone_name {
  description = "The landing zone name is used to reference the tfstate in configuration files. Therefore while set it is recommended not to change"
  default     = "foundations"
}

variable rover_version {}
variable level {
  type    = string
  default = "level1"
}
variable logged_user_objectId {
  default = null
}
variable logged_aad_app_objectId {
  default = null
}
variable tags {
  type    = map
  default = {}
}
# Map of the remote data state for lower level
variable lowerlevel_storage_account_name {}
variable lowerlevel_container_name {}
variable lowerlevel_key {}
variable lowerlevel_resource_group_name {}

variable tfstate_storage_account_name {}
variable tfstate_container_name {}
variable tfstate_key {}
variable tfstate_resource_group_name {}

variable tfstates {
  default = {
    caf_foundations = {
      tfstate = "caf_foundations.tfstate"
    }
    networking = {
      tfstate = "caf_networking.tfstate"
    }
  }
}

variable landingzone_name {
  description = "The landing zone name is used to reference the tfstate in configuration files. Therefore while set it is recommended not to change"
  default     = "shared_services"
}

variable global_settings {
  default = {}
}
variable rover_version {}
variable level {
  default = "level2"
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
variable diagnostics_definition {
  default = null
}
variable resource_groups {
  default = null
}
variable automations {
  default = {}
}
variable recovery_vaults {
  default = {}
}
variable replicated_vms {
  default = {}
}
variable network_mappings {
  default = {}
}

# Map of the remote data state
variable lower_storage_account_name {}
variable lower_container_name {}
variable lower_resource_group_name {}

variable tfstate_storage_account_name {
  description = "This value is propulated by the rover"
}
variable tfstate_container_name {
  description = "This value is propulated by the rover"
}
variable tfstate_key {
  description = "This value is propulated by the rover"
}
variable tfstate_resource_group_name {
  description = "This value is propulated by the rover"
}

variable landingzone {
  default = {
    backend_type        = "azurerm"
    global_settings_key = "launchpad"
    level               = "level1"
    key                 = "foundations"
    tfstates = {
      launchpad = {
        level   = "lower"
        tfstate = "caf_launchpad.tfstate"
      }
    }
  }
}

variable tenant_id {}
variable rover_version {}
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

variable enterprise_scale {
  default = {}
}

variable diagnostics_definition {
  default = {}
}
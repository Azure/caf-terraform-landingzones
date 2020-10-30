# Map of the remote data state for lower level
variable lower_storage_account_name {}
variable lower_container_name {}
variable lower_resource_group_name {}

variable tfstate_storage_account_name {}
variable tfstate_container_name {}
variable tfstate_key {}
variable tfstate_resource_group_name {}

variable landingzone {
  default = {
    backend_type        = "azurerm"
    level               = "level2"
    global_settings_key = "foundations"
    key                 = "shared_services"
    tfstates = {
      foundations = {
        level   = "lower"
        tfstate = "caf_foundations.tfstate"
      }
      foundations = {
        level   = "lower"
        tfstate = "caf_foundations.tfstate"
      }
    }
  }
}
variable tenant_id {}
variable global_settings {
  default = {}
}
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
variable diagnostics_definition {
  default = {}
}
variable resource_groups {
  default = {}
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

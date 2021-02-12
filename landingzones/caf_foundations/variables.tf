# Map of the remote data state
variable lower_storage_account_name {}
variable lower_container_name {}
variable lower_resource_group_name {}

variable tfstate_subscription_id {
  description = "This value is propulated by the rover. subscription id hosting the remote tfstates"
}
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
variable keyvaults {
  default = {}
}
variable resource_groups {
  default = {}
}
variable log_analytics {
  default = {}
}
variable event_hub_namespaces {
  default = {}
}
variable diagnostic_storage_accounts {
  default = {}
}
variable diagnostic_event_hub_namespaces {
  default = {}
}
variable diagnostic_log_analytics {
  default = {}
}
variable diagnostics_destinations {
  default = {}
}
variable dynamic_keyvault_secrets {
  default = {}
}

## Azure Active Directory
variable azuread_apps {
  default = {}
}
variable azuread_api_permissions {
  default = {}
}
variable azuread_groups {
  default = {}
}
variable azuread_users {
  default = {}
}
variable azuread_roles {
  default = {}
}
variable managed_identities {
  default = {}
}
variable custom_role_definitions {
  default = {}
}
variable role_mapping {
  default = {
    built_in_role_mapping = {}
    custom_role_mapping   = {}
  }
}
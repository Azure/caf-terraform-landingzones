
variable "landing_zones_variables" {
  default = {}
}
# Map of the remote data state
variable "lower_storage_account_name" {
  description = "This value is propulated by the rover"
}
variable "lower_container_name" {
  description = "This value is propulated by the rover"
}
variable "lower_resource_group_name" {
  description = "This value is propulated by the rover"
}

variable "tfstate_key" {}

variable "tfstate_subscription_id" {
  description = "This value is propulated by the rover. subscription id hosting the remote tfstates"
}
variable "subscription_id_overrides_by_keys" {
  default     = {}
  description = "Map of subscription_id_overrides_by_keys to reference subscriptions created by CAF module."
}

variable "tfstate_storage_account_name" {
  description = "This value is propulated by the rover"
}
variable "tfstate_container_name" {
  description = "This value is propulated by the rover"
}
variable "tfstate_resource_group_name" {
  description = "This value is propulated by the rover"
}

variable "landingzone" {
  default = {
    backend_type        = "azurerm"
    global_settings_key = "launchpad"
    level               = "level1"
    key                 = "gitops"
    tfstates = {
      launchpad = {
        level   = "lower"
        tfstate = "caf_launchpad.tfstate"
      }
    }
  }
}


variable "user_type" {}
variable "tenant_id" {}
variable "rover_version" {}
variable "logged_user_objectId" {
  default = null
}
variable "logged_aad_app_objectId" {
  default = null
}
variable "tags" {
  type    = map(any)
  default = {}
}

#caf solution
variable "diagnostics_definition" {
  default = {}
}
variable "resource_groups" {
  default = {}
}
variable "network_security_group_definition" {
  default = {}
}
variable "vnets" {
  default = {}
}

variable "container_app_jobs" {
  default = {}
}

variable "container_app_environments" {
  default = {}
}

variable "dynamic_keyvault_secrets" {
  default = {}
}

variable "managed_identities" {
  default = {}
}

variable "role_mapping" {
  default = {}
}

variable "keyvaults" {
  default = {}
}
variable "keyvault_access_policies" {
  default = {}
}
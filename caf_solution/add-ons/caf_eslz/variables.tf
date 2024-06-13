
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

variable "diagnostics_definition" {
  default = {}
}

variable "landingzone" {
  default = {
    backend_type        = "azurerm"
    global_settings_key = "launchpad"
    level               = "level1"
    key                 = "enterprise_scale"
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
variable "tags" {
  type    = map(any)
  default = {}
}

variable "root_parent_id" {
  type        = string
  description = "The root_parent_id is used to specify where to set the root for all Landing Zone deployments. Usually the Tenant ID when deploying the core Enterprise-scale Landing Zones."
  default     = null

  validation {
    condition     = can(regex("^[a-zA-Z0-9-_\\(\\)\\.]{1,36}$", var.root_parent_id)) || var.root_parent_id == null
    error_message = "Value must be a valid Management Group ID, consisting of alphanumeric characters, hyphens, underscores, periods and parentheses."
  }
}

variable "root_id" {
  type        = string
  description = "If specified, will set a custom Name (ID) value for the Enterprise-scale \"root\" Management Group, and append this to the ID for all core Enterprise-scale Management Groups."
  default     = "es"

  validation {
    condition     = can(regex("^[a-zA-Z0-9-]{2,10}$", var.root_id))
    error_message = "The root_id value must be between 2 to 10 characters long and can only contain alphanumeric characters and hyphens."
  }
}

variable "root_name" {
  type        = string
  description = "If specified, will set a custom Display Name value for the Enterprise-scale \"root\" Management Group."
  default     = "Enterprise-Scale"

  validation {
    condition     = can(regex("^[A-Za-z][A-Za-z0-9- ._]{1,22}[A-Za-z0-9]?$", var.root_name))
    error_message = "The root_name value must be between 2 to 24 characters long, start with a letter, end with a letter or number, and can only contain space, hyphen, underscore or period characters."
  }
}

variable "deploy_core_landing_zones" {
  type        = bool
  description = "If set to true, will include the core Enterprise-scale Management Group hierarchy."
  default     = false
}

variable "archetype_config_overrides" {
  type = map(
    object({
      archetype_id = string
      parameters = map(map(object({
        hcl_jsonencoded = optional(string)
        integer         = optional(number)
        boolean         = optional(bool)
        value           = optional(string)
        values          = optional(list(string))
        lz_key          = optional(string)
        output_key      = optional(string)
        resource_type   = optional(string)
        resource_key    = optional(string)
        attribute_key   = optional(string)
      }))),
      access_control = map(object({
        managed_identities = optional(object({
          lz_key        = string,
          attribute_key = string,
          resource_keys = list(string)
        }))
        azuread_groups = optional(object({
          lz_key        = string,
          attribute_key = string,
          resource_keys = list(string)
        }))
        azuread_service_principals = optional(object({
          lz_key        = string,
          attribute_key = string,
          resource_keys = list(string)
        }))
        azuread_applications = optional(object({
          lz_key        = string,
          attribute_key = string,
          resource_keys = list(string)
        }))
        principal_ids = optional(list(string))
      }))
    })
  )
  description = "If specified, will set custom Archetype configurations to the default Enterprise-scale Management Groups."
  default     = {}
}

variable "subscription_id_overrides" {
  type        = map(list(string))
  description = "If specified, will be used to assign subscription_ids to the default Enterprise-scale Management Groups."
  default     = {}
}

variable "deploy_demo_landing_zones" {
  type        = bool
  description = "If set to true, will include the demo \"Landing Zone\" Management Groups."
  default     = false
}

variable "custom_landing_zones" {
  type = map(
    object({
      display_name               = string
      parent_management_group_id = string
      subscription_ids           = optional(list(string))
      subscriptions = map(
        object({
          lz_key = string
          key    = string
        })
      )
      archetype_config = object({
        archetype_id = string
        parameters = map(map(object({
          hcl_jsonencoded = optional(string)
          integer         = optional(number)
          boolean         = optional(bool)
          value           = optional(string)
          values          = optional(list(string))
          lz_key          = optional(string)
          output_key      = optional(string)
          resource_type   = optional(string)
          resource_key    = optional(string)
          attribute_key   = optional(string)
        }))),
        access_control = map(object({
          managed_identities = optional(object({
            lz_key        = string,
            attribute_key = string,
            resource_keys = list(string)
          }))
          azuread_groups = optional(object({
            lz_key        = string,
            attribute_key = string,
            resource_keys = list(string)
          }))
          azuread_service_principals = optional(object({
            lz_key        = string,
            attribute_key = string,
            resource_keys = list(string)
          }))
          azuread_applications = optional(object({
            lz_key        = string,
            attribute_key = string,
            resource_keys = list(string)
          }))
          principal_ids = optional(list(string))
        }))
      })
    })
  )
  description = "If specified, will deploy additional Management Groups alongside Enterprise-scale core Management Groups."
  default     = {}

  validation {
    condition     = can(regex("^[a-z0-9-]{2,36}$", keys(var.custom_landing_zones)[0])) || length(keys(var.custom_landing_zones)) == 0
    error_message = "The custom_landing_zones keys must be between 2 to 36 characters long and can only contain lowercase letters, numbers and hyphens."
  }
}

variable "library_path" {
  type        = string
  description = "If specified, sets the path to a custom library folder for archetype artefacts."
  default     = ""
}

variable "template_file_variables" {
  type        = map(any)
  description = "If specified, provides the ability to define custom template variables used when reading in template files from the built-in and custom library_path."
  default     = {}
}

variable "default_location" {
  type        = string
  description = "If specified, will use set the default location used for resource deployments where needed."
  default     = "eastus"

  # Need to add validation covering all Azure locations
}

variable "reconcile_vending_subscriptions" {
  type        = bool
  default     = false
  description = "Will reconcile the subrisciptions created outside of enterprise scale to prevent them to be revoved by the execution of this module."
}

variable "tf_cloud_organization" {
  default     = null
  description = "When user backend_type with remote, set the TFC/TFE organization name."
}

variable "tf_cloud_hostname" {
  default     = "app.terraform.io"
  description = "When user backend_type with remote, set the TFC/TFE hostname."
}

variable "strict_subscription_association" {
  default     = true
  description = "If set to true, subscriptions associated to management groups will be exclusively set by the module and any added by another process will be removed. If set to false, the module will will only enforce association of the specified subscriptions and those added to management groups by other processes will not be removed. Default is false as this works better with subscription vending."
}

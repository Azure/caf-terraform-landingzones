
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

variable "root_parent_id" {
  type        = string
  description = "If specified, will deploy the Enterprise scale bellow the root_parent_id."
  default     = null
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
      subscription_ids           = list(string)
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

variable "deploy_identity_resources" {
  type    = bool
  default = false
}

variable "subscription_id_identity" {
  type = string
}

variable "configure_identity_resources" {
  type = object({
    settings = object({
      identity = object({
        enabled = bool
        config = object({
          enable_deny_public_ip             = bool
          enable_deny_rdp_from_internet     = bool
          enable_deny_subnet_without_nsg    = bool
          enable_deploy_azure_backup_on_vms = bool
        })
      })
    })
  })
  description = "If specified, will customize the \"Identity\" landing zone settings."
  default = {
    settings = {
      identity = {
        enabled = true
        config = {
          enable_deny_public_ip             = true
          enable_deny_rdp_from_internet     = true
          enable_deny_subnet_without_nsg    = true
          enable_deploy_azure_backup_on_vms = true
        }
      }
    }
  }
}

variable "deploy_management_resources" {
  type        = bool
  description = "If set to true, will enable the \"Management\" landing zone settings and add \"Management\" resources into the current Subscription context."
  default     = false
}

variable "configure_management_resources" {
  type = object({
    settings = object({
      log_analytics = object({
        enabled = bool
        config = object({
          retention_in_days                           = number
          enable_monitoring_for_arc                   = bool
          enable_monitoring_for_vm                    = bool
          enable_monitoring_for_vmss                  = bool
          enable_solution_for_agent_health_assessment = bool
          enable_solution_for_anti_malware            = bool
          enable_solution_for_azure_activity          = bool
          enable_solution_for_change_tracking         = bool
          enable_solution_for_service_map             = bool
          enable_solution_for_sql_assessment          = bool
          enable_solution_for_updates                 = bool
          enable_solution_for_vm_insights             = bool
          enable_sentinel                             = bool
        })
      })
      security_center = object({
        enabled = bool
        config = object({
          email_security_contact             = string
          enable_defender_for_app_services   = bool
          enable_defender_for_arm            = bool
          enable_defender_for_containers     = bool
          enable_defender_for_dns            = bool
          enable_defender_for_key_vault      = bool
          enable_defender_for_oss_databases  = bool
          enable_defender_for_servers        = bool
          enable_defender_for_sql_servers    = bool
          enable_defender_for_sql_server_vms = bool
          enable_defender_for_storage        = bool
        })
      })
    })
    location = any
    tags     = any
    advanced = any
  })
  description = "If specified, will customize the \"Management\" landing zone settings and resources."
  default = {
    settings = {
      log_analytics = {
        enabled = true
        config = {
          retention_in_days                           = 30
          enable_monitoring_for_arc                   = true
          enable_monitoring_for_vm                    = true
          enable_monitoring_for_vmss                  = true
          enable_solution_for_agent_health_assessment = true
          enable_solution_for_anti_malware            = true
          enable_solution_for_azure_activity          = true
          enable_solution_for_change_tracking         = true
          enable_solution_for_service_map             = true
          enable_solution_for_sql_assessment          = true
          enable_solution_for_updates                 = true
          enable_solution_for_vm_insights             = true
          enable_sentinel                             = true
        }
      }
      security_center = {
        enabled = true
        config = {
          email_security_contact             = "security_contact@replace_me"
          enable_defender_for_app_services   = true
          enable_defender_for_arm            = true
          enable_defender_for_containers     = true
          enable_defender_for_dns            = true
          enable_defender_for_key_vault      = true
          enable_defender_for_oss_databases  = true
          enable_defender_for_servers        = true
          enable_defender_for_sql_servers    = true
          enable_defender_for_sql_server_vms = true
          enable_defender_for_storage        = true
        }
      }
    }
    location = null
    tags     = null
    advanced = null
  }
}

variable "deploy_connectivity_resources" {
  type        = bool
  description = "If set to true, will enable the \"Connectivity\" landing zone settings and add \"Connectivity\" resources into the current Subscription context."
  default     = false
}

variable "subscription_id_management" {
  type = string
}

variable "subscription_id_connectivity" {
  type = string
}

variable "disable_base_module_tags" {
  type = bool
}

variable "tags" {
  type = map(any)
}

variable "default_tags" {
  type = map(any)
}

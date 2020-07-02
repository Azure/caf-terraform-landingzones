variable launchpad_mode {
  default = "launchpad_light"

  validation {
    condition     = contains(["launchpad_light", "launchpad"], var.launchpad_mode)
    error_message = "Allowed values are launchpad_light or launchpad."
  }
}

variable level {
  default = "level0"

  validation {
    condition     = contains(["level0", "level1", "level2", "level3", "level4"], var.level)
    error_message = "Allowed values are level0, level1, level2, level3 or level4."
  }
}


variable location {
  type        = string
  default     = "southeastasia"
  description = "Location of the launchpad landing zone"
}

# Do not change the default value to be able to upgrade to the standard launchpad
variable "tf_name" {
  description = "Name of the terraform state in the blob storage (Does not include the extension .tfstate)"
  default     = "launchpad"
}

variable convention {
  type    = string
  default = "cafrandom"

  validation {
    condition     = contains(["cafrandom", "random", "passthrough", "cafclassic"], var.convention)
    error_message = "Allowed values are cafrandom, random, passthrough or cafclassic."
  }
}

variable resource_group_name {
  type    = string
  default = "launchpad"
}

variable storage_account_name {
  type    = string
  default = "level0"
}

variable "prefix" {
  description = "(Optional) (Default = null) Generate a prefix that will be used to prepend all resources names"
  default     = null
}


variable keyvaults {
  default = {
    # Do not rename the key "launchpad" to be able to upgrade to the standard launchpad
    launchpad = {
      name                = "launchpad"
      resource_group_name = "caf-foundations"
      region              = "southeastasia"
      convention          = "cafrandom"
      sku_name            = "standard"
    }
  }
}

variable subscriptions {
  default = {
    logged_in_subscription = {
      role_definition_name = "Owner"
      aad_app_key          = "caf_launchpad_level0"
    }
  }
}

variable aad_apps {
  default = {
    # Do not rename the key "launchpad" to be able to upgrade to the standard launchpad
    caf_launchpad_level0 = {
      convention              = "cafrandom"
      useprefix               = true
      application_name        = "caf_launchpad_level0"
      password_expire_in_days = 180
      keyvault = {
        keyvault_key  = "launchpad"
        secret_prefix = "caf-launchpad-level0"
        access_policies = {
          key_permissions    = []
          secret_permissions = ["Get", "List", "Set", "Delete"]
        }
      }
    }
  }
}

variable launchpad_key_names {
  default = {
    keyvault = "launchpad"
    aad_app  = "caf_launchpad_level0"
  }
}

variable custom_role_definitions {
  default = {}
}

variable tags {
  type    = map
  default = {}
}

variable rover_version {}

variable user_type {}

variable logged_user_objectId {}

variable aad_users {
  default = {}
}

variable aad_roles {
  default = {}
}

variable aad_api_permissions {
  default = {}
}

variable github_projects {
  default = {}
}

variable azure_devops {
  default = {}
}

variable environment {
  type        = string
  description = "This variable is set by the rover during the deployment based on the -env or -environment flags. Default to sandpit"
  default     = "Sandpit"
}

#
# runs on: vscode, interactive user
#

level = "level0"
scenarios = {
  launchpad = 100
}

random_length = 5

# Default region
default_region = "region1"

regions = {
  region1 = "southeastasia"
}

launchpad_key_names = {
  keyvault               = "launchpad"
  azuread_app            = "caf_launchpad_level0"
  keyvault_client_secret = "aadapp-caf-launchpad-level0"
  tfstates = [
    "level0"
  ]
}

resource_groups = {
  tfstate = {
    name      = "launchpad-tfstates"
    region    = "region1"
    useprefix = true
  }
  security = {
    name      = "launchpad-security"
    useprefix = true
  }
}


storage_accounts = {
  level0 = {
    name                     = "level0"
    resource_group_key       = "tfstate"
    account_kind             = "BlobStorage"
    account_tier             = "Standard"
    account_replication_type = "RAGRS"
    tags = {
      # Those tags must never be changed while set as they are used by the rover to locate the launchpad and the tfstates.
      tfstate     = "level0"
      environment = "sandpit"
      launchpad   = "launchpad_light" # Do not change. Required for the rover to work in AIRS, Limited privilege environments for demonstration purpuses
      ##
    }
    containers = {
      tfstate = {
        name = "tfstate"
      }
    }
  }
}

keyvaults = {
  # Do not rename the key "launchpad" to be able to upgrade to the standard launchpad
  launchpad = {
    name                = "launchpad"
    resource_group_key  = "security"
    region              = "region1"
    sku_name            = "standard"
    soft_delete_enabled = true

    tags = {
      tfstate     = "level0"
      environment = "sandpit"
    }
  }

}


keyvault_access_policies = {
  # A maximum of 16 access policies per keyvault
  launchpad = {
    logged_in_user = {
      # if the key is set to "logged_in_user" add the user running terraform in the keyvault policy
      # More examples in /examples/keyvault
      secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
    }
    caf_launchpad_level0 = {
      azuread_app_key    = "caf_launchpad_level0"
      secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
    }
  }

}


azuread_apps = {
  # Do not rename the key "launchpad" to be able to upgrade to higher scenario
  caf_launchpad_level0 = {
    useprefix               = true
    application_name        = "caf_launchpad_level0"
    password_expire_in_days = 180
    keyvault = {
      keyvault_key  = "launchpad"
      secret_prefix = "aadapp-caf-launchpad-level0"
    }
  }
}


role_mapping = {
  custom_role_mapping = {}
  built_in_role_mapping = {
    storage_accounts = {
      level0 = {
        "Storage Blob Data Contributor" = {
          logged_in = [
            "user"
          ]
          azuread_apps = [
            "caf_launchpad_level0"
          ]
        }
      }
    }
    subscriptions = {
      logged_in_subscription = {
        "Owner" = {
          azuread_apps = [
            "caf_launchpad_level0"
          ]
        }
      }
    }
  }
}
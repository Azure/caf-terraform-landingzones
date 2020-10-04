#
# runs on: vscode, interactive user
#

landingzone = {
  current = {
    level    = "level0"
    key      = "launchpad"
    scenario = "launchpad 100"
  }
}

backend_type = "azurerm"

# Default region, used if no region is specified in a component configuraiton
default_region = "region1"

# List of the regions to deploy services
regions = {
  region1 = "southeastasia"
  region2 = "eastasia"
}

# Configuration of the launchpad elements keys 
launchpad_key_names = {
  azuread_app            = "caf_launchpad_level0"
  keyvault_client_secret = "aadapp-caf-launchpad-level0"
  tfstates = [
    "level0"
  ]
}

# Name of the resource groups to be created
resource_groups = {
  # resource group key is "tfstate", we re-use the key in the configuration file instead of the "name" field which will be the name as deployed on Azure. 
  level0 = {
    name = "launchpad-level0"
    tags = {
      level = "level0"
    }
  }
}


# Configuration of the storage accounts in the launchpad
storage_accounts = {
  # "level0" is the name of the key and cannot be change. The name can be changed
  level0 = {
    name                     = "level0"
    resource_group_key       = "level0"
    account_kind             = "BlobStorage"
    account_tier             = "Standard"
    account_replication_type = "RAGRS"
    tags = {
      # Those tags must never be changed while set as they are used by the rover to locate the launchpad and the tfstates.
      tfstate     = "level0"
      environment = "sandpit"
      launchpad   = "launchpad" # Do not change. Required for the rover to work in AIRS, Limited privilege environments for demonstration purpuses
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
  level0 = {
    name                = "level0"
    resource_group_key  = "level0"
    region              = "region1"
    sku_name            = "standard"
    soft_delete_enabled = true

    tags = {
      tfstate     = "level0"
      environment = "sandpit"
    }

    creation_policies = {
      logged_in_app = {
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      }
    }
  }

}


keyvault_access_policies = {
  # A maximum of 16 access policies per keyvault
  level0 = {
    caf_launchpad_level0 = {
      azuread_app_key    = "caf_launchpad_level0"
      secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
    }
  }

}


azuread_apps = {
  # Azure AD applications created by the launchpad
  # Do not rename the key "caf_launchpad_level0" to be able to upgrade to higher scenario
  caf_launchpad_level0 = {
    application_name        = "caf_launchpad_level0"
    password_expire_in_days = 180
    keyvaults = {
      level0 = {
        secret_prefix = "aadapp-caf-launchpad-level0"
      }
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
            "app"
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
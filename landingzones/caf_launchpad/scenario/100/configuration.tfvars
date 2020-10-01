#
# runs on: vscode, interactive user
#

level = "level0"
scenarios = {
  launchpad = 100
}

# add 5 random chars at the end of the components name
random_length = 5

# Default region, used if no region is specified in a component configuraiton
default_region = "region1"

# All regions supported by this launchpad
regions = {
  region1 = "southeastasia"
  region2 = "eastasia"
}

# Configuration of the launchpad elements keys 
launchpad_key_names = {
  keyvault               = "launchpad"
  azuread_app            = "caf_launchpad_level0"
  keyvault_client_secret = "aadapp-caf-launchpad-level0"
  tfstates = [
    "level0"
  ]
}

# Name of the resource groups to be created
resource_groups = {
  # resource group key is "tfstate", we re-use the key in the configuration file instead of the "name" field which will be the name as deployed on Azure. 
  tfstate = {
    name      = "launchpad-tfstates"
    region    = "region1"
    useprefix = true
  }
  # resource group key is "security", we re-use the key in the configuration file instead of the "name" field which will be the name as deployed on Azure. 
  security = {
    name      = "launchpad-security"
    useprefix = true
  }
}


# Configuration of the storage accounts in the launchpad
storage_accounts = {
  # "level0" is the name of the key
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
      # if the key is set to "logged_in_user" add the user running terraform in the Key Vault policy
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
  # Azure AD applications created by the launchpad
  # Do not rename the key "caf_launchpad_level0" to be able to upgrade to higher scenario
  caf_launchpad_level0 = {
    useprefix               = true
    application_name        = "caf_launchpad_level0"
    password_expire_in_days = 180
    keyvaults = {
      launchpad = {
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
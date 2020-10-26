landingzone = {
  backend_type = "azurerm"
  current = {
    level = "level0"
    key   = "azdo-devops"
    launchpad = {
      tfstate = "caf_launchpad.tfstate"
    }
  }
}

resource_groups = {
  devops_region1 = {
    name = "PTAZSG-DEV-DEVOPS-AGENT-RG"
  }
}

keyvaults = {
  devops_vm_rg1 = {
    name               = "PTAZSG-DEV-VM-SECRETS-KV"
    resource_group_key = "devops_region1"
    sku_name           = "standard"
  }
}

keyvault_access_policies = {
  # A maximum of 16 access policies per keyvault
  devops_vm_rg1 = {
    logged_in_user = {
      secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
    }
    keyvault_level0_rw = {
      # Reference a key to an azure ad group
      azuread_group_key  = "keyvault_level0_rw"
      secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
    }
  }
  level0 = {
    app-service-improvement-program_to-nonprod = {
      lz_key             = "launchpad"
      azuread_app_key    = "app-service-improvement-program_to-nonprod"
      secret_permissions = ["Get", "List"]
    }
  }
  level1 = {
    app-service-improvement-program_to-nonprod = {
      lz_key             = "launchpad"
      azuread_app_key    = "app-service-improvement-program_to-nonprod"
      secret_permissions = ["Get", "List"]
    }
  }
  level2 = {
    app-service-improvement-program_to-nonprod = {
      lz_key             = "launchpad"
      azuread_app_key    = "app-service-improvement-program_to-nonprod"
      secret_permissions = ["Get", "List"]
    }
  }
  level3 = {
    app-service-improvement-program_to-nonprod = {
      lz_key             = "launchpad"
      azuread_app_key    = "app-service-improvement-program_to-nonprod"
      secret_permissions = ["Get", "List"]
    }
  }
  level4 = {
    app-service-improvement-program_to-nonprod = {
      lz_key             = "launchpad"
      azuread_app_key    = "app-service-improvement-program_to-nonprod"
      secret_permissions = ["Get", "List"]
    }
  }
}


azuread_apps = {

  app-service-improvement-program_to-nonprod = {
    useprefix               = true
    application_name        = "caf-level4-azure-app-service-improvement-program-nonprod"
    password_expire_in_days = 60
    tenant_name             = "PETRONAS.onmicrosoft.com"
    reply_urls              = ["https://localhost"]
    keyvaults = {
      devops_vm_rg1 = {
        secret_prefix = "aadapp-caf-level4-azdo-azure-app-service-improvement-program-nonprod"
      }
    }
  }

}

custom_role_definitions = {

  caf-azdo-to-azure-subscription-nonprod = {
    name        = "caf-azure-devops-azure-app-service-improvement-program-TO-azure-subscription-nonprod"
    useprefix   = true
    description = "CAF Custom role for service principal in Azure Devops to access resources"
    permissions = {
      actions = [
        "Microsoft.Resources/subscriptions/read",
        "Microsoft.KeyVault/vaults/read"
      ]
    }
  }

}


role_mapping = {
  custom_role_mapping = {
    subscriptions = {
      logged_in_subscription = {
        "caf-azdo-to-azure-subscription-nonprod" = {
          azuread_apps = [
            "app-service-improvement-program_to-nonprod"
          ]
        }
      }
    }
  }
  built_in_role_mapping = {
    storage_accounts = {
      scripts_region1 = {
        "Storage Blob Data Contributor" = {
          logged_in = [
            "user"
          ]
        }
      }
    }
  }
}
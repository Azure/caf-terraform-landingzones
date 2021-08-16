# NOTE: required VAULT_ADDR and VAULT_TOKEN for vault provider
# NOTE: Subscription Id and tenant ID needs to be explicitly input to work
landingzone = {
  backend_type        = "azurerm"
  global_settings_key = "launchpad"
  level               = "level1"
  key                 = "vault"
  tfstates = {
    launchpad = {
      level   = "lower"
      tfstate = "caf_launchpad.tfstate"
    }
  }
}

resource_groups = {
  rg1 = "my-example-rg"
}


keyvaults = {
  app1_sp = {
    name               = "app1spkv"
    resource_group_key = "rg1"
    sku_name           = "premium"

    creation_policies = {
      logged_in_user = {
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge"]
      }
    }
  }
}

azuread_applications = {
  azuread_app1 = {
    application_name           = "azuread_app1"
    available_to_other_tenants = true
    home                       = ["https://localhost"]
  }
}

azuread_service_principals = {
  app1_sp = {
    azuread_application = {
      key = "azuread_app1"
    }
  }
}

azuread_credential_policies = {
  default_policy = {
    # Length of the password
    length  = 250
    special = false
    upper   = true
    number  = true

    # Password Expiration date
    expire_in_days = 30
    rotation_key0 = {
      # Odd number
      days = 17
    }
    rotation_key1 = {
      # Even number
      days = 10
    }
  } //password_policy
}

azuread_credentials = {
  app1_sp = {
    type                          = "password"
    azuread_credential_policy_key = "default_policy"

    azuread_application = {
      key = "azuread_app1"
    }
    keyvaults = {
      app1_sp = {
        secret_prefix = "sp"
        tenant_id     = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx" # Tenant id
      }
    }
  }
}


hashicorp_secret_backend_roles = {
  secret_backend1 = {
    backend         = "azure/test"
    role            = "my-role"
    ttl             = 300
    max_ttl         = 600
    subscription_id = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"

    sp_secrets = {
      application_id = {
        output_key    = "azuread_applications"
        resource_key  = "azuread_app1"
        attribute_key = "object_id"
      }
      tenant_id = {
        secret_name  = "sp-tenant-id"
        keyvault_key = "app1_sp"
      }
      client_id = {
        secret_name  = "sp-client-id"
        keyvault_key = "app1_sp"
      }
      client_secret = {
        secret_name  = "sp-client-secret"
        keyvault_key = "app1_sp"
      }
    }

  }

}
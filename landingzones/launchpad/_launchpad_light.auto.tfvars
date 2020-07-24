level           = "level0"

launchpad_key_names = {
  keyvault    = "launchpad"
  aad_app     = "caf_launchpad_level0"
  networking  = "networking_gitops"
}

resource_groups = {
  tfstate     = {
    name        = "launchpad-tfstates"
    location    = "southeastasia"
    useprefix   = true
    max_length  = 40
  }
  security    = {
    name        = "launchpad-security"
    useprefix   = true
    max_length  = 40
  }
  gitops      = {
    name        = "launchpad-devops-agents"
    useprefix   = true
    max_length  = 40
  }
  networking  = {
    name        = "launchpad-networking"
    useprefix   = true
    max_length  = 40
  }
}

storage_account_name = "level0"

keyvaults = {
  # Do not rename the key "launchpad" to be able to upgrade to the standard launchpad
  launchpad = {
    name                = "launchpad"
    resource_group_key  = "security"
    region              = "southeastasia"
    convention          = "cafrandom"
    sku_name            = "standard"
  }
}

subscriptions = {
  logged_in_subscription = {
    role_definition_name = "Owner"
    aad_app_key          = "caf_launchpad_level0"
  }
}

aad_apps =  {
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

diagnostics_settings = {
  resource_diagnostics_name         = "diag"
  azure_diagnostics_logs_event_hub  = false
  resource_group_key                = "gitops"
}

log_analytics = {
  resource_log_analytics_name       = "logs"
  resource_group_key                = "gitops"
  solutions_maps = {
    KeyVaultAnalytics = {
      "publisher" = "Microsoft"
      "product"   = "OMSGallery/KeyVaultAnalytics"
    }
  }
}

networking = {
  networking_gitops = {
    resource_group_key  = "networking"

    vnet = {
      name                = "gitops-vnet"
      address_space       = ["192.168.100.0/24"] 
      dns                 = []
    }

    specialsubnets     = {}

    subnets = {
      level0        = {
        name                = "level0"
        cidr                = ["192.168.100.16/29"]
        nsg_name            = "level0_nsg"
        service_endpoints   = []
        nsg = [
          {
            name                       = "ssh_internet",
            priority                   = "150"
            direction                  = "Inbound"
            access                     = "Allow"
            protocol                   = "*"
            source_port_range          = "*"
            destination_port_range     = "22"
            source_address_prefix      = "*"
            destination_address_prefix = "*"
          },
          {
            name                       = "ssh",
            priority                   = "200"
            direction                  = "Inbound"
            access                     = "Allow"
            protocol                   = "UDP"
            source_port_range          = "*"
            destination_port_range     = "22"
            source_address_prefix      = "192.168.200.8/29"
            destination_address_prefix = "*"
          }
        ]
      }
    }

    diags = {
      log = [
        # ["Category name", "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period] 
        ["VMProtectionAlerts", true, true, 5],
      ]
      metric = [
        #["Category name", "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period] 
        ["AllMetrics", true, true, 2],
      ]
    }
  }
}
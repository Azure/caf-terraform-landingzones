level = "level0"

launchpad_mode = "launchpad"

# Default region. When not set to a resource it will use that value
default_region = "region1"

regions = {
  region1 = "southeastasia"
  region2 = "eastasia"
}

launchpad_key_names = {
  keyvault    = "launchpad"
  azuread_app = "caf_launchpad_level0"
  tfstates = [
    "level0",
    "level1",
    "level2",
    "level3",
    "level4"
  ]
}

resource_groups = {
  tfstate = {
    name   = "launchpad-tfstates"
    region = "region1"
  }
  security = {
    name = "launchpad-security"
  }
  networking = {
    name = "networking"
  }
  ops = {
    name = "operations"
  }
  siem = {
    name = "siem-logs"
  }
  bastion_launchpad = {
    name = "launchpad-bastion"
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
      ## Those tags must never be changed after being set as they are used by the rover to locate the launchpad and the tfstates.
      # Only adjust the environment value at creation time
      tfstate     = "level0"
      environment = "sandpit"
      launchpad   = "launchpad"
      ##
    }
    containers = {
      tfstate = {
        name = "tfstate"
      }
    }
  }

  level1 = {
    name                     = "level1"
    resource_group_key       = "tfstate"
    account_kind             = "BlobStorage"
    account_tier             = "Standard"
    account_replication_type = "RAGRS"
    tags = {
      # Those tags must never be changed while set as they are used by the rover to locate the launchpad and the tfstates.
      tfstate     = "level1"
      environment = "sandpit"
      launchpad   = "launchpad"
    }
    containers = {
      tfstate = {
        name = "tfstate"
      }
    }
  }

  level2 = {
    name                     = "level2"
    resource_group_key       = "tfstate"
    account_kind             = "BlobStorage"
    account_tier             = "Standard"
    account_replication_type = "RAGRS"
    tags = {
      # Those tags must never be changed while set as they are used by the rover to locate the launchpad and the tfstates.
      tfstate     = "level2"
      environment = "sandpit"
      launchpad   = "launchpad"
    }
    containers = {
      tfstate = {
        name = "tfstate"
      }
    }
  }

  level3 = {
    name                     = "level3"
    resource_group_key       = "tfstate"
    account_kind             = "BlobStorage"
    account_tier             = "Standard"
    account_replication_type = "RAGRS"
    tags = {
      # Those tags must never be changed while set as they are used by the rover to locate the launchpad and the tfstates.
      tfstate     = "level3"
      environment = "sandpit"
      launchpad   = "launchpad"
    }
    containers = {
      tfstate = {
        name = "tfstate"
      }
    }
  }

  level4 = {
    name                     = "level4"
    resource_group_key       = "tfstate"
    account_kind             = "BlobStorage"
    account_tier             = "Standard"
    account_replication_type = "RAGRS"
    tags = {
      # Those tags must never be changed while set as they are used by the rover to locate the launchpad and the tfstates.
      tfstate     = "level4"
      environment = "sandpit"
      launchpad   = "launchpad"
    }
    containers = {
      tfstate = {
        name = "tfstate"
      }
    }

    private_endpoints = {
      # Require enforce_private_link_endpoint_network_policies set to true on the subnet
      private-link-level4 = {
        name               = "private-endpoint-stg-level4"
        resource_group_key = "networking"
        vnet_key           = "devops_region1"
        subnet_key         = "release_agent_level4"
        private_service_connection = {
          name                 = "private-endpoint-level4"
          is_manual_connection = false
          subresource_names    = ["Blob"]
        }
      }
    }

  }
}

diagnostic_storage_accounts = {
  # Stores diagnostic logging for region1
  diaglogs_region1 = {
    name                     = "diaglogsrg1"
    region                   = "region1"
    resource_group_key       = "ops"
    account_kind             = "BlobStorage"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    access_tier              = "Cool"
  }
  # Stores diagnostic logging for region2
  diaglogs_region2 = {
    name                     = "diaglogrg2"
    region                   = "region2"
    resource_group_key       = "ops"
    account_kind             = "BlobStorage"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    access_tier              = "Cool"
  }
  # Stores security logs for siem default region"
  diagsiem_region1 = {
    name                     = "siemsg1"
    resource_group_key       = "siem"
    account_kind             = "BlobStorage"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    access_tier              = "Cool"
  }
  # Stores diagnostic logging for region2
  diagsiem_region2 = {
    name                     = "siemrg2"
    region                   = "region2"
    resource_group_key       = "siem"
    account_kind             = "BlobStorage"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    access_tier              = "Cool"
  }
  # Stores boot diagnostic for region1
  bootdiag_region1 = {
    name                     = "bootrg1"
    region                   = "region1"
    resource_group_key       = "ops"
    account_kind             = "StorageV2"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    access_tier              = "Cool"
  }
  # Stores boot diagnostic for region2
  bootdiag_region2 = {
    name                     = "bootrg2"
    region                   = "region2"
    resource_group_key       = "ops"
    account_kind             = "StorageV2"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    access_tier              = "Cool"
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

    # you can setup up to 5 profiles
    diagnostic_profiles = {
      operations = {
        definition_key   = "default_all"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
      siem = {
        definition_key   = "siem_all"
        destination_type = "storage"
        destination_key  = "all_regions"
      }
    }

  }

  secrets = {
    name                = "secrets"
    resource_group_key  = "security"
    region              = "region1"
    sku_name            = "premium"
    soft_delete_enabled = true

    # you can setup up to 5 profiles
    diagnostic_profiles = {
      operations = {
        definition_key   = "default_all"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
      siem = {
        definition_key   = "siem_all"
        destination_type = "storage"
        destination_key  = "all_regions"
      }
    }

    network = {
      # The key must be the vnet's key
      devops_region1 = {
        bypass         = "AzureServices"
        default_action = "Allow"
        ip_rules       = []
        subnet_keys    = ["release_agent_level3", "release_agent_level4"]
      }
    }
  }
}

keyvault_access_policies = {
  # A maximum of 16 access policies per keyvault
  launchpad = {
    bootstrap_user = {
      # azuread_group_key = ""
      # azuread_app_key   = ""

      # can be any object_id to reference an existing azure ad application, group or user
      # if set to "logged_in_user" add the user running terraform in the policy (recommended)
      object_id = "logged_in_user"

      key_permissions         = []
      certificate_permissions = []
      secret_permissions      = ["Set", "Get", "List", "Delete"]
    }
    keyvault_level0_rw = {
      azuread_group_key = "keyvault_level0_rw"
      # azuread_app_key   = ""
      # object_id               = ""

      key_permissions         = []
      certificate_permissions = []
      secret_permissions      = ["Set", "Get", "List", "Delete"]
    }
  }

  secrets = {
    launchpad_bootstrap_user = {
      object_id          = "logged_in_user"
      secret_permissions = ["Set", "Get", "List", "Delete"]
    }
    keyvault_password_rotation = {
      azuread_group_key  = "keyvault_password_rotation"
      secret_permissions = ["Set", "Get", "List", "Delete"]
    }
  }
}

subscriptions = {
  logged_in_subscription = {
    role_definition_name = "Owner"
    aad_app_key          = "caf_launchpad_level0"

    # you can setup up to 5 profiles
    diagnostic_profiles = {
      operations = {
        definition_key   = "subscription_operations"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
      siem = {
        definition_key   = "subscription_siem"
        destination_type = "storage"
        destination_key  = "all_regions"
      }
    }

  }
}


# WIP - only support user_principal_names (note guest accounts have a special representation)
azuread_groups = {
  keyvault_level0_rw = {
    name        = "caf-level0-keyvault-rw"
    description = "Provide read and write access to the keyvault secrets / level0."
    members = {
      user_principal_names = [
      ]
      group_names      = []
      group_object_ids = []
      group_keys       = []

      service_principal_keys = [
        "caf_launchpad_level0"
      ]
      service_principal_object_id = []

    }
    owners = {
      user_principal_names = [
      ]
      service_principal_keys = [
        "caf_launchpad_level0"
      ]
      service_principal_object_id = []
    }
    prevent_duplicate_name = false
  }

  keyvault_level1_rw = {
    name        = "caf-level1-keyvault-rw"
    description = "Provide read and write access to the keyvault secrets and tfstates / level1."
    members = {
    }
    owners = {

    }
    prevent_duplicate_name = false
  }

  keyvault_level2_rw = {
    name        = "caf-level2-keyvault-rw"
    description = "Provide read and write access to the keyvault secrets and tfstates / level2."
    members = {
    }
    owners = {

    }
    prevent_duplicate_name = false
  }

  keyvault_level3_rw = {
    name        = "caf-level3-keyvault-rw"
    description = "Provide read and write access to the keyvault secrets and tfstates / level3."
    members = {
    }
    owners = {

    }
    prevent_duplicate_name = false
  }

  keyvault_level4_rw = {
    name        = "caf-level4-keyvault-rw"
    description = "Provide read and write access to the keyvault secrets and tfstates / level4."
    members = {
    }
    owners = {

    }
    prevent_duplicate_name = false
  }

  caf_launchpad_Reader = {
    name        = "caf-launchpad-Reader"
    description = "Provide Reader role to the caf launchpad landing zone resource groups."
    members = {
    }
    owners = {

    }
    prevent_duplicate_name = false
  }

  keyvault_password_rotation = {
    name        = "caf-level0-password-rotation-rw"
    description = "Provide read and write access to the keyvault secrets / level0."
    members = {
      user_principal_names = [
      ]
      group_names      = []
      group_object_ids = []
      group_keys       = []

      service_principal_keys = [
        "caf_launchpad_level0"
      ]
      service_principal_object_id = []

    }
    owners = {
      user_principal_names = [
      ]
      service_principal_keys = [
        "caf_launchpad_level0"
      ]
      service_principal_object_id = []
    }
    prevent_duplicate_name = false
  }
}

azuread_users = {

  # don't change that key
  aad-user-devops-user-admin = {
    useprefix               = true
    tenant_name             = "terraformdev.onmicrosoft.com"
    user_name               = "caf-level0-security-devops-pat-rotation"
    password_expire_in_days = 180

    # Value must match with var.keyvaults[keyname] to store username and password for password rotation
    keyvault_key = "secrets"
  }

}

azuread_apps = {
  # Do not rename the key "launchpad" to be able to upgrade to the standard launchpad
  caf_launchpad_level0 = {
    #convention              = "cafrandom"
    useprefix               = true
    application_name        = "caf_launchpad_level0"
    password_expire_in_days = 180

    # Store the ${secret_prefix}-client-id, ${secret_prefix}-client-secret...
    keyvaults = {
      launchpad = {
        secret_prefix = "aadapp-caf-launchpad-level0"
        access_policy = {
          secret_permissions = ["Get", "List", "Set", "Delete"]
        }
      }
    }
  }

  # Changing that key requires changing the value of azure_devops.aad_app_key
  azure_devops = {
    useprefix               = true
    application_name        = "caf-level0-security-devops-pat-rotation-aad-app1"
    password_expire_in_days = 60
    tenant_name             = "terraformdev.onmicrosoft.com"
    reply_urls              = ["https://localhost"]
    keyvaults = {
      secrets = {
        secret_prefix = "aadapp-caf-level0-security-devops-pat-rotation-aad-app"
        access_policy = {
          secret_permissions = ["Get", "Set"]
        }
      }
    }
  }

}

#
# Available roles:
# az rest --method Get --uri https://graph.microsoft.com/v1.0/directoryRoleTemplates -o json | jq -r .value[].displayName
#
azuread_app_roles = {
  caf_launchpad_level0 = {
    roles = [
      "Application Developer",
      "User Account Administrator"
    ]
  }
}

managed_identities = {
  level0 = {
    # Used by the release agent to access the level0 keyvault and storage account with the tfstates in read / write
    name               = "launchpad-level0"
    resource_group_key = "security"
  }
  level1 = {
    # Used by the release agent to access the level1 keyvault and storage account with the tfstates in read / write
    # Has read access to level0
    name               = "launchpad-level1"
    resource_group_key = "security"
  }
  level2 = {
    # Used by the release agent to access the level2 keyvault and storage account with the tfstates in read / write
    # Has read access to level1
    name               = "launchpad-level2"
    resource_group_key = "security"
  }
  level3 = {
    # Used by the release agent to access the level3 keyvault and storage account with the tfstates in read / write
    # Has read access to level2
    name               = "launchpad-level3"
    resource_group_key = "security"
  }
  level4 = {
    # Used by the release agent to access the level4 keyvault and storage account with the tfstates in read / write
    # Has read access to level3
    name               = "launchpad-level4"
    resource_group_key = "security"
  }
}

#
# Define the settings for log analytics workspace and solution map
#
log_analytics = {
  central_logs_region1 = {
    region             = "region1"
    name               = "logs"
    resource_group_key = "ops"
    # you can setup up to 5 key
    diagnostic_profiles = {
      central_logs_region1 = {
        definition_key   = "log_analytics"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
    }
    solutions_maps = {
      NetworkMonitoring = {
        "publisher" = "Microsoft"
        "product"   = "OMSGallery/NetworkMonitoring"
      },
      ADAssessment = {
        "publisher" = "Microsoft"
        "product"   = "OMSGallery/ADAssessment"
      },
      ADReplication = {
        "publisher" = "Microsoft"
        "product"   = "OMSGallery/ADReplication"
      },
      AgentHealthAssessment = {
        "publisher" = "Microsoft"
        "product"   = "OMSGallery/AgentHealthAssessment"
      },
      DnsAnalytics = {
        "publisher" = "Microsoft"
        "product"   = "OMSGallery/DnsAnalytics"
      },
      ContainerInsights = {
        "publisher" = "Microsoft"
        "product"   = "OMSGallery/ContainerInsights"
      },
      KeyVaultAnalytics = {
        "publisher" = "Microsoft"
        "product"   = "OMSGallery/KeyVaultAnalytics"
      }
    }
  }
}

#
# Define the settings for the diagnostics settings
# Demonstrate how to log diagnostics in the correct region
# Different profiles to target different operational teams
#
diagnostics_definition = {
  log_analytics = {
    name = "operational_logs_and_metrics"
    categories = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["Audit", true, false, 7],
      ]
      metric = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AllMetrics", true, false, 7],
      ]
    }

  }

  default_all = {
    name = "operational_logs_and_metrics"
    categories = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AuditEvent", true, false, 7],
      ]
      metric = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AllMetrics", true, false, 7],
      ]
    }

  }

  bastion_host = {
    name = "operational_logs_and_metrics"
    categories = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["BastionAuditLogs", true, false, 7],
      ]
    }

  }

  networking_all = {
    name = "operational_logs_and_metrics"
    categories = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["VMProtectionAlerts", true, false, 7],
      ]
      metric = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AllMetrics", true, false, 7],
      ]
    }

  }

  public_ip_address = {
    name = "operational_logs_and_metrics"
    categories = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["DDoSProtectionNotifications", true, false, 7],
        ["DDoSMitigationFlowLogs", true, false, 7],
        ["DDoSMitigationReports", true, false, 7],
      ]
      metric = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AllMetrics", true, false, 7],
      ]
    }

  }

  network_security_group = {
    name = "operational_logs_and_metrics"
    categories = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["NetworkSecurityGroupEvent", true, false, 7],
        ["NetworkSecurityGroupRuleCounter", true, false, 7],
      ]
      # metric = [
      #   #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
      #   ["AllMetrics", false, false, 7],
      # ]
    }

  }

  nic = {
    name = "operational_logs_and_metrics"
    categories = {
      metric = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AllMetrics", false, false, 7],
      ]
    }

  }

  compliance_all = {
    name = "compliance_logs"
    categories = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AuditEvent", true, true, 365],
      ]
      metric = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AllMetrics", false, false, 7],
      ]
    }

  }

  siem_all = {
    name = "siem"
    categories = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AuditEvent", true, true, 0],
      ]

      metric = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AllMetrics", false, false, 0],
      ]
    }

  }

  subscription_operations = {
    name = "subscription_operations"
    categories = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)"]
        ["Administrative", true],
        ["Security", true],
        ["ServiceHealth", true],
        ["Alert", true],
        ["Policy", true],
        ["Autoscale", true],
        ["ResourceHealth", true],
        ["Recommendation", true],
      ]
    }
  }

  subscription_siem = {
    name = "activity_logs_for_siem"
    categories = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)"]
        ["Administrative", false],
        ["Security", true],
        ["ServiceHealth", false],
        ["Alert", false],
        ["Policy", true],
        ["Autoscale", false],
        ["ResourceHealth", false],
        ["Recommendation", false],
      ]
    }

  }

}

diagnostics_destinations = {
  # Storage keys must reference the azure region name
  storage = {
    all_regions = {
      southeastasia = {
        storage_account_key = "diagsiem_region1"
      }
      eastasia = {
        storage_account_key = "diagsiem_region2"
      }
    }
  }

  log_analytics = {
    central_logs = {
      log_analytics_key              = "central_logs_region1"
      log_analytics_destination_type = "Dedicated"
    }
  }
}

custom_role_definitions = {
  caf-launchpad = {
    name        = "caf-launchpad"
    useprefix   = true
    description = "Provide addition permissions on top of built-in Contributor role to manage landing zones deployment"
    permissions = {
      actions = [
        "Microsoft.Authorization/roleAssignments/delete",
        "Microsoft.Authorization/roleAssignments/read",
        "Microsoft.Authorization/roleAssignments/write",
        "Microsoft.Authorization/roleDefinitions/delete",
        "Microsoft.Authorization/roleDefinitions/read",
        "Microsoft.Authorization/roleDefinitions/write",
        "microsoft.insights/diagnosticSettings/delete",
        "microsoft.insights/diagnosticSettings/read",
        "microsoft.insights/diagnosticSettings/write",
        "Microsoft.KeyVault/vaults/delete",
        "Microsoft.KeyVault/vaults/read",
        "Microsoft.KeyVault/vaults/write",
        "Microsoft.KeyVault/vaults/accessPolicies/write",
        "Microsoft.Network/networkSecurityGroups/delete",
        "Microsoft.Network/networkSecurityGroups/read",
        "Microsoft.Network/networkSecurityGroups/write",
        "Microsoft.Network/networkSecurityGroups/join/action",
        "Microsoft.Network/virtualNetworks/subnets/delete",
        "Microsoft.Network/virtualNetworks/subnets/read",
        "Microsoft.Network/virtualNetworks/subnets/write",
        "Microsoft.OperationalInsights/workspaces/delete",
        "Microsoft.OperationalInsights/workspaces/read",
        "Microsoft.OperationalInsights/workspaces/write",
        "Microsoft.OperationalInsights/workspaces/sharedKeys/action",
        "Microsoft.OperationsManagement/solutions/delete",
        "Microsoft.OperationsManagement/solutions/read",
        "Microsoft.OperationsManagement/solutions/write",
        "Microsoft.Storage/storageAccounts/delete",
        "Microsoft.Storage/storageAccounts/read",
        "Microsoft.Storage/storageAccounts/write",
        "Microsoft.Storage/storageAccounts/blobServices/containers/delete",
        "Microsoft.Storage/storageAccounts/blobServices/containers/read",
        "Microsoft.Storage/storageAccounts/blobServices/containers/write",
        "Microsoft.Storage/storageAccounts/blobServices/containers/lease/action",
        "Microsoft.Storage/storageAccounts/blobServices/read",
        "Microsoft.Storage/storageAccounts/listKeys/action",
        "Microsoft.Resources/subscriptions/providers/read",
        "Microsoft.Resources/subscriptions/read",
        "Microsoft.Resources/subscriptions/resourcegroups/delete",
        "Microsoft.Resources/subscriptions/resourcegroups/read",
        "Microsoft.Resources/subscriptions/resourcegroups/write",
        "Microsoft.Network/virtualNetworks/delete",
        "Microsoft.Network/virtualNetworks/read",
        "Microsoft.Network/virtualNetworks/write",
      ]
      data_actions = [
        "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/delete",
        "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/write",
        "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/read",
      ]
    }

  }

  caf-launchpad-contributor = {
    name        = "caf-launchpad-contributor"
    useprefix   = true
    description = "Provide addition permissions on top of built-in Contributor role to manage landing zones deployment"
    permissions = {
      actions = [
        "Microsoft.Authorization/roleAssignments/delete",
        "Microsoft.Authorization/roleAssignments/read",
        "Microsoft.Authorization/roleAssignments/write",
        "Microsoft.Authorization/roleDefinitions/delete",
        "Microsoft.Authorization/roleDefinitions/read",
        "Microsoft.Authorization/roleDefinitions/write",
        "Microsoft.Resources/subscriptions/providers/read"
      ]
      data_actions = [
        "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/delete",
        "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/write",
        "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/read",
      ]
    }
  }

}




#
# Services supported: subscriptions, storage accounts and resource groups
# Can assign roles to: AD groups, AD object ID, AD applications, Managed identities
#
role_mapping = {
  custom_role_mapping = {
    subscription_keys = {
      logged_in_subscription = {
        "caf-launchpad-contributor" = {
          azuread_group_keys = [
            "keyvault_level0_rw", "keyvault_level1_rw", "keyvault_level2_rw", "keyvault_level3_rw", "keyvault_level4_rw",
          ]
          managed_identity_keys = [
            "level0", "level1", "level2", "level3", "level4"
          ]
        }
      }
    }
  }

  built_in_role_mapping = {
    subscription_keys = {
      logged_in_subscription = {
        "Contributor" = {
          azuread_app_keys = [
            "caf_launchpad_level0"
          ]
          managed_identity_keys = [
            "level0", "level1", "level2", "level3", "level4"
          ]
        }
      }
    }
    resource_group_keys = {
      tfstate = {
        "Reader" = {
          azuread_group_keys = [
            "caf_launchpad_Reader"
          ]
        }
      }
      security = {
        "Reader" = {
          azuread_group_keys = [
            "caf_launchpad_Reader"
          ]
        }
      }
      networking = {
        "Reader" = {
          azuread_group_keys = [
            "caf_launchpad_Reader"
          ]
        }
      }
      ops = {
        "Reader" = {
          azuread_group_keys = [
            "caf_launchpad_Reader"
          ]
        }
      }
      siem = {
        "Reader" = {
          azuread_group_keys = [
            "caf_launchpad_Reader"
          ]
        }
      }
    }
    storage_account_keys = {
      level0 = {
        "Storage Blob Data Contributor" = {
          object_ids = [
            "logged_in_user"
          ]
          azuread_group_keys = [
            "keyvault_level0_rw"
          ]
          azuread_app_keys = [
            "caf_launchpad_level0"
          ]
          managed_identity_keys = [
            "level0"
          ]
        }
      }
      level1 = {
        "Storage Blob Data Contributor" = {
          azuread_group_keys = [
            "keyvault_level1_rw"
          ]
          managed_identity_keys = [
            "level1"
          ]
        }
      }
      level2 = {
        "Storage Blob Data Contributor" = {
          azuread_group_keys = [
            "keyvault_level2_rw"
          ]
          managed_identity_keys = [
            "level2"
          ]
        }
      }
      level3 = {
        "Storage Blob Data Contributor" = {
          azuread_group_keys = [
            "keyvault_level3_rw"
          ]
          managed_identity_keys = [
            "level3"
          ]
        }
      }
      level4 = {
        "Storage Blob Data Contributor" = {
          azuread_group_keys = [
            "keyvault_level4_rw"
          ]
          managed_identity_keys = [
            "level4"
          ]
        }
      }
    }
  }

}

azuread_api_permissions = {

  caf_launchpad_level0 = {
    active_directory_graph = {
      resource_app_id = "00000002-0000-0000-c000-000000000000"
      resource_access = {
        active_directory_graph_resource_access_id_Application_ReadWrite_OwnedBy = {
          id   = "824c81eb-e3f8-4ee6-8f6d-de7f50d565b7"
          type = "Role"
        }
        active_directory_graph_resource_access_id_Directory_ReadWrite_All = {
          id   = "78c8a3c8-a07e-4b9e-af1b-b5ccab50a175"
          type = "Role"
        }
      }
    }

    microsoft_graph = {
      resource_app_id = "00000003-0000-0000-c000-000000000000"
      resource_access = {
        microsoft_graph_AppRoleAssignment_ReadWrite_All = {
          id   = "06b708a9-e830-4db3-a914-8e69da51d44f"
          type = "Role"
        }
        microsoft_graph_DelegatedPermissionGrant_ReadWrite_All = {
          id   = "8e8e4742-1d95-4f68-9d56-6ee75648c72a"
          type = "Role"
        }
        microsoft_graph_GroupReadWriteAll = {
          id   = "62a82d76-70ea-41e2-9197-370581804d09"
          type = "Role"
        }
        microsoft_graph_RoleManagement_ReadWrite_Directory = {
          id   = "9e3f62cf-ca93-4989-b6ce-bf83c28f9fe8"
          type = "Role"
        }
      }
    }
  }

}


##################################################
#
# Compute resources
#
##################################################

bastion_hosts = {
  launchpad_host = {
    name               = "bastion"
    resource_group_key = "bastion_launchpad"
    vnet_key           = "devops_region1"
    subnet_key         = "AzureBastionSubnet"
    public_ip_key      = "bastion_host_rg1"

    # you can setup up to 5 profiles
    diagnostic_profiles = {
      operations = {
        definition_key   = "bastion_host"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
    }

  }
}

# Virtual machines
virtual_machines = {

  # Configuration to deploy a bastion host linux virtual machine
  bastion_host = {
    resource_group_key                   = "bastion_launchpad"
    region                               = "region1"
    boot_diagnostics_storage_account_key = "bootdiag_region1"
    provision_vm_agent                   = true

    os_type = "linux"

    # the auto-generated ssh key in keyvault secret. Secret name being {VM name}-ssh-public and {VM name}-ssh-private
    keyvault_key = "secrets"

    # Define the number of networking cards to attach the virtual machine
    networking_interfaces = {
      nic0 = {
        # Value of the keys from networking.tfvars
        vnet_key                = "devops_region1"
        subnet_key              = "jumpbox"
        name                    = "0"
        enable_ip_forwarding    = false
        internal_dns_name_label = "nic0"

        # you can setup up to 5 profiles
        diagnostic_profiles = {
          operations = {
            definition_key   = "nic"
            destination_type = "log_analytics"
            destination_key  = "central_logs"
          }
        }

      }
    }

    virtual_machine_settings = {
      linux = {
        name                            = "bastion"
        size                            = "Standard_F2"
        admin_username                  = "adminuser"
        disable_password_authentication = true

        # Value of the nic keys to attach the VM. The first one in the list is the default nic
        network_interface_keys = ["nic0"]

        os_disk = {
          name                 = "bastion-os"
          caching              = "ReadWrite"
          storage_account_type = "Standard_LRS"
        }

        source_image_reference = {
          publisher = "Canonical"
          offer     = "UbuntuServer"
          sku       = "18.04-LTS"
          version   = "latest"
        }

        identity = {
          type = "UserAssigned"
          managed_identity_keys = [
            "level0", "level1", "level2", "level3", "level4"
          ]
        }

      }
    }

  }
}

##################################################
#
# Networking resources
#
##################################################


public_ip_addresses = {
  bastion_host_rg1 = {
    name                    = "pip1"
    resource_group_key      = "networking"
    sku                     = "Standard"
    allocation_method       = "Static"
    ip_version              = "IPv4"
    idle_timeout_in_minutes = "4"

    # you can setup up to 5 key
    diagnostic_profiles = {
      bastion_host_rg1 = {
        definition_key   = "public_ip_address"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
    }

  }
}

vnets = {
  devops_region1 = {
    resource_group_key = "networking"
    region             = "region1"
    vnet = {
      name          = "devops"
      address_space = ["10.100.100.0/24"]
    }
    specialsubnets = {}
    subnets = {
      AzureBastionSubnet = {
        name    = "AzureBastionSubnet" #Must be called AzureBastionSubnet
        cidr    = ["10.100.100.24/29"]
        nsg_key = "azure_bastion_nsg"
      }
      jumpbox = {
        name              = "jumpbox"
        cidr              = ["10.100.100.32/29"]
        service_endpoints = ["Microsoft.KeyVault"]
        nsg_key           = "jumphost"
      }
      release_agent_level0 = {
        name              = "level0"
        cidr              = ["10.100.100.40/29"]
        service_endpoints = ["Microsoft.KeyVault"]
        route_table_key   = "default_no_internet"
      }
      release_agent_level1 = {
        name              = "level1"
        cidr              = ["10.100.100.48/29"]
        service_endpoints = ["Microsoft.KeyVault"]
        route_table_key   = "default_no_internet"
      }
      release_agent_level2 = {
        name              = "level2"
        cidr              = ["10.100.100.56/29"]
        service_endpoints = ["Microsoft.KeyVault"]
        route_table_key   = "default_no_internet"
      }
      release_agent_level3 = {
        name              = "level3"
        cidr              = ["10.100.100.64/29"]
        service_endpoints = ["Microsoft.KeyVault"]
        route_table_key   = "default_no_internet"
      }
      release_agent_level4 = {
        name                                           = "level4"
        cidr                                           = ["10.100.100.72/29"]
        service_endpoints                              = ["Microsoft.KeyVault"]
        route_table_key                                = "default_no_internet"
        enforce_private_link_endpoint_network_policies = true
      }
    }

    # you can setup up to 5 keys - vnet diganostic
    diagnostic_profiles = {
      vnet = {
        definition_key   = "networking_all"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
    }

  }
}


route_tables = {
  default_no_internet = {
    name               = "default_no_internet"
    resource_group_key = "networking"
  }
}

azurerm_routes = {
  no_internet = {
    name               = "no_internet"
    resource_group_key = "networking"
    route_table_key    = "default_no_internet"
    address_prefix     = "0.0.0.0/0"
    next_hop_type      = "None"
  }
}


#
# Definition of the networking security groups
#
network_security_group_definition = {
  # This entry is applied to all subnets with no NSG defined
  empty_nsg = {

    diagnostic_profiles = {
      nsg = {
        definition_key   = "network_security_group"
        destination_type = "storage"
        destination_key  = "all_regions"
      }
      operations = {
        name             = "operations"
        definition_key   = "network_security_group"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
    }
  }

  azure_bastion_nsg = {

    diagnostic_profiles = {
      nsg = {
        definition_key   = "network_security_group"
        destination_type = "storage"
        destination_key  = "all_regions"
      }
      operations = {
        name             = "operations"
        definition_key   = "network_security_group"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
    }

    nsg = [
      {
        name                       = "bastion-in-allow",
        priority                   = "100"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      {
        name                       = "bastion-control-in-allow-443",
        priority                   = "120"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "135"
        source_address_prefix      = "GatewayManager"
        destination_address_prefix = "*"
      },
      {
        name                       = "Kerberos-password-change",
        priority                   = "121"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "4443"
        source_address_prefix      = "GatewayManager"
        destination_address_prefix = "*"
      },
      {
        name                       = "bastion-vnet-out-allow-22",
        priority                   = "103"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "VirtualNetwork"
      },
      {
        name                       = "bastion-vnet-out-allow-3389",
        priority                   = "101"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "3389"
        source_address_prefix      = "*"
        destination_address_prefix = "VirtualNetwork"
      },
      {
        name                       = "bastion-azure-out-allow",
        priority                   = "120"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "AzureCloud"
      }
    ]
  }

  jumphost = {

    diagnostic_profiles = {
      nsg = {
        definition_key   = "network_security_group"
        destination_type = "storage"
        destination_key  = "all_regions"
      }
      operations = {
        name             = "operations"
        definition_key   = "network_security_group"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
    }

    nsg = [
      {
        name                       = "ssh-inbound-22",
        priority                   = "200"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "VirtualNetwork"
      },
    ]
  }

}


keyvaults = {
  azure_devops_sp = {
    name               = "kvagitopscafaz1idazdo"
    resource_group_key = "sp_secrets"
    sku_name           = "premium"

    creation_policies = {
      keyvault_level0_rw = {
        # Reference a key to an azure ad group
        lz_key             = "launchpad"
        azuread_group_key  = "keyvault_level0_rw"
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      }
    }
  }
}

keyvault_access_policies_azuread_apps = {
  level0 = {
    azure_devops_sp = {
      azuread_app_key    = "azure_devops_sp"
      secret_permissions = ["Get", "List"]
    }
  }
  level1 = {
    azure_devops_sp = {
      azuread_app_key    = "azure_devops_sp"
      secret_permissions = ["Get", "List"]
    }
  }
  level2 = {
    azure_devops_sp = {
      azuread_app_key    = "azure_devops_sp"
      secret_permissions = ["Get", "List"]
    }
  }
  level3 = {
    azure_devops_sp = {
      azuread_app_key    = "azure_devops_sp"
      secret_permissions = ["Get", "List"]
    }
  }
  level4 = {
    azure_devops_sp = {
      azuread_app_key    = "azure_devops_sp"
      secret_permissions = ["Get", "List"]
    }
  }
}
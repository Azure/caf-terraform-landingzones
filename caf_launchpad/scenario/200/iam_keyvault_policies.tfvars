keyvault_access_policies_azuread_apps = {
  level0 = {
    caf_launchpad_level0 = {
      # Reference a key to an azure ad applications
      azuread_app_key    = "caf_launchpad_level0"
      secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
    }
  }
  # A maximum of 16 access policies per keyvault
  level1 = {
    caf_launchpad_level0 = {
      # Reference a key to an azure ad applications
      azuread_app_key    = "caf_launchpad_level0"
      secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
    }
  }

  # A maximum of 16 access policies per keyvault
  level2 = {
    caf_launchpad_level0 = {
      # Reference a key to an azure ad applications
      azuread_app_key    = "caf_launchpad_level0"
      secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
    }
  }


  # A maximum of 16 access policies per keyvault
  level3 = {
    caf_launchpad_level0 = {
      # Reference a key to an azure ad applications
      azuread_app_key    = "caf_launchpad_level0"
      secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
    }
  }


  # A maximum of 16 access policies per keyvault
  level4 = {
    caf_launchpad_level1 = {
      # Reference a key to an azure ad applications
      azuread_app_key    = "caf_launchpad_level0"
      secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
    }
  }
}

keyvault_access_policies = {
  # A maximum of 16 access policies per keyvault
  level0 = {
    keyvault_level0_rw = {
      # Reference a key to an azure ad group
      azuread_group_key  = "keyvault_level0_rw"
      secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
    }
  }
  # A maximum of 16 access policies per keyvault
  level1 = {
    keyvault_level1_rw = {
      # Reference a key to an azure ad group
      azuread_group_key  = "keyvault_level1_rw"
      secret_permissions = ["Get", "List"]
    }
  }

  # A maximum of 16 access policies per keyvault
  level2 = {
    keyvault_level2_rw = {
      # Reference a key to an azure ad group
      azuread_group_key  = "keyvault_level2_rw"
      secret_permissions = ["Get", "List"]
    }
  }


  # A maximum of 16 access policies per keyvault
  level3 = {
    keyvault_level3_rw = {
      # Reference a key to an azure ad group
      azuread_group_key  = "keyvault_level3_rw"
      secret_permissions = ["Get", "List"]
    }
  }


  # A maximum of 16 access policies per keyvault
  level4 = {
    keyvault_level4_rw = {
      # Reference a key to an azure ad group
      azuread_group_key  = "keyvault_level4_rw"
      secret_permissions = ["Get", "List"]
    }
  }

}

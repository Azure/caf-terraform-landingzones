
azuread_groups = {
  keyvault_level0_rw = {
    name        = "caf-level0-keyvault-rw"
    description = "Provide read and write access to the keyvault secrets / level0."
    members = {
      user_principal_names = [
      ]
      group_names = []
      object_ids  = []
      group_keys  = []

      service_principal_keys = [
        "caf_launchpad_level0"
      ]

    }
    owners = {
      user_principal_names = [
      ]
      service_principal_keys = [
        "caf_launchpad_level0"
      ]
    }
    prevent_duplicate_name = false
  }

  keyvault_level1_rw = {
    name        = "caf-level1-landingzones-rw"
    description = "Provide read and write access to manage landingzones / level1."
    members = {
    }
    owners = {

    }
    prevent_duplicate_name = false
  }

  keyvault_level2_rw = {
    name        = "caf-level2-landingzones-rw"
    description = "Provide read and write access to manage landingzones / level2."
    members = {
    }
    owners = {

    }
    prevent_duplicate_name = false
  }

  keyvault_level3_rw = {
    name        = "caf-level3-landingzones-rw"
    description = "Provide read and write access to manage landingzones / level3."
    members = {
    }
    owners = {

    }
    prevent_duplicate_name = false
  }

  keyvault_level4_rw = {
    name        = "caf-level4-applications"
    description = "Provide read access to the applications who need to deploy on the level4."
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
      group_names = []
      object_ids  = []
      group_keys  = []

      service_principal_keys = [
        "caf_launchpad_level0"
      ]

    }
    owners = {
      user_principal_names = [
      ]
      service_principal_keys = [
        "caf_launchpad_level0"
      ]
    }
    prevent_duplicate_name = false
  }
}

azuread_users = {

  # don't change that key
  aad-user-devops-user-admin = {
    useprefix               = true
    user_name               = "caf-level0-security-devops-pat-rotation"
    password_expire_in_days = 180

    # Value must match with var.keyvaults[keyname] to store username and password for password rotation
    keyvault_key = "secrets"
  }

}

azuread_apps = {
  # Do not rename the key "launchpad" to be able to upgrade to the standard launchpad
  caf_launchpad_level0 = {
    useprefix               = true
    application_name        = "caf_launchpad_level0"
    password_expire_in_days = 180

    # Store the ${secret_prefix}-client-id, ${secret_prefix}-client-secret...
    # Set the policy during the creation process of the launchpad
    keyvaults = {
      level0 = {
        secret_prefix = "aadapp-caf-launchpad-level0"
      }
    }
  }

}

#
# Available roles:
# az rest --method Get --uri https://graph.microsoft.com/v1.0/directoryRoleTemplates -o json | jq -r .value[].displayName
#
azuread_roles = {
  azuread_apps = {
    caf_launchpad_level0 = {
      roles = [
        "Application Administrator",
        "Application Developer",
        "User Administrator"
      ]
    }
  }
  managed_identities = {
    level0 = {
      roles = [
        "Directory Readers",
        "Application Developer",
        "User Administrator"
      ]
    }
    level1 = {
      roles = [
        "Directory Readers"
      ]
    }
    level2 = {
      roles = [
        "Directory Readers"
      ]
    }
    level3 = {
      roles = [
        "Directory Readers"
      ]
    }
    level4 = {
      roles = [
        "Directory Readers"
      ]
    }
  }
}

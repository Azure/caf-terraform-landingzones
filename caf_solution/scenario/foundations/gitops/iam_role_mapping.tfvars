
#
# Services supported: subscriptions, storage accounts and resource groups
# Can assign roles to: AD groups, AD object ID, AD applications, Managed identities
#
role_mapping = {
  built_in_role_mapping = {
    resource_groups = {
      networking = {
        "Reader" = {
          azuread_groups = {
            lz_key = "launchpad"
            keys   = ["caf_launchpad_Reader"]
          }
        }
      }
    }

    #
    # From 5.7.0 prefer role mappings for keyvault permissions
    #
    keyvaults = {
      secrets = {
        "Key Vault Secrets Officer" = {
          azuread_groups = {
            lz_key = "launchpad"
            keys   = ["keyvault_level0_rw", "keyvault_password_rotation"]
          }
          azuread_service_principals = {
            lz_key = "launchpad"
            keys   = ["caf_launchpad_level0"]
          }
          logged_in = {
            keys = ["user"]
          }
        }
      }
    }
  }
}

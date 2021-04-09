
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
  }
}

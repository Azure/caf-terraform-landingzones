
#
# Services supported: subscriptions, storage accounts and resource groups
# Can assign roles to: AD groups, AD object ID, AD applications, Managed identities
#
role_mapping = {
  custom_role_mapping = {
    subscriptions = {
      logged_in_subscription = {
        "caf-launchpad-contributor" = {
          azuread_groups = {
            keys = ["keyvault_level0_rw", "keyvault_level1_rw", "keyvault_level2_rw", "keyvault_level3_rw", "keyvault_level4_rw", ]
          }
          managed_identities = {
            keys = ["level0", "level1", "level2", "level3", "level4"]
          }
          azuread_apps = {
            keys = ["caf_launchpad_level0"]
          }
        }
      }
    }
  }

  built_in_role_mapping = {
    subscriptions = {
      logged_in_subscription = {
        "Contributor" = {
          azuread_apps = {
            keys = ["caf_launchpad_level0"]
          }
          managed_identities = {
            keys = ["level0", "level1", "level2", "level3", "level4"]
          }
        }
      }
    }
    resource_groups = {
      level0 = {
        "Reader" = {
          azuread_groups = {
            keys = ["caf_launchpad_Reader"]
          }
        }
      }
      security = {
        "Reader" = {
          azuread_groups = {
            keys = ["caf_launchpad_Reader"]
          }
        }
      }
      ops = {
        "Reader" = {
          azuread_groups = {
            keys = ["caf_launchpad_Reader"]
          }
        }
      }
      siem = {
        "Reader" = {
          azuread_groups = {
            keys = ["caf_launchpad_Reader"]
          }
        }
      }
    }
    storage_accounts = {
      level0 = {
        "Storage Blob Data Contributor" = {
          logged_in = {
            keys = ["user"]
          }
          azuread_groups = {
            keys = ["keyvault_level0_rw"]
          }
          azuread_apps = {
            keys = ["caf_launchpad_level0"]
          }
          managed_identities = {
            keys = ["level0"]
          }
        }
        "Storage Blob Data Reader" = {
          azuread_groups = {
            keys = ["keyvault_level1_rw"]
          }
        }
      }
      level1 = {
        "Storage Blob Data Contributor" = {
          logged_in = {
            keys = ["user"]
          }
          azuread_groups = {
            keys = ["keyvault_level1_rw"]
          }
          managed_identities = {
            keys = ["level1"]
          }
        }
        "Storage Blob Data Reader" = {
          azuread_groups = {
            keys = ["keyvault_level2_rw"]
          }
        }
      }
      level2 = {
        "Storage Blob Data Contributor" = {
          logged_in = {
            keys = ["user"]
          }
          azuread_groups = {
            keys = ["keyvault_level2_rw"]
          }
          managed_identities = {
            keys = ["level2"]
          }
        }
        "Storage Blob Data Reader" = {
          azuread_groups = {
            keys = ["keyvault_level3_rw"]
          }
        }
      }
      level3 = {
        "Storage Blob Data Contributor" = {
          logged_in = {
            keys = ["user"]
          }
          azuread_groups = {
            keys = ["keyvault_level3_rw"]
          }
          managed_identities = {
            keys = ["level3"]
          }
        }
        "Storage Blob Data Reader" = {
          azuread_groups = {
            keys = ["keyvault_level4_rw"]
          }
        }
      }
    }
  }

}


keyvaults = {
  ssh = {
    name                = "sshl0"
    resource_group_key  = "rg1"
    sku_name            = "premium"
    soft_delete_enabled = true

    creation_policies = {
      keyvault_level0_rw = {
        # Reference a key to an azure ad group
        lz_key             = "launchpad"
        azuread_group_key  = "keyvault_level0_rw"
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      }
    }

    # you can setup up to 5 profiles
    diagnostic_profiles = {
      operations = {
        definition_key   = "default_all"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
    }
  }

}

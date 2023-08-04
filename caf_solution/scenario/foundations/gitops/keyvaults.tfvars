
keyvaults = {
  secrets = {
    name                      = "secrets"
    resource_group_key        = "bastion_launchpad"
    region                    = "region1"
    sku_name                  = "premium"
    soft_delete_enabled       = true
    enable_rbac_authorization = true

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

    # creation_policies = {
    #   logged_in_user = {
    #     # if the key is set to "logged_in_user" add the user running terraform in the keyvault policy
    #     # More examples in /examples/keyvault
    #     secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
    #   }
    # }


  }
}

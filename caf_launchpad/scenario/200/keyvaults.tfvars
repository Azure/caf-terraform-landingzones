
keyvaults = {
  level0 = {
    name                      = "level0"
    resource_group_key        = "level0"
    sku_name                  = "standard"
    soft_delete_enabled       = true
    enable_rbac_authorization = true
    tags = {
      caf_tfstate     = "level0"
      caf_environment = "is replaced with real value by the module"
    }

    # Transitioned to enable_rbac_authorization = true

    # creation_policies = {
    #   logged_in_user = {
    #     # if the key is set to "logged_in_user" add the user running terraform in the keyvault policy
    #     # More examples in /examples/keyvault
    #     secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
    #   }
    # }

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

  level1 = {
    name                      = "level1"
    resource_group_key        = "level1"
    sku_name                  = "standard"
    soft_delete_enabled       = true
    enable_rbac_authorization = true
    tags = {
      caf_tfstate     = "level1"
      caf_environment = "is replaced with real value by the module"
    }

    # creation_policies = {
    #   logged_in_user = {
    #     # if the key is set to "logged_in_user" add the user running terraform in the keyvault policy
    #     # More examples in /examples/keyvault
    #     secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
    #   }
    # }

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

  level2 = {
    name                      = "level2"
    resource_group_key        = "level2"
    sku_name                  = "standard"
    soft_delete_enabled       = true
    enable_rbac_authorization = true
    tags = {
      caf_tfstate     = "level2"
      caf_environment = "is replaced with real value by the module"
    }

    # creation_policies = {
    #   logged_in_user = {
    #     # if the key is set to "logged_in_user" add the user running terraform in the keyvault policy
    #     # More examples in /examples/keyvault
    #     secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
    #   }
    # }

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

  level3 = {
    name                      = "level3"
    resource_group_key        = "level3"
    sku_name                  = "standard"
    soft_delete_enabled       = true
    enable_rbac_authorization = true
    tags = {
      caf_tfstate     = "level3"
      caf_environment = "is replaced with real value by the module"
    }

    # creation_policies = {
    #   logged_in_user = {
    #     # if the key is set to "logged_in_user" add the user running terraform in the keyvault policy
    #     # More examples in /examples/keyvault
    #     secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
    #   }
    # }

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

  level4 = {
    name                      = "level4"
    resource_group_key        = "level4"
    sku_name                  = "standard"
    soft_delete_enabled       = true
    enable_rbac_authorization = true
    tags = {
      caf_tfstate     = "level4"
      caf_environment = "is replaced with real value by the module"
    }

    # creation_policies = {
    #   logged_in_user = {
    #     # if the key is set to "logged_in_user" add the user running terraform in the keyvault policy
    #     # More examples in /examples/keyvault
    #     secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
    #   }
    # }


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

}

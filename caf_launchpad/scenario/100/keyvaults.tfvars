
keyvaults = {
  level0 = {
    name                      = "level0"
    resource_group_key        = "level0"
    sku_name                  = "standard"
    soft_delete_enabled       = true
    enable_rbac_authorization = false
    tags = {
      caf_tfstate     = "level0"
      caf_environment = "sandpit"
    }

    creation_policies = {
      logged_in_user = {
        # if the key is set to "logged_in_user" add the user running terraform in the keyvault policy
        # More examples in /examples/keyvault
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      }
    }

  }

  level1 = {
    name                      = "level1"
    resource_group_key        = "level1"
    sku_name                  = "standard"
    soft_delete_enabled       = true
    enable_rbac_authorization = false
    tags = {
      caf_tfstate     = "level1"
      caf_environment = "sandpit"
    }

    creation_policies = {
      logged_in_user = {
        # if the key is set to "logged_in_user" add the user running terraform in the keyvault policy
        # More examples in /examples/keyvault
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      }
    }
  }

  level2 = {
    name                      = "level2"
    resource_group_key        = "level2"
    sku_name                  = "standard"
    soft_delete_enabled       = true
    enable_rbac_authorization = false
    tags = {
      caf_tfstate     = "level2"
      caf_environment = "sandpit"
    }

    creation_policies = {
      logged_in_user = {
        # if the key is set to "logged_in_user" add the user running terraform in the keyvault policy
        # More examples in /examples/keyvault
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      }
    }

  }

  level3 = {
    name                      = "level3"
    resource_group_key        = "level3"
    sku_name                  = "standard"
    soft_delete_enabled       = true
    enable_rbac_authorization = false
    tags = {
      caf_tfstate     = "level3"
      caf_environment = "sandpit"
    }

    creation_policies = {
      logged_in_user = {
        # if the key is set to "logged_in_user" add the user running terraform in the keyvault policy
        # More examples in /examples/keyvault
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      }
    }
  }

  level4 = {
    name                      = "level4"
    resource_group_key        = "level4"
    sku_name                  = "standard"
    soft_delete_enabled       = true
    enable_rbac_authorization = false
    tags = {
      caf_tfstate     = "level4"
      caf_environment = "sandpit"
    }

    creation_policies = {
      logged_in_user = {
        # if the key is set to "logged_in_user" add the user running terraform in the keyvault policy
        # More examples in /examples/keyvault
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      }
    }
  }
}

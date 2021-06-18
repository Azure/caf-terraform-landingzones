landingzone = {
  backend_type        = "azurerm"
  global_settings_key = "launchpad"
  level               = "level1"
  key                 = "vault"
  tfstates = {
    launchpad = {
      level   = "lower"
      tfstate = "caf_launchpad.tfstate"
    }
  }
}
hashicorp_vault_secrets = {
  secret1 = {
    path         = "secret/test"
    disable_read = true # optional
    secrets = {
      username = { # key will be used for secret name in vault
        value = "vmadmin"
      }
      password = {
        value = "password"
      }
      subscription_id = {
        lz_key        = "launchpad"
        output_key    = "client_config"
        attribute_key = "subscription_id"
      }
      lower_rg = {
        lz_key        = "launchpad"
        output_key    = "resource_groups"
        resource_key  = "level0"
        attribute_key = "name"
      }
      lower_rg_1 = {
        lz_key        = "launchpad"
        output_key    = "resource_groups"
        resource_key  = "level1"
        attribute_key = "name"
      }
      client_secret = { # scenario to push secrets from key vault to hashicorp vault applicable mostly for Service Principal passwords.
        secretname   = "sp-client-secret"
        lz_key       = "launchpad"
        keyvault_key = "level1"
      }
    }
  }
  secret2 = {
    path         = "secret/password"
    disable_read = true # optional
    secrets = {
      username = {
        value = "vmadmin"
      }
      password = {
        value = "Welcome@1"
      }
    }
  }
}
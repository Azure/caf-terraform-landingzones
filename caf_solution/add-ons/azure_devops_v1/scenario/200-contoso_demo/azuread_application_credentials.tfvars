azuread_credentials = {
  azure_devops_sp = {
    type                          = "password"
    azuread_credential_policy_key = "default_policy"

    azuread_application = {
      key    = "azure_devops_sp"
    }
    keyvaults = {
      azure_devops_sp = {
        secret_prefix = "sp"
      }
    }
  }
}
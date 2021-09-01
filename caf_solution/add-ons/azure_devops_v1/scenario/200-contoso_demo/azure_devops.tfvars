azure_devops = {

  url = "https://dev.azure.com/azure-terraform/"

  # PAT Token should be updated manually to the keyvault after running launchpad
  pats = {
    admin = {
      secret_name  = "azdo-pat-admin" # created in lauchpad under dynamic secrets tfvars
      lz_key       = "launchpad"
      keyvault_key = "secrets"
    }
  }
}


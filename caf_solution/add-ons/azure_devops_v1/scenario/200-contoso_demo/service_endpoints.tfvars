service_endpoints = {
  contoso_demo = {
    endpoint_name = "contoso_demo-platform"
    subscription = {
      # key = ""
      name = "caf-launchpad"
      id   = "" # key in subscription id
    }

    project_key = "contoso_demo"

    keyvault = {
      lz_key      = "launchpad"
      key         = "azure_devops_sp"
      secret_name = "sp-client-secret"
    }

    azuread_application = {
      lz_key = "launchpad"
      key    = "azure_devops_sp"
    }

  }
}

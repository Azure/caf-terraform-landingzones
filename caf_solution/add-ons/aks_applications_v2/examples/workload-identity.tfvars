namespaces_v1 = {
  demo = {
    name = "wi-demo"
    labels = {
      "used-for" = "workload-identity-testing"
    }
  }
}

workload_identities = {
  mi = {
    name                 = "mi-wi-demo"
    namespace_key        = "demo"
    service_account_name = "workload-sa-mi-demo"
    parent_type          = "managed_identity"
    managed_identity = {
      key = "workload_sa_mi"
      #lz_key = ""
    }
    resource_group = {
      key = "aks_rg"
      #lz_key = ""
    }
  }
  app = {
    display_name         = "app-wi-fed"
    namespace_key        = "demo"
    service_account_name = "workload-sa-app-demo"
    parent_type          = "azuread_application"
    azuread_application = {
      key = "aks_auth_app"
      #lz_key = ""
    }
  }
}
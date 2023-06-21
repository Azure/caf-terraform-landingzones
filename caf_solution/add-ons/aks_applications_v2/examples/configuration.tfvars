# Helm chart definition
helm_charts = {
  falco = {
    name             = "falco"
    create_namespace = false
    namespace        = "falco-system"
    repository       = "https://falcosecurity.github.io/charts"
    chart            = "falco"
    version          = "3.1.3"
  }
}

# namespace creation
namespaces = {
  falco = {
    name = "falco-system"
  }
}

# Keyvault integration for csi driver
kv_csi_driver = {
  workload_kv_reader = {
    aks_clusters = {
      lz_key = "aks"
      key    = "aks_cluster1"
    }
    keyvault = {
      key    = "aks_kv"
      lz_key = "aks"
    }
    role_definition_name = "Key Vault Reader"
  }
}

# kubernetes manifest. More than one in a single file is not supported. separate it with multiple files
manifests = {
  agentconfig = {
    file = "add-ons/aks_applications_v2/examples/files/denyall.yml"
  }
}

# Cluster to authenticate
aks_clusters = {
  lz_key = "aks"
  key    = "cluster_re1"
}

# Keyvault to fetch secrets from in order to authenticate with kubernetes provider. a SP credentials must exists
# and shall have cluster admin role to perform necessary operations
keyvaults = {
  key           = "aks_kv"
  lz_key        = "aks"
  secret_prefix = "aks"
}

# Kubernetes rbac
cluster_role_binding = {
  cluster_admin = {
    name      = "aks-admin-sp"
    role_name = "cluster-admin"
    subjects = {
      aks_admin_sp = {
        # lz key where service principal is created
        lz_key = "aks"
        # SP key
        object_key = "aks_admin_sp"
      }
    }
  }
}
role_binding = {
  ns_admin = {
    name          = "aks-ns-admin-sp"
    namespace_key = "default"
    role_name     = "admin"
    subjects = {
      demouser = {
        # user object id
        name = "e74a2ee6-433c-46b3-b10f-9abac25b1ba8"
      }
    }
  }
}
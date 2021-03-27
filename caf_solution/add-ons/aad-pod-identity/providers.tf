
provider "azurerm" {
  features {
  }
}

provider "kubernetes" {
  host                   = local.k8sconfigs[var.aks_cluster_key].host
  username               = local.k8sconfigs[var.aks_cluster_key].username
  password               = local.k8sconfigs[var.aks_cluster_key].password
  client_certificate     = local.k8sconfigs[var.aks_cluster_key].client_certificate
  client_key             = local.k8sconfigs[var.aks_cluster_key].client_key
  cluster_ca_certificate = local.k8sconfigs[var.aks_cluster_key].cluster_ca_certificate
}

provider "kustomization" {
  kubeconfig_raw = local.k8sconfigs[var.aks_cluster_key].kube_admin_config_raw
}

locals {
  k8sconfigs = {
    for key, value in var.aks_clusters : key => {
      kube_admin_config_raw  = local.remote.aks_clusters[value.lz_key][value.key].kube_admin_config_raw
      host                   = local.remote.aks_clusters[value.lz_key][value.key].enable_rbac ? local.remote.aks_clusters[value.lz_key][value.key].kube_admin_config.0.host : local.remote.aks_clusters[value.lz_key][value.key].kube_config.0.host
      username               = local.remote.aks_clusters[value.lz_key][value.key].enable_rbac ? local.remote.aks_clusters[value.lz_key][value.key].kube_admin_config.0.username : local.remote.aks_clusters[value.lz_key][value.key].kube_config.0.username
      password               = local.remote.aks_clusters[value.lz_key][value.key].enable_rbac ? local.remote.aks_clusters[value.lz_key][value.key].kube_admin_config.0.password : local.remote.aks_clusters[value.lz_key][value.key].kube_config.0.password
      client_certificate     = local.remote.aks_clusters[value.lz_key][value.key].enable_rbac ? base64decode(local.remote.aks_clusters[value.lz_key][value.key].kube_admin_config.0.client_certificate) : base64decode(local.remote.aks_clusters[value.lz_key][value.key].kube_config.0.client_certificate)
      client_key             = local.remote.aks_clusters[value.lz_key][value.key].enable_rbac ? base64decode(local.remote.aks_clusters[value.lz_key][value.key].kube_admin_config.0.client_key) : base64decode(local.remote.aks_clusters[value.lz_key][value.key].kube_config.0.client_key)
      cluster_ca_certificate = local.remote.aks_clusters[value.lz_key][value.key].enable_rbac ? base64decode(local.remote.aks_clusters[value.lz_key][value.key].kube_admin_config.0.cluster_ca_certificate) : base64decode(local.remote.aks_clusters[value.lz_key][value.key].kube_config.0.cluster_ca_certificate)
    }
  }
}
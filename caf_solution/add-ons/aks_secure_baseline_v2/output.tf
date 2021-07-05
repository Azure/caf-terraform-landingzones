output "aks_clusters_kubeconfig" {
  value = {
    aks_kubeconfig_admin_cmd = local.remote.aks_clusters.aks.cluster_re1.aks_kubeconfig_admin_cmd
    aks_kubeconfig_cmd       = local.remote.aks_clusters.aks.cluster_re1.aks_kubeconfig_cmd
  }
  sensitive = false
}

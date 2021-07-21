output "aks_clusters_kubeconfig" {
  value = {
    aks_kubeconfig_admin_cmd = local.remote.aks_clusters[var.aks_clusters[var.aks_cluster_key].lz_key][var.aks_cluster_key].aks_kubeconfig_admin_cmd
    aks_kubeconfig_cmd       = local.remote.aks_clusters[var.aks_clusters[var.aks_cluster_key].lz_key][var.aks_cluster_key].aks_kubeconfig_cmd
  }
  sensitive = false
}

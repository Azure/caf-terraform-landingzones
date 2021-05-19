module "app" {
  source   = "./app"

  cluster     = local.aks_clusters[var.aks_cluster_key]
  namespaces  = var.namespaces
  helm_charts = var.helm_charts
}

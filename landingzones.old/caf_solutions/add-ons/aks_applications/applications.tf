module "app1" {
  source   = "./app"
  for_each = try(local.clusters[var.cluster_re1_key], null) != null ? { (var.cluster_re1_key) = local.clusters[var.cluster_re1_key] } : {}

  cluster     = each.value
  namespaces  = var.namespaces
  helm_charts = var.helm_charts

  providers = {
    kubernetes.k8s = kubernetes.k8s1
    helm.helm      = helm.helm1
  }
}

module "app2" {
  source   = "./app"
  for_each = try(local.clusters[var.cluster_re2_key], null) != null ? { (var.cluster_re2_key) = local.clusters[var.cluster_re2_key] } : {}

  cluster     = each.value
  namespaces  = var.namespaces
  helm_charts = var.helm_charts

  providers = {
    kubernetes.k8s = kubernetes.k8s2
    helm.helm      = helm.helm2
  }
}
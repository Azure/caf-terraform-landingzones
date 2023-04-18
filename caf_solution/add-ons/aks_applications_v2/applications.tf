module "app" {
  source      = "./app"
  namespaces  = var.namespaces
  helm_charts = var.helm_charts
  manifests   = var.manifests
}

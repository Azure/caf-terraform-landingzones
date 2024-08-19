module "app" {
  source        = "./app"
  depends_on    = [module.namespaces_v1]
  namespaces    = var.namespaces
  namespaces_v1 = var.namespaces_v1
  helm_charts   = var.helm_charts
  manifests     = var.manifests
}

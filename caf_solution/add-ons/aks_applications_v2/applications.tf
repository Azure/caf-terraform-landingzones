module "app" {
  source               = "./app"
  namespaces           = var.namespaces
  namespaces_v1        = var.namespaces_v1
  helm_charts          = var.helm_charts
  manifests            = var.manifests
}

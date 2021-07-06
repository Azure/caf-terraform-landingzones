module "app" {
  source      = "../aks_applications/app"
  namespaces  = var.namespaces
  helm_charts = var.helm_charts
}

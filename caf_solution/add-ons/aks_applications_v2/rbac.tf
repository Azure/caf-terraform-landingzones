module "rbac" {
  source      = "./rbac"
  namespaces  = var.namespaces
  helm_charts = var.helm_charts
}
module "app" {
  source                     = "./app"
  namespaces                 = var.namespaces
  helm_charts                = var.helm_charts
  azure_container_registries = local.remote.azure_container_registries
}

module "workload_identity" {
  source               = "./workload_identities"
  for_each             = var.workload_identities
  depends_on           = [module.namespaces_v1]
  managed_identities   = local.remote.managed_identities
  settings             = each.value
  namespaces_v1        = var.namespaces_v1
  resource_groups      = local.remote.resource_groups
  azuread_applications = local.remote.azuread_applications
  aks_cluster_rg_name  = local.remote.aks_clusters[var.aks_clusters.lz_key][var.aks_clusters.key].resource_group_name
  oidc_issuer_url      = try(local.remote.aks_clusters[var.aks_clusters.lz_key][var.aks_clusters.key].oidc_issuer_url, null)
}

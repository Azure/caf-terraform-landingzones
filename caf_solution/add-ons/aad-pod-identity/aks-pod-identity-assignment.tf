resource "azurerm_role_assignment" "kubelet_user_msi" {
  for_each = local.msi_to_grant_permissions

  scope                = each.value.id
  role_definition_name = "Managed Identity Operator"
  principal_id         = local.remote.aks_clusters[var.aks_clusters[var.aks_cluster_key].lz_key][var.aks_cluster_key].kubelet_identity[0].object_id
}

locals {
  msi_to_grant_permissions = {
    for msi in flatten(
      [
        for key, value in var.managed_identities : [
          for msi_key in value.msi_keys : {
            key          = key
            msi_key      = msi_key
            id           = local.remote.managed_identities[value.lz_key][msi_key].id
            principal_id = local.remote.managed_identities[value.lz_key][msi_key].principal_id
          }
        ]
      ]
    ) : format("%s-%s", msi.key, msi.msi_key) => msi
  }
}

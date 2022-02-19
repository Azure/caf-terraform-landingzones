
# Get the details of the node pool's resource group created by AKS
data "azurerm_resource_group" "noderg" {
  for_each = var.aks_clusters
  name     = local.remote.aks_clusters[each.value.lz_key][each.value.key].node_resource_group
}

#
# Set permissions to the kubelet and cluster identity
#
resource "azurerm_role_assignment" "kubelet_noderg_miop" {
  for_each = var.aks_clusters

  scope                = data.azurerm_resource_group.noderg[each.key].id
  role_definition_name = "Managed Identity Operator"
  principal_id         = local.remote.aks_clusters[each.value.lz_key][each.value.key].kubelet_identity[0].object_id
}

resource "azurerm_role_assignment" "kubelet_noderg_vmcontrib" {
  for_each = var.aks_clusters

  scope                = data.azurerm_resource_group.noderg[each.key].id
  role_definition_name = "Virtual Machine Contributor"
  principal_id         = local.remote.aks_clusters[each.value.lz_key][each.value.key].kubelet_identity[0].object_id
}

# Separate subnet
resource "azurerm_role_assignment" "kubelet_subnets_networkcontrib" {
  for_each = toset(try(var.vnets[var.aks_cluster_vnet_key].subnet_keys, [var.vnets[var.aks_cluster_vnet_key].key]))

  scope                = try(var.vnets[var.aks_cluster_vnet_key].subnet_keys != null, false) ? local.remote.vnets[var.vnets[var.aks_cluster_vnet_key].lz_key][var.vnets[var.aks_cluster_vnet_key].key].subnets[each.value].id : local.remote.vnets[var.vnets[var.aks_cluster_vnet_key].lz_key][var.vnets[var.aks_cluster_vnet_key].key].id
  role_definition_name = "Network Contributor"
  principal_id = coalesce(
    try(local.remote.aks_clusters[var.aks_clusters[var.aks_cluster_key].lz_key][var.aks_cluster_key].identity[0].principal_id, null),
    try(local.remote.managed_identities[var.aks_clusters[var.aks_cluster_key].identity.lz_key][var.aks_clusters[var.aks_cluster_key].identity.managed_identity_key].principal_id, null),
    try(var.aks_clusters[var.aks_cluster_key].identity.principal_id, null)
  )
}

# # Whole vnet
# resource "azurerm_role_assignment" "kubelet_vnet_networkcontrib" {
#   for_each = lookup(var.vnets[var.aks_cluster_vnet_key],"subnet_keys",null) == null ? var.vnets : {}

#   scope                = local.remote.vnets[var.vnets[var.aks_cluster_vnet_key].lz_key][var.vnets[var.aks_cluster_vnet_key].key].id
#   role_definition_name = "Network Contributor"
#   principal_id         = local.remote.aks_clusters[var.aks_clusters[var.aks_cluster_key].lz_key][var.aks_cluster_key].identity[0].principal_id
# }

# resource "azurerm_role_assignment" "kubelet_user_msi" {
#   for_each = local.msi_to_grant_permissions

#   scope                = each.value.id
#   role_definition_name = "Managed Identity Operator"
#   principal_id         = local.remote.aks_clusters[var.aks_clusters[var.aks_cluster_key].lz_key][var.aks_cluster_key].kubelet_identity[0].object_id
# }

# locals {
#   msi_to_grant_permissions = {
#     for msi in flatten(
#       [
#         for key, value in var.managed_identities : [
#           for msi_key in value.msi_keys : {
#             key          = key
#             msi_key      = msi_key
#             id           = local.remote.managed_identities[value.lz_key][msi_key].id
#             principal_id = local.remote.managed_identities[value.lz_key][msi_key].principal_id
#           }
#         ]
#       ]
#     ) : format("%s-%s", msi.key, msi.msi_key) => msi
#   }
# }

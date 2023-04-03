resource "azurerm_role_assignment" "for" {
  for_each = var.settings

  principal_id         = try(each.value.aks_clusters.uuid, var.aks_clusters[each.value.aks_cluster[lz_key]][each.value.aks_cluster[key]].addon_profile[0].azure_keyvault_secrets_provider.secret_identity.object_id)
  role_definition_name = each.value.role_definition_name
  scope                = each.value.keyvault[lz_key] == null ? each.value.keyvault[keyvault_id] : var.keyvaults[ each.value.keyvault[lz_key][keyvault_key].id]
}
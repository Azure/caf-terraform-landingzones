resource "azurerm_role_assignment" "for" {
  principal_id         = var.secret_identity_id
  role_definition_name = var.settings.role_definition_name
  scope                = try(var.settings.keyvault.keyvault_id, var.keyvaults[var.settings.keyvault.lz_key][var.settings.keyvault.key].id)
}
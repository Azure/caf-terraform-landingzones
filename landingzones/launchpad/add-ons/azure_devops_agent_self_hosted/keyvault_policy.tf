resource "azurerm_key_vault_access_policy" "msi_landingzone" {
  
  key_vault_id = local.keyvaults[var.azure_devops.pat.keyvault_key].id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = azurerm_user_assigned_identity.user_msi.principal_id

  key_permissions = []

  secret_permissions = [
      "Get",
  ]
}
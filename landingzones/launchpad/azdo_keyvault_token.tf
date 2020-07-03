resource "azurerm_key_vault_secret" "azdo_pat" {

  name         = "azure-devops-management-pat"
  value        = ""
  key_vault_id = azurerm_key_vault.keyvault[var.launchpad_key_names.keyvault].id

  lifecycle {
    ignore_changes = [
      value
    ]
  }
}



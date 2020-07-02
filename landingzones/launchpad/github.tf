resource "azurerm_key_vault_secret" "github_pat" {

  name         = "github-pat"
  value        = ""
  key_vault_id = azurerm_key_vault.keyvault[var.launchpad_key_names.keyvault].id

  lifecycle {
    ignore_changes = [
      value
    ]
  }
}



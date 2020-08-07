resource "azurerm_key_vault_secret" "github_pat" {
  depends_on = [
    azurerm_key_vault_access_policy.keyvault_access_policy
  ]

  name         = "github-pat"
  value        = ""
  key_vault_id = azurerm_key_vault.keyvault[var.launchpad_key_names.keyvault].id

  lifecycle {
    ignore_changes = [
      value
    ]
  }
}



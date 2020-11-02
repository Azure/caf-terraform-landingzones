resource "azurerm_key_vault_secret" "secret" {
  count        = var.value == "" ? 1 : 0
  name         = var.name
  value        = var.value
  key_vault_id = var.keyvault_id

  lifecycle {
    ignore_changes = [
      value
    ]
  }
}

locals {
  azure_devops = var.azure_devops == {} ? {} : lookup(var.azure_devops, "pats", {})
}
resource "azurerm_key_vault_secret" "pat" {
  for_each = local.azure_devops

  name            = each.value.secret_name
  value           =  ""
  key_vault_id    = azurerm_key_vault.keyvault[each.value.keyvault_key].id

  lifecycle {
    ignore_changes = [
      value
    ]
  }
}


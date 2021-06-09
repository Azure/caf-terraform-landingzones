locals {
  transposed = {
    for key, value in var.secrets : key => coalesce(
      try(value.value, null),
      try(var.objects[value.lz_key][value.output_key][value.resource_key][value.attribute_key], null),
      try(var.objects[value.lz_key][value.output_key][value.attribute_key], null),
      try(data.azurerm_key_vault_secret.client_secret[key].value, null)
  ) }
}

data "azurerm_key_vault_secret" "client_secret" {
  for_each = {
    for key, value in var.secrets : key => value
    if try(value.secretname, null) != null && try(value.secretname, null) != ""
  }
  name         = each.value.secretname
  key_vault_id = var.objects[each.value.lz_key].keyvaults[each.value.keyvault_key].id
}

resource "vault_generic_secret" "azuresecrets" {
  path         = var.path
  disable_read = try(var.disable_read, false)
  data_json    = jsonencode(local.transposed)
}

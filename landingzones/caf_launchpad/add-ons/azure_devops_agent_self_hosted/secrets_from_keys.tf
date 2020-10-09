
resource "azurerm_key_vault_secret" "keyvault" {
  for_each = try(var.secrets_from_keys.keyvault_keys, {})

  name         = each.value.secret_name
  value        = try(each.value.lz_key, null) == null ? local.outputs[each.value.output_key][each.key][each.value.attribute_key] : local.outputs[each.value.lz_key][each.value.output_key][each.key][each.value.attribute_key]
  key_vault_id = try(each.value.lz_key, null) == null ? local.outputs.keyvaults[each.value.resource_key].id : local.outputs.keyvaults[each.value.lz_key][each.value.resource_key].id
}


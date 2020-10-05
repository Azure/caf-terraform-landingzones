module secret {
  source   = "./secret"
  for_each = var.settings

  name        = each.value.secret_name
  value       = try(each.value.value, null) == null ? try(var.objects[each.value.output_key][each.value.resource_key][each.value.attribute_key], var.objects[each.value.output_key][each.value.attribute_key]) : each.value.value
  keyvault_id = var.keyvault_id
}

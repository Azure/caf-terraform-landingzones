locals {
  transposed = {
    for key, value in var.secrets : key => coalesce(
      try(value.value, null),
      try(var.objects[value.lz_key][value.output_key][value.resource_key][value.attribute_key], null),
      try(var.objects[value.lz_key][value.output_key][value.attribute_key], null)
  ) }
}
#try(each.value.value, null) == null ? try(var.objects[each.value.output_key][each.value.resource_key][each.value.attribute_key], var.objects[each.value.output_key][each.value.attribute_key]) : each.value.value

resource "vault_generic_secret" "azuresecrets" {
  path         = var.path
  disable_read = try(var.disable_read, false)
  data_json    = jsonencode(local.transposed)
}
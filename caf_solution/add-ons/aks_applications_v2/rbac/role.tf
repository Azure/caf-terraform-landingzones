resource "azurecaf_name" "role" {
  for_each = var.role
  name          = each.value.name
  resource_type = "azurerm_role_definition"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "kubernetes_role_v1" "role" {
  for_each = try(var.role, null) == null ? null : var.role
  metadata {
    annotations = try(each.value.annotations, null)
    labels      = try(each.value.labels, null)
    name = azurecaf_name.role[each.key].result
  }
  dynamic "rule" {
    for_each = try(each.value.rule, {})
      content {
        api_groups = try(rule.value.api_groups, null)
        resource_names = try(rule.value.resource_names, null)
        resources = try(rule.value.resources, null)
        verbs = try(rule.value.verbs, null)
      }
  }
}
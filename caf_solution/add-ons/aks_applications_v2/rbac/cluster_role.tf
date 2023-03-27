# naming convention
resource "azurecaf_name" "cluster_role" {
  for_each = var.cluster_role
  name          = each.value.name
  resource_type = "azurerm_role_definition"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "kubernetes_cluster_role_v1" "cluster_role" {
  for_each = var.cluster_role
  metadata {
    annotations = try(each.value.annotations, null)
    labels      = try(each.value.labels, null)
    name = azurecaf_name.cluster_role[each.key].result
  }
  dynamic "rule" {
    for_each = try(each.value.rule, {})
      content {
        api_groups = try(rule.value.api_groups, null)
        non_resource_urls = try(rule.value.non_resource_urls, null)
        resource_names = try(rule.value.resource_names, null)
        resources = try(rule.value.resources, null)
        verbs = try(rule.value.verbs, null)
      }
  }

  dynamic "aggregation_rule" {
    for_each = try(each.value.aggregation_rule, {})
    content {
      cluster_role_selectors {
        dynamic "match_expressions" {
          for_each = try(aggregation_rule.value.match_expressions, {})
          content {
            key = try(match_expressions.value.key, null)
            operator = try(match_expressions.value.operator, null)
            values   = try(match_expressions.value.values, [])
          }
        }
        match_labels = try(aggregation_rule.match_labels, {})
      }
    }
  }
}

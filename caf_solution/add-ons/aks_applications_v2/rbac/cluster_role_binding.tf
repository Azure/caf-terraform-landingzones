resource "azurecaf_name" "cluster_role_binding" {
  for_each = var.cluster_role_binding
  resource_type = "azurerm_role_assignment"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "kubernetes_cluster_role_binding_v1" "cluster_role_binding" {
  for_each = var.cluster_role_binding
  metadata {
    annotations = try(each.value.annotations, null)
    labels      = try(each.value.labels, null)
    name = azurecaf_name.cluster_role[each.key].result
  }
  role_ref {
    name = try(var.cluster_role[each.value.role_key].name, each.value.role_name)
    kind = "ClusterRole"
    api_group = "rbac.authorization.k8s.io"
  }
  dynamic "subject" {
    for_each = try(each.value.subjects, {})
    content {
        name = subject.value.name
        kind = subject.value.kind
        api_group = "rbac.authorization.k8s.io"
    }
  }
}
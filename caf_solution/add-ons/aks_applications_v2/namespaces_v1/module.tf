resource "kubernetes_namespace" "namespaces" {
  for_each = var.namespaces_v1
  metadata {
    annotations = try(each.value.annotations, null)
    labels      = try(each.value.labels, null)
    name        = each.value.name
  }
}
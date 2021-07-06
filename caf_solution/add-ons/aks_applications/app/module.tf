resource "kubernetes_namespace" "namespaces" {
  for_each = var.namespaces
  metadata {
    annotations = try(each.value.annotations, null)
    labels      = try(each.value.labels, null)
    name        = each.value.name
  }

}

# https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release
resource "helm_release" "charts" {
  for_each = var.helm_charts

  name       = each.value.name
  repository = each.value.repository
  chart      = each.value.chart

  namespace        = each.value.namespace
  wait             = try(each.value.wait, true)
  timeout          = try(each.value.timeout, 900)
  skip_crds        = try(each.value.skip_crds, false)
  create_namespace = try(each.value.create_namespace, false)
  values           = try(each.value.values, null)

  dynamic "set" {
    for_each = try(each.value.sets, {})
    content {
      name  = set.key
      value = set.value
    }
  }

  dynamic "set_sensitive" {
    for_each = try(each.value.sets_sensitive, {})
    content {
      name  = set_sensitive.key
      value = set_sensitive.value
    }
  }


  # depends_on = [kubernetes_namespace.namespaces]
  #   values = [
  #     "${file("values.yaml")}"
  #   ]
}
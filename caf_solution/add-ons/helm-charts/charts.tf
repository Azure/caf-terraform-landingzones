
resource "kubernetes_namespace" "gitlab_runners" {
  for_each = var.aks_namespaces

  metadata {
    name = each.value
  }
}

resource "helm_release" "chart" {
  depends_on = [kubernetes_namespace.gitlab_runners]
  for_each   = var.helm_charts

  chart            = each.value.chart
  create_namespace = try(each.value.create_namespace, false)
  name             = each.value.name
  namespace        = each.value.namespace
  repository       = try(each.value.repository, null)
  timeout          = try(each.value.timeout, 4000)
  values           = [file(each.value.value_file)]
  wait             = try(each.value.wait, true)

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
}
resource "kubernetes_namespace" "namespaces" {
  for_each = var.namespaces
  metadata {
    annotations = try(each.value.annotations, null)
    labels      = try(each.value.labels, null)
    name        = each.value.name
  }

}

resource "kubernetes_manifest" "cluster_manifest" {
  for_each = var.manifests
  manifest = try(yamldecode(each.value.contents), yamldecode(file("$(path.cwd)/each.value.file")), yamldecode(file("$(path.module)/each.value.file")), yamldecode(file(each.value.file)))
}

# https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release
resource "helm_release" "charts" {
  for_each = var.helm_charts

  name       = each.value.name
  repository = each.value.repository
  chart      = each.value.chart

  namespace        = try(each.value.namespace, var.namespaces[each.value.namespace_key].name)
  wait             = try(each.value.wait, true)
  timeout          = try(each.value.timeout, 900)
  skip_crds        = try(each.value.skip_crds, false)
  create_namespace = try(each.value.create_namespace, false)
  values           = try([yamlencode(each.value.contents)], [file("$(path.cwd)/each.value.file")], [file("$(path.module)/each.value.file")], [file(each.value.file)], [])
  version          = try(each.value.version, null)
  atomic           = try(each.value.atomic, false)
  lint             = try(each.value.lint, false)

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

resource "kubernetes_namespace" "namespaces" {
  for_each = var.namespaces
  metadata {
    annotations = try(each.value.annotations, null)
    labels      = try(each.value.labels, null)
    name        = each.value.name
  }

}

# https://docs.microsoft.com/en-us/azure/container-registry/container-registry-helm-repos#authenticate-with-the-registry
data "external" "password" {
  for_each = {
    for key, value in var.helm_charts : key => value
    if try(value.azure_container_registry, null) != null
  }

  program = [
    "bash", "-cx",
    format(
      "az acr login --name %s --expose-token --output json --query '{value: accessToken}'",
      var.azure_container_registries[each.value.azure_container_registry.lz_key][each.value.azure_container_registry.key].name
    )
  ]
}

# https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release
resource "helm_release" "charts" {
  for_each = var.helm_charts

  name                = each.value.name
  chart               = each.value.chart
  namespace           = each.value.namespace
  wait                = try(each.value.wait, true)
  timeout             = try(each.value.timeout, 900)
  skip_crds           = try(each.value.skip_crds, false)
  create_namespace    = try(each.value.create_namespace, false)
  values              = try(each.value.values, null)
  version             = try(each.value.version, null)
  repository_username = try(each.value.azure_container_registry.username, null)
  repository_password = try(data.external.password[each.key].result.value, null)
  repository = try(
    each.value.repository,
    format("oci://%s", var.azure_container_registries[each.value.azure_container_registry.lz_key][each.value.azure_container_registry.key].login_server),
    null
  )

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

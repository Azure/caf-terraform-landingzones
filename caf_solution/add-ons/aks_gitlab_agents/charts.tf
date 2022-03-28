
resource "kubernetes_namespace" "gitlab_runners" {
  for_each = var.aks_namespaces

  metadata {
    name = each.value
  }
}

resource "helm_release" "chart" {
  depends_on = [kubernetes_namespace.gitlab_runners]
  for_each   = var.aad-pod-identity.runnerRegistrationTokens_mapping.mapping

  chart = var.helm.chart
  # create_namespace = try(each.value.create_namespace, false)
  name       = each.value.name
  namespace  = try(each.value.namespace, var.helm.namespace)
  repository = var.helm.repository
  timeout    = try(var.helm.timeout, 4000)
  values     = [file(try(each.value.value_file, var.helm.value_file))]
  wait       = try(var.helm.wait, true)

  set {
    name  = "podLabels.aadpodidbinding"
    value = local.remote.managed_identities[var.aad-pod-identity.runnerRegistrationTokens_mapping.lz_key][each.key].name
  }
}
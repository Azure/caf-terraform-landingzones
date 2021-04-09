# Process the Kustomization in the current folder
data "kustomization_build" "flux" {
  path = "."
}

resource "kustomization_resource" "cluster_secure_baseline_p0" {
  # depends_on = [kubernetes_namespace.cluster_secure_baseline]
  for_each = data.kustomization_build.flux.ids_prio[0]
  manifest = data.kustomization_build.flux.manifests[each.value]
}

resource "kustomization_resource" "cluster_secure_baseline_p1" {
  depends_on = [kustomization_resource.cluster_secure_baseline_p0]
  for_each   = data.kustomization_build.flux.ids_prio[1]
  manifest   = data.kustomization_build.flux.manifests[each.value]
}

resource "kustomization_resource" "cluster_secure_baseline_p2" {
  depends_on = [kustomization_resource.cluster_secure_baseline_p1]
  for_each   = data.kustomization_build.flux.ids_prio[2]
  manifest   = data.kustomization_build.flux.manifests[each.value]
}

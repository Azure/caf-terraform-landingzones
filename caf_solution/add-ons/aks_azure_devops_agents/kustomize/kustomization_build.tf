resource "kustomization_resource" "p0" {
  for_each = var.settings.ids_prio[0]
  manifest = var.settings.manifests[each.value]
}

resource "kustomization_resource" "p1" {
  depends_on = [kustomization_resource.p0]
  for_each   = var.settings.ids_prio[1]
  manifest   = var.settings.manifests[each.value]
}

resource "kustomization_resource" "p2" {
  depends_on = [kustomization_resource.p1]
  for_each   = var.settings.ids_prio[2]
  manifest   = var.settings.manifests[each.value]
}

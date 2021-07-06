module "kustomization" {
  source   = "./kustomize"
  for_each = try(data.kustomization_overlay.manifest, {})

  settings = each.value

}

data "kustomization_overlay" "manifest" {
  for_each = var.kustomization_overlays

  resources = each.value.resources

  namespace = each.value.namespace

  dynamic "patches" {
    for_each = try(each.value.patches, {})
    content {
      patch  = patches.value.patch
      target = patches.value.target
    }
  }
  kustomize_options = {
    load_restrictor = "none"
  }
}

output "manifests" {
  value = data.kustomization_overlay.manifest
}


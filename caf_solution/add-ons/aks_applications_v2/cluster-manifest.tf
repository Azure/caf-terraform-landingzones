resource "kubernetes_manifest" "cluster_manifest" {
  for_each = var.manifests
    manifest = try(yamldecode(each.value.contents), yamldecode(file("$(path.cwd)/each.value.file")), yamldecode(file("$(path.module)/each.value.file")), yamldecode(file(each.value.file)) )
}
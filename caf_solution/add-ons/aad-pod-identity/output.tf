output "manifests" {
  value = data.kustomization_overlay.aad_pod_identity
}

output "managed_identities" {
  value     = local.remote.managed_identities
  sensitive = true
}
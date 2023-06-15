resource "azurecaf_name" "cluster_role_binding" {
  name          = var.settings.name
  resource_type = "azurerm_role_assignment"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "kubernetes_cluster_role_binding_v1" "cluster_role_binding" {
  metadata {
    annotations = try(var.settings.annotations, null)
    labels      = try(var.settings.labels, null)
    name        = azurecaf_name.cluster_role_binding.result
  }
  role_ref {
    name      = try(var.cluster_role[var.settings.role_key].name, var.settings.role_name)
    kind      = "ClusterRole"
    api_group = "rbac.authorization.k8s.io"
  }
  dynamic "subject" {
    for_each = try(var.settings.subjects, {})
    content {
      name      = coalesce(try(subject.value.name, null), try(var.managed_identities[subject.value.lz_key][subject.value.object_key].rbac_id, null), try(var.azuread_service_principals[subject.value.lz_key][subject.value.object_key].rbac_id, null), try(var.azuread_groups[subject.value.lz_key][subject.value.object_key].rbac_id, null))
      kind      = can(subject.value.kind) ? subject.value.kind : can(try(var.managed_identities[subject.value.lz_key][subject.value.object_key].rbac_id, null)) ? "User" : can(try(var.azuread_service_principals[subject.value.lz_key][subject.value.object_key].rbac_id, null)) ? "User" : can(try(var.azuread_groups[subject.value.lz_key][subject.value.object_key].rbac_id, null)) ? "Group" : null
      api_group = "rbac.authorization.k8s.io"
    }
  }
}
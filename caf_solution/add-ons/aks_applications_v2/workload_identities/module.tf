locals {
  subject = "system:serviceaccount:${try(var.namespaces_v1[var.settings.namespace_key].name, var.settings.namespace_name)}:${var.settings.service_account_name}"
}

resource "kubernetes_service_account_v1" "workload_sa" {
  metadata {
    annotations = {
      "azure.workload.identity/client-id" = try(var.settings.managed_identity.client_id, var.managed_identities[var.settings.managed_identity.lz_key][var.settings.managed_identity.key].client_id, var.settings.azuread_application.application_id, var.azuread_applications[var.settings.azuread_application.lz_key][var.settings.azuread_application.key].application_id)
    }
    name      = var.settings.service_account_name
    namespace = try(var.namespaces_v1[var.settings.namespace_key].name, var.settings.namespace_name)
  }
}

resource "azurerm_federated_identity_credential" "fed_cred" {
  count               = try(var.settings.managed_identity, null) == null ? 0 : 1
  name                = var.settings.name
  resource_group_name = try(var.settings.resource_group_name, var.resource_groups[var.settings.resource_group.lz_key][var.settings.resource_group.key].name, var.aks_cluster_rg_name)
  audience            = try(var.settings.audience, ["api://AzureADTokenExchange"])
  issuer              = try(var.settings.issuer_url, var.oidc_issuer_url)
  parent_id           = try(var.settings.managed_identity.id, var.managed_identities[var.settings.managed_identity.lz_key][var.settings.managed_identity.key].id)
  subject             = local.subject
}

resource "azuread_application_federated_identity_credential" "fed_cred" {
  count                 = try(var.settings.azuread_application, null) == null ? 0 : 1
  application_object_id = try(var.settings.azuread_application.object_id, var.azuread_applications[var.settings.azuread_application.lz_key][var.settings.azuread_application.key].object_id)
  display_name          = var.settings.display_name
  description           = try(var.settings.description, null)
  audiences             = ["api://AzureADTokenExchange"]
  issuer                = try(var.settings.issuer_url, var.oidc_issuer_url)
  subject               = local.subject
}
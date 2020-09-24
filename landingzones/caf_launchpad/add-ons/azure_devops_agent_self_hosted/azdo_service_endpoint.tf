locals {
  service_endpoints = try(var.azure_devops.service_endpoints, {})
}

data "azurerm_key_vault_secret" "client_secret" {
  for_each = local.service_endpoints

  name         = format("%s-client-secret", local.aad_apps[each.value.aad_app_key].keyvaults[each.value.secret_keyvault_key].secret_name_client_secret)
  key_vault_id = local.aad_apps[each.value.aad_app_key].keyvaults[each.value.secret_keyvault_key].id
}

resource "azuredevops_serviceendpoint_azurerm" "azure" {
  for_each = local.service_endpoints

  project_id            = data.azuredevops_project.project.id
  service_endpoint_name = each.value.endpoint_name
  credentials {
    serviceprincipalid  = local.aad_apps[each.value.aad_app_key].azuread_application.application_id
    serviceprincipalkey = data.azurerm_key_vault_secret.client_secret[each.key].value
  }
  azurerm_spn_tenantid      = local.aad_apps[each.value.aad_app_key].tenant_id
  azurerm_subscription_id   = each.value.subscription_id
  azurerm_subscription_name = each.value.subscription_name
}

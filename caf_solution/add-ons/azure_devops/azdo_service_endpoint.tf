
data "azurerm_key_vault_secret" "client_secret" {
  depends_on = [module.caf]
  for_each   = try(var.azure_devops.service_endpoints, {})

  name         = format("%s-client-secret", local.combined.aad_apps[var.landingzone.key][each.value.aad_app_key].keyvaults[each.value.secret_keyvault_key].secret_name_client_secret)
  key_vault_id = local.combined.aad_apps[var.landingzone.key][each.value.aad_app_key].keyvaults[each.value.secret_keyvault_key].id
}

resource "azuredevops_serviceendpoint_azurerm" "azure" {
  depends_on = [module.caf]
  for_each   = try(var.azure_devops.service_endpoints, {})

  project_id            = data.azuredevops_project.project.id
  service_endpoint_name = each.value.endpoint_name
  credentials {
    serviceprincipalid  = local.combined.aad_apps[var.landingzone.key][each.value.aad_app_key].azuread_application.application_id
    serviceprincipalkey = data.azurerm_key_vault_secret.client_secret[each.key].value
  }
  azurerm_spn_tenantid      = local.combined.aad_apps[var.landingzone.key][each.value.aad_app_key].tenant_id
  azurerm_subscription_id   = each.value.subscription_id
  azurerm_subscription_name = each.value.subscription_name
}

#
# Grant acccess to service endpoint to all pipelines in the project
#

resource "azuredevops_resource_authorization" "endpoint" {
  for_each = azuredevops_serviceendpoint_azurerm.azure

  project_id  = data.azuredevops_project.project.id
  resource_id = each.value.id
  type        = "endpoint"
  authorized  = true
}
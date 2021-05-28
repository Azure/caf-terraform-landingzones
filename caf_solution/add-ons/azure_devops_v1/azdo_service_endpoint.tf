
data "azurerm_key_vault_secret" "client_secret" {
  for_each   = var.service_endpoints

  name         = each.value.keyvault.secret_name
  key_vault_id = local.remote.keyvaults[each.value.keyvault.lz_key][each.value.keyvault.key].id
}

resource "azuredevops_serviceendpoint_azurerm" "azure" {
  for_each   = var.service_endpoints

  project_id            = data.azuredevops_project.project[each.value.project_key].id
  service_endpoint_name = each.value.endpoint_name
  credentials {
    serviceprincipalid  = local.remote.azuread_applications[each.value.azuread_application.lz_key][each.value.azuread_application.key].application_id
    serviceprincipalkey = data.azurerm_key_vault_secret.client_secret[each.key].value
  }
  azurerm_spn_tenantid      = local.remote.azuread_applications[each.value.azuread_application.lz_key][each.value.azuread_application.key].tenant_id
  azurerm_subscription_id   = each.value.subscription.id
  azurerm_subscription_name = each.value.subscription.name
}

#
# Grant acccess to service endpoint to all pipelines in the project
#

resource "azuredevops_resource_authorization" "endpoint" {
  for_each   = var.service_endpoints

  project_id  = data.azuredevops_project.project[each.value.project_key].id
  resource_id = azuredevops_serviceendpoint_azurerm.azure[each.key].id
  type        = "endpoint"
  authorized  = true
}
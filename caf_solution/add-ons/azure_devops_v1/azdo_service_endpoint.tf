
# To support cross subscription
data "external" "client_secret" {
  for_each = var.service_endpoints
  program = [
    "bash", "-c",
    format(
      "az keyvault secret show --id '%s'secrets/'%s' --query '{value: value}' -o json",
      local.remote.keyvaults[each.value.keyvault.lz_key][each.value.keyvault.key].vault_uri,
      each.value.keyvault.secret_name
    )
  ]
}

resource "azuredevops_serviceendpoint_azurerm" "azure" {
  for_each = var.service_endpoints

  project_id            = data.azuredevops_project.project[each.value.project_key].id
  service_endpoint_name = each.value.endpoint_name
  credentials {
    serviceprincipalid  = local.remote.azuread_applications[each.value.azuread_application.lz_key][each.value.azuread_application.key].application_id
    serviceprincipalkey = data.external.client_secret[each.key].result.value
  }
  azurerm_spn_tenantid      = local.remote.azuread_applications[each.value.azuread_application.lz_key][each.value.azuread_application.key].tenant_id
  azurerm_subscription_id   = each.value.subscription.id
  azurerm_subscription_name = each.value.subscription.name
}

#
# Grant acccess to service endpoint to all pipelines in the project
#

resource "azuredevops_resource_authorization" "endpoint" {
  for_each = var.service_endpoints

  project_id  = data.azuredevops_project.project[each.value.project_key].id
  resource_id = azuredevops_serviceendpoint_azurerm.azure[each.key].id
  type        = "endpoint"
  authorized  = true
}

# data "azurerm_key_vault_secret" "client_secret" {
#   for_each   = var.service_endpoints

#   name         = format("%s-client-secret", local.remote.aad_apps[each.value.lz_key][each.value.azuread_apps_key].keyvaults[each.value.keyvault_key].secret_name_client_secret)
#   key_vault_id = local.remote.aad_apps[each.value.lz_key][each.value.azuread_apps_key].keyvaults[each.value.keyvault_key].id
# }

# resource "azuredevops_serviceendpoint_azurerm" "azure" {
#   for_each   = var.service_endpoints

#   project_id            = data.azuredevops_project.project[each.value.project_key].id
#   service_endpoint_name = each.value.endpoint_name
#   credentials {
#     serviceprincipalid  = local.remote.aad_apps[each.value.lz_key][each.value.azuread_apps_key].azuread_application.application_id
#     serviceprincipalkey = data.azurerm_key_vault_secret.client_secret[each.key].value
#   }
#   azurerm_spn_tenantid      = local.remote.aad_apps[each.value.lz_key][each.value.azuread_apps_key].tenant_id
#   azurerm_subscription_id   = each.value.subscription.id
#   azurerm_subscription_name = each.value.subscription.name
# }

# #
# # Grant acccess to service endpoint to all pipelines in the project
# #

# resource "azuredevops_resource_authorization" "endpoint" {
#   for_each   = var.service_endpoints

#   project_id  = data.azuredevops_project.project.id
#   resource_id = azuredevops_serviceendpoint_azurerm.azure[each.key].id
#   type        = "endpoint"
#   authorized  = true
# }
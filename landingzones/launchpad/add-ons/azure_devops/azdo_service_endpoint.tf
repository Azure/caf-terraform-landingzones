locals {
  service_endpoints = lookup(var.azure_devops, "service_endpoints", {})
}

data "azurerm_key_vault_secret" "client_secret" {
  for_each = local.service_endpoints

  name         = local.aad_apps[each.value.aad_app_key].azuread_service_principal.keyvault_client_secret
  key_vault_id = local.aad_apps[each.value.aad_app_key].azuread_service_principal.keyvault_id
}

resource "azuredevops_serviceendpoint_azurerm" "azure" {
  for_each = local.service_endpoints

	project_id             = data.azuredevops_project.project.id
	service_endpoint_name  = each.value.endpoint_name
	credentials {
		serviceprincipalid 	= local.aad_apps[each.value.aad_app_key].azuread_application.application_id
		serviceprincipalkey = data.azurerm_key_vault_secret.client_secret[each.key].value
	}
	azurerm_spn_tenantid      = local.aad_apps[each.value.aad_app_key].tenant_id
  azurerm_subscription_id   = each.value.subscription_id
  azurerm_subscription_name = each.value.subscription_name
}

resource "azurerm_role_definition" "devops" {
  for_each = local.service_endpoints
  name        = format("caf-azure-devops-to-%s", each.value.subscription_name)
  scope       = format("/subscriptions/%s", each.value.subscription_id)
  description = "CAF Custom role for service principal in Azure Devops to access resources"

  permissions {
    actions     = [
      "Microsoft.Resources/subscriptions/read",
      "Microsoft.KeyVault/vaults/read"
    ]
    not_actions = []
  }

  assignable_scopes = [
    format("/subscriptions/%s", each.value.subscription_id),
  ]
}

resource "azurerm_role_assignment" "devops" {
  for_each = local.service_endpoints

  scope               = format("/subscriptions/%s", each.value.subscription_id)
  role_definition_id  = azurerm_role_definition.devops[each.key].id
  principal_id        = local.aad_apps[each.value.aad_app_key].azuread_service_principal.object_id
}
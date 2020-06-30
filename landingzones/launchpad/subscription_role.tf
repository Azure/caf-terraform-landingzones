resource "azurerm_role_assignment" "subscription" {
  for_each = var.subscriptions

  scope                = each.key == "logged_in_subscription" ? format("/subscriptions/%s", data.azurerm_subscription.primary.subscription_id) : format("/subscriptions/%s", each.value.subscription_id)
  role_definition_name = each.value.role_definition_name
  principal_id         = module.azure_applications.aad_apps[each.value.aad_app_key].azuread_service_principal.object_id
}
#
# permissions required: 
#   - vso.variablegroups_manage   (create)
#   + vso.buid                    (update)
#   + vso.build_execute           (destroy)
#
resource "azuredevops_variable_group" "variable_group" {
  depends_on = [
    azurerm_role_assignment.devops,
    azurerm_key_vault_access_policy.devops
  ]
  for_each  = {
    for key, variable_group in var.azure_devops.variable_groups : key => variable_group
  }

  project_id   = data.azuredevops_project.project.id
  name         = each.value.name
  description  = lookup(each.value, "description", null)
  
  allow_access = lookup(each.value, "allow_access", false)

  dynamic "key_vault" {
    for_each = lookup(each.value, "keyvault", null) == null ? [] : [1]

    content {
      name = local.keyvaults[each.value.keyvault.keyvault_key].name
      service_endpoint_id   = azuredevops_serviceendpoint_azurerm.azure[each.value.keyvault.serviceendpoint_key].id
    }
  }

  dynamic "variable" {
    for_each = flatten([
      for key, variables in each.value.variables :  [
        for key1, variable1 in variables : {
          name        = key1 == "name" ? variable1 : key1
          value       = key1 == "name" ? null : variable1
        }
      ]
    ])

    content {
      # When used with Keyvault, the name must be the keyvault secret name and value must not be set
      name        = variable.value.name
      value       = variable.value.value
    }
  }

}

resource "azurerm_key_vault_access_policy" "devops" {
  depends_on = [azuread_service_principal_password.aad_apps]
  for_each = var.azure_devops.serviceendpoints

  key_vault_id = local.keyvaults[each.value.keyvault.keyvault_key].id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = azuread_service_principal.aad_apps[each.value.aad_app_key].object_id

  key_permissions = each.value.keyvault.key_permissions
  secret_permissions = each.value.keyvault.secret_permissions

}
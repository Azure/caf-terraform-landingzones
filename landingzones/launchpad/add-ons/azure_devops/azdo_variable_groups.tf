#
# permissions required: 
#   - vso.variablegroups_manage   (create)
#   + vso.buid                    (update)
#   + vso.build_execute           (destroy)
#
resource "azuredevops_variable_group" "variable_group" {
  for_each  = {
    for key, variable_group in lookup(var.azure_devops, "variable_groups", {}) : key => variable_group
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

#
# permissions required:
#   - vso.variablegroups_manage   (create)
#   + vso.buid                    (update)
#   + vso.build_execute           (destroy)
#
resource "azuredevops_variable_group" "variable_group" {
  for_each = try(var.azure_devops.variable_groups, {})

  project_id   = data.azuredevops_project.project.id
  name         = each.value.name
  description  = try(each.value.description, null)
  allow_access = try(each.value.allow_access, false)

  dynamic "key_vault" {
    for_each = lookup(each.value, "keyvault", null) == null ? [] : [1]

    content {
      name                = try(each.value.keyvault.lz_key, null) == null ? local.combined.keyvaults[var.landingzone.key][each.value.keyvault.keyvault_key].name : local.combined.keyvaults[each.value.keyvault.lz_key][each.value.keyvault.keyvault_key].name
      service_endpoint_id = azuredevops_serviceendpoint_azurerm.azure[each.value.keyvault.serviceendpoint_key].id
    }
  }

  dynamic "variable" {
    for_each = {
      for key, variable in each.value.variables : key => {
        name  = key == "name" ? variable : key
        value = key == "name" ? null : variable
      }
    }

    content {
      # When used with Keyvault, the name must be the keyvault secret name and value must not be set
      name  = variable.value.name
      value = variable.value.value
    }
  }

}

# #
# # permissions required:
# #   - vso.variablegroups_manage   (create)
# #   + vso.buid                    (update)
# #   + vso.build_execute           (destroy)
# #
resource "azuredevops_variable_group" "variable_group" {
  for_each = var.variable_groups

  project_id   = data.azuredevops_project.project[each.value.project_key].id
  name         = each.value.name
  description  = try(each.value.description, null)
  allow_access = try(each.value.allow_access, false)

  dynamic "key_vault" {
    for_each = lookup(each.value, "keyvault", null) == null ? [] : [1]

    content {
      name                = local.remote.keyvaults[each.value.keyvault.lz_key][each.value.keyvault.keyvault_key].name
      service_endpoint_id = azuredevops_serviceendpoint_azurerm.azure[each.value.keyvault.serviceendpoint_key].id
    }
  }

  dynamic "variable" {
    for_each = {
      for key, variable in try(each.value.variables, {}) : key => {
        name  = key == "name" ? variable : key
        value = key == "name" ? null : variable
      }
      if try(each.value.remote_objects, false) == false
    }

    content {
      # When used with Keyvault, the name must be the keyvault secret name and value must not be set
      name  = variable.value.name
      value = variable.value.value
    }
  }

  dynamic "variable" {
    for_each = {
      for key, value in try(each.value.variables, {}) : key => value
      if try(each.value.remote_objects, false) == true
    }

    content {
      name  = variable.value.name
      value = local.remote[variable.value.output_key][variable.value.lz_key][variable.value.resource_key][variable.value.attribute_key]
    }
  }

  dynamic "variable" {
    for_each = try(each.value.variables_objects, {})

    content {
      name  = variable.key
      value = jsonencode(variable.value)
    }
  }

}

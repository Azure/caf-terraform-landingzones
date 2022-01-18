data "azurerm_container_registry" "acr" {
  for_each = {
    for key, value in var.service_endpoints : key => value
    if try(value.type, "") == "AzureContainerRegistry"
  }

  name                = local.remote.azure_container_registries[each.value.azure_container_registry.lz_key][each.value.azure_container_registry.key].name
  resource_group_name = local.remote.azure_container_registries[each.value.azure_container_registry.lz_key][each.value.azure_container_registry.key].resource_group_name
}

resource "azuredevops_serviceendpoint_dockerregistry" "acr" {
  for_each = {
    for key, value in var.service_endpoints : key => value
    if try(value.type, "") == "AzureContainerRegistry"
  }

  project_id            = data.azuredevops_project.project[each.value.project_key].id
  service_endpoint_name = each.value.endpoint_name

  docker_registry = format("https://%s", data.azurerm_container_registry.acr[each.key].login_server)
  docker_username = data.azurerm_container_registry.acr[each.key].admin_username
  docker_password = data.azurerm_container_registry.acr[each.key].admin_password
  registry_type   = "Others"
}

resource "azuredevops_resource_authorization" "registry_endpoint" {
  for_each = {
    for key, value in var.service_endpoints : key => value
    if try(value.type, "") == "AzureContainerRegistry"
  }

  project_id  = data.azuredevops_project.project[each.value.project_key].id
  resource_id = azuredevops_serviceendpoint_dockerregistry.acr[each.key].id
  type        = "endpoint"
  authorized  = try(each.value.authorized, false)
}

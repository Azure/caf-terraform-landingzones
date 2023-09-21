output "name" {
  value       = azapi_resource.container_app_environment.name
  description = "Specifies the name of the container app job."
}

output "id" {
  value       = azapi_resource.container_app_environment.id
  description = "Specifies the resource id of container app job."
}
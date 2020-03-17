output "id" {
  value = azurerm_route_table.user_route.id
}

output "name" {
  value = azurerm_route_table.user_route.name
}

output "object" {
  value = azurerm_route_table.user_route
}

output "subnet_route" {
  value = azurerm_subnet_route_table_association.route_subnet_association
}

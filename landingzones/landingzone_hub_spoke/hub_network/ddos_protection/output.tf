output "ddos_protection" {
    depends_on = [azurerm_network_ddos_protection_plan.ddos_protection_plan]
    value = var.enable_ddos_standard ? azurerm_network_ddos_protection_plan.ddos_protection_plan.0 : null
}

output "id" {
    depends_on = [azurerm_network_ddos_protection_plan.ddos_protection_plan]
    value = var.enable_ddos_standard ? azurerm_network_ddos_protection_plan.ddos_protection_plan.0.id : null
}
#
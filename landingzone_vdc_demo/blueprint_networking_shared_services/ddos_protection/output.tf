output "ddos_protection" {
    depends_on = [zurerm_network_ddos_protection_plan.ddos_protection_plan]
    value = azurerm_network_ddos_protection_plan.ddos_protection_plan
}
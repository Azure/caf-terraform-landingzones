output "bastion" {
  depends_on = [azurerm_bastion_host.azurebastion]
  value = azurerm_bastion_host.azurebastion
}

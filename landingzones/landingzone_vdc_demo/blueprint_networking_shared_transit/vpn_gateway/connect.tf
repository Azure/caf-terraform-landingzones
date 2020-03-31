
resource "random_string" "psk_connection" {
  length  = 128
  upper   = true
  special = true
  number  = true 
}

resource "azurerm_virtual_network_gateway_connection" "connection_object" {
count = var.provision_gateway && var.remote_network_connect == true ? 1 : 0   
depends_on = [azurerm_virtual_network_gateway.vpn_gateway, azurerm_local_network_gateway.remote_network]

  name                = var.connection_name
  location            = var.location
  resource_group_name = var.resource_group_name

  type                       = "IPsec"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.vpn_gateway[0].id
  local_network_gateway_id   = azurerm_local_network_gateway.remote_network.id

  shared_key = random_string.psk_connection.result

  tags = var.tags
}

resource "azurerm_key_vault_secret" "psk" {
  depends_on    = [random_string.psk_connection, azurerm_key_vault_access_policy.akv_policy1, azurerm_key_vault_access_policy.vpn_akv_current_user]

  name          = "pskconnection"
  value         = random_string.psk_connection.result
  key_vault_id  = var.keyvaultid
  tags          = var.tags
}
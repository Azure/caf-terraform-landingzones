resource "azurerm_firewall_network_rule_collection" "http_https" {
  name                = "Authorize_http_https"
  azure_firewall_name = var.az_firewall_settings.az_fw_name
  resource_group_name = var.az_firewall_settings.az_object.resource_group_name
  priority            = 105
  action              = "Allow"

  rule {
    name = "Authorize_http_https"

    source_addresses = [
      "10.0.0.0/8",
    ]

    destination_ports = [
      "80","443",
    ]

    destination_addresses = [
      "*"
    ]
    protocols = [
      "TCP",
    ]
  }
}
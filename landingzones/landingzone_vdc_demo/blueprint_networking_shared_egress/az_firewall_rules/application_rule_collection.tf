resource "azurerm_firewall_application_rule_collection" "url_rule" {
  name                = "Authorize_websites"
  azure_firewall_name = var.az_firewall_settings.az_fw_name
  resource_group_name = var.az_firewall_settings.az_object.resource_group_name
  priority            = 100
  action              = "Allow"

  rule {
    name = "Authorize_microsoft_com"

    source_addresses = [
      "10.0.0.0/16",
    ]

    target_fqdns = [
      "*.microsoft.com",
    ]

    protocol {
      port = "443"
      type = "Https"
    }
  }
}
resource "azurerm_firewall_application_rule_collection" "tags_rule" {
  name                = "Authorize_fqdntags"
  azure_firewall_name = var.az_firewall_settings.az_fw_name
  resource_group_name = var.az_firewall_settings.az_object.resource_group_name
  priority            = 101
  action              = "Allow"

  rule {
    name = "Azure_Services"

    source_addresses = [
      "10.0.0.0/16",
    ]

    fqdn_tags = [
      "AzureBackup", "MicrosoftActiveProtectionService", "WindowsUpdate",
    ]
  }
}
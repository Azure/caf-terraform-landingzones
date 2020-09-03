# processing of the rules for:
# azurerm_firewall_network_rule_collection - https://www.terraform.io/docs/providers/azurerm/r/firewall_network_rule_collection.html
# azurerm_firewall_nat_rule_collection - https://www.terraform.io/docs/providers/azurerm/r/firewall_nat_rule_collection.html
# FQDN for azurerm_firewall_network_rule_collection https://github.com/terraform-providers/terraform-provider-azurerm/issues/7743
resource "azurerm_firewall_network_rule_collection" "netcollection" {
  for_each = lookup(var.az_firewall_rules, "azurerm_firewall_network_rule_collection", {})

  name                = each.value.name
  azure_firewall_name = var.az_firewall_settings.az_fw_name
  resource_group_name = var.az_firewall_settings.az_object.resource_group_name
  priority            = each.value.priority
  action              = each.value.action

  dynamic "rule" {
    for_each = each.value.ruleset
    content {
      name                  = rule.value.name
      description           = lookup(rule.value, "description", null)
      source_addresses      = rule.value.source_addresses
      destination_ports     = rule.value.destination_ports
      destination_addresses = rule.value.destination_addresses
      protocols             = rule.value.protocols
    }
  }
}

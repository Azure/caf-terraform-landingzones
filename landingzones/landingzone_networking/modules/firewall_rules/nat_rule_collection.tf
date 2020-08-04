# processing of the rules for:
# azurerm_firewall_nat_rule_collection - https://www.terraform.io/docs/providers/azurerm/r/firewall_nat_rule_collection.html

resource "azurerm_firewall_nat_rule_collection" "natcollection" {
  for_each = lookup(var.az_firewall_rules, "azurerm_firewall_nat_rule_collection", {})

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
      translated_port       = rule.value.translated_port
      translated_address    = rule.value.translated_address
      protocols             = rule.value.protocols
    }
  }
}
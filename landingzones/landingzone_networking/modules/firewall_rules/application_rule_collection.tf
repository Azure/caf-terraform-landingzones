# processing of the rules for:
# azurerm_firewall_application_rule_collection - https://www.terraform.io/docs/providers/azurerm/r/firewall_application_rule_collection.html

resource "azurerm_firewall_application_rule_collection" "appcollection" {
  for_each = lookup(var.az_firewall_rules, "azurerm_firewall_application_rule_collection", {})

  name                = each.value.name
  azure_firewall_name = var.az_firewall_settings.az_fw_name
  resource_group_name = var.az_firewall_settings.az_object.resource_group_name
  priority            = each.value.priority
  action              = each.value.action

  dynamic "rule" {
    for_each = each.value.ruleset
    content {
      name             = rule.value.name
      description      = lookup(rule.value, "description", null)
      source_addresses = rule.value.source_addresses
      fqdn_tags        = lookup(rule.value, "fqdn_tags", null)
      target_fqdns     = lookup(rule.value, "target_fqdns", null)
      dynamic "protocol" {
        for_each = lookup(rule.value, "protocol", [])
        content {
          type = protocol.value.type
          port = lookup(protocol.value, "port", null)
        }
      }
    }
  }
}

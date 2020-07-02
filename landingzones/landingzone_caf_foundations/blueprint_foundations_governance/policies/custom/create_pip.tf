
resource "azurerm_policy_definition" "deny_publicip_spoke" {
  count        = var.policies_matrix.cant_create_ip_spoke ? 1 : 0
  name         = "pol-deny-publicip-creation"
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "TF-Deny public IP in spoke"
  policy_rule  = <<POLICY_RULE
   {
	"if": {
        "field": "type",
        "in": [
          "Microsoft.Network/publicIPAddresses"
        ]
      },
      "then": {
        "effect": "deny"
      }
}
POLICY_RULE
}

resource "azurerm_policy_assignment" "deny-publicip-spoke" {
  count                = var.policies_matrix.cant_create_ip_spoke ? 1 : 0
  name                 = "deny-publicip-spoke"
  scope                = var.scope
  policy_definition_id = azurerm_policy_definition.deny_publicip_spoke[0].id
  description          = "Policy Assignment for deny public IP creatin in spokes"
  display_name         = "TF Deny public IP in spoke"

}
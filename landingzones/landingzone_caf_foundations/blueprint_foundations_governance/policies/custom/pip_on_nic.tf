
resource "azurerm_policy_definition" "deny_publicips_on_nics" {
  count        = var.policies_matrix.no_public_ip_spoke ? 1 : 0
  name         = "pol-deny-publicips-on-nics"
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = "TF-Deny public IP on NICS"
  policy_rule  = <<POLICY_RULE
   {
	"if": {
		"allOf": [
			{
				"field": "type",
				"equals": "Microsoft.Network/networkInterfaces"
			},
			{
				"field": "Microsoft.Network/networkInterfaces/ipconfigurations[*].publicIpAddress.id",
				"exists": true
			}
		]
	},
	"then": {
		"effect": "deny"
	}
}
POLICY_RULE



}
resource "azurerm_policy_assignment" "publicIP-deny-on-nics" {
  count                = var.policies_matrix.no_public_ip_spoke ? 1 : 0
  name                 = "deny-publicip-on-nics"
  scope                = var.scope
  policy_definition_id = azurerm_policy_definition.deny_publicips_on_nics[0].id
  description          = "Policy Assignment for deny public IP on NICs"
  display_name         = "TF Deny public IP assignment on NICs"


}
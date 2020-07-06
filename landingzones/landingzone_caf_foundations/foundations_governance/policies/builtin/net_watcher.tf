#Policy Id: /providers/Microsoft.Authorization/policyDefinitions/a9b99dd8-06c5-4317-8629-9d86a3c6e7d9
#Policy Name: Deploy network watcher when virtual networks are created 


resource "azurerm_policy_assignment" "pol_net_watcher" {
  count                = var.policies_matrix.autoenroll_netwatcher ? 1 : 0
  name                 = "nets_network_watcher"
  scope                = var.scope
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/a9b99dd8-06c5-4317-8629-9d86a3c6e7d9"
  description          = "Policy Assignment with Terraform"
  display_name         = "Deploy network watcher when virtual networks are created"
  location             = var.policies_matrix.msi_location
  identity {
    type = "SystemAssigned"
  }
}

#Get the export of the managed identity created  
output "policies_netwatcher_principal_id" {
  depends_on = [azurerm_policy_assignment.pol_net_watcher]

  value = azurerm_policy_assignment.pol_net_watcher[*].identity[*]
  #description = "Exports the principal ID which should subsequently be added with ""Network Contributor"" permissions."
}
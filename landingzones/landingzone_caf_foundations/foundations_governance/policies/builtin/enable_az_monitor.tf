#Definition ID: providers/Microsoft.Authorization/policySetDefinitions/55f3eceb-5573-4f18-9695-226972c6d74a
#Name: Enable Azure Monitor for VMs

resource "azurerm_policy_assignment" "vm_auto_monitor" {
  count                = var.policies_matrix.autoenroll_monitor_vm ? 1 : 0
  name                 = "vm_auto_monitor"
  scope                = var.scope
  policy_definition_id = "/providers/Microsoft.Authorization/policySetDefinitions/55f3eceb-5573-4f18-9695-226972c6d74a"
  description          = "Policy Assignment with Terraform"
  display_name         = "TF Enable Azure Monitor for VMs"
  location             = var.policies_matrix.msi_location
  identity {
    type = "SystemAssigned"
  }
  parameters = <<PARAMETERS
    {
    "logAnalytics_1": {
                "value" : "${var.log_analytics}"
              }
    }
PARAMETERS
}

# Get the export of the managed identity created  
output "policies_vm_automon_principal_id" {
  depends_on = [azurerm_policy_assignment.vm_auto_monitor]

  value = azurerm_policy_assignment.vm_auto_monitor[*].identity[*]
}
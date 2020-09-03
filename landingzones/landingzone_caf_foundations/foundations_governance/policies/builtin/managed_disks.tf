#Policy Id : /providers/Microsoft.Authorization/policyDefinitions/06a78e20-9358-41c9-923c-fb736d382a4d
#Name : Audit VMs that do not use managed disks

resource "azurerm_policy_assignment" "pol_managed_disks_assignment" {
  count                = var.policies_matrix.managed_disks_only ? 1 : 0
  name                 = "vm_no_managed_disks"
  scope                = var.scope
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/06a78e20-9358-41c9-923c-fb736d382a4d"
  description          = "Policy Assignment with Terraform"
  display_name         = "Audits the usage of non-managed disks on VM"

}
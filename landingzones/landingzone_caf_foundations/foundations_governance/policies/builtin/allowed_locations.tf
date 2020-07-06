#Definition ID: /providers/Microsoft.Authorization/policyDefinitions/e56962a6-4747-49cd-b67b-bf8b01975c4c
#Name: Allowed locations

locals {
  loclist = "${jsonencode(var.policies_matrix.list_of_allowed_locs)}"
}

resource "azurerm_policy_assignment" "res_location" {
  count                = var.policies_matrix.restrict_locations ? 1 : 0
  name                 = "res_location"
  scope                = var.scope
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/e56962a6-4747-49cd-b67b-bf8b01975c4c"
  description          = "Policy Assignment with Terraform"
  display_name         = "TF Restrict Deployment of Azure Resources in specific location"

  parameters = <<PARAMETERS
    {
    "listOfAllowedLocations": {
    "value": ${local.loclist}
  }
}
PARAMETERS
}

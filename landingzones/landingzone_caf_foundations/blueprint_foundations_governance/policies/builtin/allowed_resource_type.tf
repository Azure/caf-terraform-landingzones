#Definition ID: /providers/Microsoft.Authorization/policyDefinitions/a08ec900-254a-4555-9bf5-e42af04b5c5c
#Name: Allowed resource types

locals {
  supported_svc = "${jsonencode(var.policies_matrix.list_of_supported_svc)}"
}

resource "azurerm_policy_assignment" "res_type" {
  count                = var.policies_matrix.restrict_supported_svc ? 1 : 0
  name                 = "res_svc"
  scope                = var.scope
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/a08ec900-254a-4555-9bf5-e42af04b5c5c"
  description          = "Policy Assignment with Terraform"
  display_name         = "TF Restrict Deployment of specified Azure Resources"

  parameters = <<PARAMETERS
    {
      "listOfResourceTypesAllowed": {
        "value" : ${local.supported_svc}
    }
}
PARAMETERS
}

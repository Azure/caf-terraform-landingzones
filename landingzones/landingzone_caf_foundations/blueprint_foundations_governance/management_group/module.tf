resource "azurerm_management_group" "parent_management_group" {
  count = var.deploy_mgmt_groups ? 1 : 0

  display_name = var.management_groups.root.name
}

resource "azurerm_management_group" "l1children" {
  for_each                   = var.deploy_mgmt_groups ? var.management_groups.root.children : {}
  parent_management_group_id = azurerm_management_group.parent_management_group[0].id
  display_name               = each.value.name
  subscription_ids           = each.value.subscriptions
}


# Following new behaviors for SP
# https://github.com/terraform-providers/terraform-provider-azurerm/issues/6091
# Changes in behavior of 2.0 checking for existing mgmt group - need to read permissions of reading on mgmt group with role before creating it. 

# module.blueprint_foundations_governance.module.management_groups.azurerm_management_group.parent_management_group[0]: Creating...

# Error: Error checking for presence of existing Management Group "04e85bf6-36d1-48fd-97ed-01e208201a9e": managementgroups.Client#Get: Failure responding to request: StatusCode=403 -- Original Error: autorest/azure: Service returned an error. Status=403 Code="AuthorizationFailed" Message="The client 'cf3a0c1a-fcda-4dd1-a66a-159e7d2eda0f' with object id 'cf3a0c1a-fcda-4dd1-a66a-159e7d2eda0f' does not have authorization to perform action 'Microsoft.Management/managementGroups/read' over scope '/providers/Microsoft.Management/managementGroups/04e85bf6-36d1-48fd-97ed-01e208201a9e' or the scope is invalid. If access was recently granted, please refresh your credentials."

#   on blueprint_foundations_governance/management_group/module.tf line 1, in resource "azurerm_management_group" "parent_management_group":
#    1: resource "azurerm_management_group" "parent_management_group" {

# data "azurerm_subscription" "primary" {
# }

# resource "azurerm_role_definition" "mgmtrole" {
#   name        = "my-custom-role-mgmt"
#   scope       = data.azurerm_subscription.primary.id
#   description = "This is a custom role created via Terraform"

#   permissions {
#     actions     = ["Microsoft.Management/managementGroups/settings/read"]
#     not_actions = []
#   }

#   assignable_scopes = [
#     data.azurerm_subscription.primary.id, # /subscriptions/00000000-0000-0000-0000-000000000000
#   ]
# }

# resource "azurerm_role_assignment" "example" {
#   scope                = data.azurerm_subscription.primary.id
#   role_definition_name = "my-custom-role-mgmt"
#   principal_id         = data.azurerm_client_config.current.client_id
# }
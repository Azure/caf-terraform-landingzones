# management groups hierarchy 
module "management_groups" {
  source = "./management_group"

    management_groups   = var.governance_settings.management_groups
    deploy_mgmt_groups  = var.governance_settings.deploy_mgmt_groups
    tags                = var.tags_hub

}

# azure policies
module "custom_policies" {
  source = "./policies/custom"


  policies_matrix         = var.governance_settings.policy_matrix
  log_analytics           = var.log_analytics.name
  scope                   = data.azurerm_subscription.current.id
}

module "builtin_policies" {
  source = "./policies/builtin"
  
  policies_matrix         = var.governance_settings.policy_matrix
  log_analytics           = var.log_analytics.name
  //log_analytics needed for policies with auto-remediation 
  scope                   = data.azurerm_subscription.current.id
}
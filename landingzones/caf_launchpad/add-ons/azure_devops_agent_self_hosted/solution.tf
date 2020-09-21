module "caf" {
  # source = "git@github.com:aztfmod/terraform-azurerm-caf-landingzone-modules.git"
  source     = "../../../.."
  depends_on = [azuredevops_agent_pool.pool, azuredevops_agent_queue.agent_queue]

  tfstates                    = local.tfstates
  tags                        = local.tags
  global_settings             = local.global_settings
  diagnostics                 = local.diagnostics
  diagnostic_storage_accounts = var.diagnostic_storage_accounts
  logged_user_objectId        = var.logged_user_objectId
  logged_aad_app_objectId     = var.logged_aad_app_objectId
  resource_groups             = var.resource_groups
  storage_accounts            = var.storage_accounts
  azuread_groups              = var.azuread_groups
  keyvaults                   = var.keyvaults
  keyvault_access_policies    = var.keyvault_access_policies
  role_mapping                = var.role_mapping
  compute = {
    virtual_machines = var.virtual_machines
  }
}

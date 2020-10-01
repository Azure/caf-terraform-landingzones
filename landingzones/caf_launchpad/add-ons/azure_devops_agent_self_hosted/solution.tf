module "caf" {
  source     = "aztfmod/caf-enterprise-scale/azurerm"
  version    = "~> 0.3"
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
  custom_role_definitions     = var.custom_role_definitions
  azuread_apps                = var.azuread_apps
  compute = {
    virtual_machines = var.virtual_machines
  }

  # Experiment to prevent using remote_tfstate in modules. 
  combined_objects = {
    keyvaults = try(data.terraform_remote_state.launchpad.outputs.keyvaults["launchpad"], {})
  }
}

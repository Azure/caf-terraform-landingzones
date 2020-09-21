

# Get PAT token from keyvault
data "azurerm_key_vault_secret" "agent_pat" {
  name         = var.azure_devops.pats.agent.secret_name
  key_vault_id = data.terraform_remote_state.launchpad.outputs.keyvaults[var.azure_devops.pats["agent"].lz_key][var.azure_devops.pats["agent"].keyvault_key].id
}


module vm_extensions {
  depends_on = [module.caf]
  source     = "./extensions"
  for_each = {
    for key, value in var.virtual_machines : key => value
    if try(value.virtual_machine_extensions, null) != null
  }

  virtual_machine_id = module.caf.virtual_machines[each.key].id
  extensions         = each.value.virtual_machine_extensions
  settings = {
    devops_selfhosted_agent = {
      storage_accounts = module.caf.storage_accounts
      agent_pat        = data.azurerm_key_vault_secret.agent_pat.value
      admin_username   = each.value.virtual_machine_settings[each.value.os_type].admin_username
      azure_devops     = var.azure_devops
    }
  }
}
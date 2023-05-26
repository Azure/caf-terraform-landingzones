

# Get PAT token from keyvault
data "azurerm_key_vault_secret" "agent_pat" {
  depends_on = [module.caf]
  for_each = {
    for key, value in try(var.virtual_machines, {}) : key => value
    if try(value.virtual_machine_extensions, null) != null
  }

  name         = var.azure_devops[each.key].pats.agent.secret_name
  key_vault_id = try(var.azure_devops[each.key].pats["agent"].lz_key, null) == null ? local.combined.keyvaults[var.landingzone.key][var.azure_devops[each.key].pats["agent"].keyvault_key].id : local.combined.keyvaults[var.azure_devops[each.key].pats["agent"].lz_key][var.azure_devops[each.key].pats["agent"].keyvault_key].id
}


module "vm_extensions" {
  source     = "./extensions"
  depends_on = [module.caf]
  for_each = {
    for key, value in try(var.virtual_machines, {}) : key => value
    if try(value.virtual_machine_extensions, null) != null
  }

  virtual_machine_id = module.caf.virtual_machines[each.key].id
  extensions         = each.value.virtual_machine_extensions
  settings = {
    devops_selfhosted_agent = {
      storage_accounts = module.caf.storage_accounts
      agent_pat        = data.azurerm_key_vault_secret.agent_pat[each.key].value
      admin_username   = each.value.virtual_machine_settings[each.value.os_type].admin_username
      azure_devops     = var.azure_devops[each.key]
      storage_account_blobs_urls = try(each.value.virtual_machine_extensions.devops_selfhosted_agent.storage_account_blobs_urls,
        [
          for key, value in try(var.storage_account_blobs, []) : module.caf.storage_account_blobs[key].url
      ])
      managed_identity = can(each.value.virtual_machine_extensions.devops_selfhosted_agent.managed_identity.lz_key) ? local.remote.managed_identities[each.value.virtual_machine_extensions.devops_selfhosted_agent.managed_identity.lz_key][each.value.virtual_machine_extensions.devops_selfhosted_agent.managed_identity.key].rbac_id : module.caf.managed_identities[each.value.virtual_machine_extensions.devops_selfhosted_agent.managed_identity.key].rbac_id
    }
  }
}

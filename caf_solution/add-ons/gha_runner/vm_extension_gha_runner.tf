# Get PAT token from keyvault
data "azurerm_key_vault_secret" "runner_pat" {
  depends_on = [module.caf]
  for_each = {
    for key, value in try(var.virtual_machines, {}) : key => value
    if try(value.virtual_machine_extensions, null) != null
  }

  name         = var.gha_runner[each.key].pats.runner.secret_name
  key_vault_id = try(var.gha_runner[each.key].pats["runner"].lz_key, null) == null ? local.combined.keyvaults[var.landingzone.key][var.gha_runner[each.key].pats["runner"].keyvault_key].id : local.combined.keyvaults[var.gha_runner[each.key].pats["runner"].lz_key][var.gha_runner[each.key].pats["runner"].keyvault_key].id
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
  global_settings    = local.global_settings

  settings = {
    gha_runner = {
      storage_accounts = module.caf.storage_accounts
      token            = data.azurerm_key_vault_secret.runner_pat[each.key].value
      admin_username   = each.value.virtual_machine_settings[each.value.os_type].admin_username
      gha_runner       = var.gha_runner[each.key]
      storage_account_blobs_urls = try(each.value.virtual_machine_extensions.gha_runner.storage_account_blobs_urls,
        [
          for key, value in try(var.storage_account_blobs, []) : module.caf.storage_account_blobs[key].url
      ])
    }
  }
}

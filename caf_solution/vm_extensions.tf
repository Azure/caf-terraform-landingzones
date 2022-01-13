#
# microsoft_enterprise_cloud_monitoring - Install the monitoring agent in the virtual machine
#

module "vm_extension_monitoring_agent" {
  source  = "aztfmod/caf/azurerm//modules/compute/virtual_machine_extensions"
  version = "~>5.5.0"

  #source = "git::https://github.com/aztfmod/terraform-azurerm-caf.git//modules/compute/virtual_machine_extensions?ref=master"

  depends_on = [module.solution]

  for_each = {
    for key, value in try(var.virtual_machines, {}) : key => value
    if try(value.virtual_machine_extensions.microsoft_enterprise_cloud_monitoring, null) != null
  }

  client_config      = module.solution.client_config
  virtual_machine_id = module.solution.virtual_machines[each.key].id
  extension          = each.value.virtual_machine_extensions.microsoft_enterprise_cloud_monitoring
  extension_name     = "microsoft_enterprise_cloud_monitoring"
  settings = {
    diagnostics = merge(module.solution.diagnostics, local.diagnostics)
  }
}

module "vm_extension_diagnostics" {
  source  = "aztfmod/caf/azurerm//modules/compute/virtual_machine_extensions"
  version = "~>5.5.0"

  #source = "git::https://github.com/aztfmod/terraform-azurerm-caf.git//modules/compute/virtual_machine_extensions?ref=master"

  depends_on = [module.solution]

  for_each = {
    for key, value in try(var.virtual_machines, {}) : key => value
    if try(value.virtual_machine_extensions.microsoft_azure_diagnostics, null) != null
  }

  client_config      = module.solution.client_config
  virtual_machine_id = module.solution.virtual_machines[each.key].id
  extension          = each.value.virtual_machine_extensions.microsoft_azure_diagnostics
  extension_name     = "microsoft_azure_diagnostics"
  settings = {
    var_folder_path                  = var.var_folder_path
    diagnostics                      = merge(module.solution.diagnostics, local.diagnostics)
    xml_diagnostics_file             = try(each.value.virtual_machine_extensions.microsoft_azure_diagnostics.xml_diagnostics_file, null)
    diagnostics_storage_account_keys = each.value.virtual_machine_extensions.microsoft_azure_diagnostics.diagnostics_storage_account_keys
  }
}

module "vm_extension_microsoft_azure_domainjoin" {
  source  = "aztfmod/caf/azurerm//modules/compute/virtual_machine_extensions"
  version = "~>5.5.0"

  #source = "git::https://github.com/aztfmod/terraform-azurerm-caf.git//modules/compute/virtual_machine_extensions?ref=master"

  depends_on = [module.solution]

  for_each = {
    for key, value in try(var.virtual_machines, {}) : key => value
    if try(value.virtual_machine_extensions.microsoft_azure_domainjoin, null) != null
  }

  client_config      = module.solution.client_config
  virtual_machine_id = module.solution.virtual_machines[each.key].id
  extension          = each.value.virtual_machine_extensions.microsoft_azure_domainjoin
  extension_name     = "microsoft_azure_domainJoin"
  keyvaults          = merge(tomap({ (var.landingzone.key) = module.solution.keyvaults }), try(local.remote.keyvaults, {}))
}

module "vm_extension_session_host_dscextension" {
  source  = "aztfmod/caf/azurerm//modules/compute/virtual_machine_extensions"
  version = "~>5.5.0"

  #source = "git::https://github.com/aztfmod/terraform-azurerm-caf.git//modules/compute/virtual_machine_extensions?ref=master"

  depends_on = [module.vm_extension_microsoft_azure_domainjoin]

  for_each = {
    for key, value in try(var.virtual_machines, {}) : key => value
    if try(value.virtual_machine_extensions.session_host_dscextension, null) != null
  }

  client_config      = module.solution.client_config
  virtual_machine_id = module.solution.virtual_machines[each.key].id
  extension          = each.value.virtual_machine_extensions.session_host_dscextension
  extension_name     = "session_host_dscextension"
  keyvaults          = merge(tomap({ (var.landingzone.key) = module.solution.keyvaults }), try(local.remote.keyvaults, {}))
  wvd_host_pools     = merge(tomap({ (var.landingzone.key) = module.solution.wvd_host_pools }), try(local.remote.wvd_host_pools, {}))
}


module "vm_extension_custom_scriptextension" {
  source  = "aztfmod/caf/azurerm//modules/compute/virtual_machine_extensions"
  version = "~>5.5.0"

  #source = "git::https://github.com/aztfmod/terraform-azurerm-caf.git//modules/compute/virtual_machine_extensions?ref=master"

  depends_on = [module.solution, module.vm_extension_microsoft_azure_domainjoin]

  for_each = {
    for key, value in try(var.virtual_machines, {}) : key => value
    if try(value.virtual_machine_extensions.custom_script, null) != null
  }

  client_config      = module.solution.client_config
  virtual_machine_id = module.solution.virtual_machines[each.key].id
  extension          = each.value.virtual_machine_extensions.custom_script
  extension_name     = "custom_script"
  managed_identities = merge(tomap({ (var.landingzone.key) = module.solution.managed_identities }), try(local.remote.managed_identities, {}))
  storage_accounts   = merge(tomap({ (var.landingzone.key) = module.solution.storage_accounts }), try(local.remote.storage_accounts, {}))
}
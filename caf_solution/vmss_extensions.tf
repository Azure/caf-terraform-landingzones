module "vmss_extension_microsoft_azure_domainjoin" {
  source  = "github.com/volkerwessels/terraform-azurerm-caf//modules/compute/virtual_machine_scale_set_extensions?ref=vmss-custom-extensions"
  #version = "~>5.4.0"

  # source = "/tf/caf/aztfmod/modules/compute/virtual_machine_extensions"

  # source = "git::https://github.com/aztfmod/terraform-azurerm-caf.git//modules/compute/virtual_machine_extensions?ref=master"

  depends_on = [module.solution]

  for_each = {
    for key, value in try(var.virtual_machine_scale_sets, {}) : key => value
    if try(value.virtual_machine_scale_set_extensions.microsoft_azure_domainjoin, null) != null
  }

  client_config      = module.solution.client_config
  virtual_machine_scale_set_id = module.solution.virtual_machine_scale_sets[each.key].id
  extension          = each.value.virtual_machine_scale_set_extensions.microsoft_azure_domainjoin
  extension_name     = "microsoft_azure_domainJoin"
  keyvaults          = merge(tomap({ (var.landingzone.key) = module.solution.keyvaults }), try(local.remote.keyvaults, {}))
}


module "vmss_extension_custom_scriptextension" {
  source  = "github.com/volkerwessels/terraform-azurerm-caf//modules/compute/virtual_machine_scale_set_extensions?ref=vmss-custom-extensions"
  #version = "~>5.4.0"

  depends_on = [module.solution]

  for_each = {
    for key, value in try(var.virtual_machine_scale_sets, {}) : key => value
    if try(value.virtual_machine_scale_set_extensions.custom_script, null) != null
  }

  client_config      = module.solution.client_config
  virtual_machine_scale_set_id = module.solution.virtual_machine_scale_sets[each.key].id
  extension          = each.value.virtual_machine_scale_set_extensions.custom_script
  extension_name     = "custom_script"
  managed_identities = merge(tomap({ (var.landingzone.key) = module.solution.managed_identities }), try(local.remote.managed_identities, {}))
  storage_accounts   = merge(tomap({ (var.landingzone.key) = module.solution.storage_accounts }), try(local.remote.storage_accounts, {}))
}

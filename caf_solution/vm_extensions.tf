#
# microsoft_enterprise_cloud_monitoring - Install the monitoring agent in the virtual machine
#

module "vm_extension_monitoring_agent" {
  source  = "aztfmod/caf/azurerm//modules/compute/virtual_machine_extensions"
  version = "~>5.3.2"
  # if you are not running CAF modules locally, change the source to "github.com/aztfmod/terraform-azurerm-caf/modules/compute/virtual_machine_extensions"
  depends_on = [module.solution] #refer landingzone.tf for the correct module name.

  for_each = {
    for key, value in try(var.virtual_machines, {}) : key => value
    if try(value.virtual_machine_extensions.microsoft_enterprise_cloud_monitoring, null) != null
  }

  client_config      = module.solution.client_config #refer landingzone.tf for the correct module name.
  virtual_machine_id = module.solution.virtual_machines[each.key].id #refer landingzone.tf for the correct module name.
  extension          = each.value.virtual_machine_extensions.microsoft_enterprise_cloud_monitoring
  extension_name     = "microsoft_enterprise_cloud_monitoring"
  settings = {
    diagnostics = module.solution.diagnostics
  }
}

module "vm_extension_diagnostics" {
  source  = "aztfmod/caf/azurerm//modules/compute/virtual_machine_extensions"
  version = "~>5.3.2"
  # if you are not running CAF modules locally, change the source to "github.com/aztfmod/terraform-azurerm-caf/modules/compute/virtual_machine_extensions"
  depends_on = [module.solution] #refer landingzone.tf for the correct module name.

  for_each = {
    for key, value in try(var.virtual_machines, {}) : key => value
    if try(value.virtual_machine_extensions.microsoft_azure_diagnostics, null) != null
  }

  client_config      = module.solution.client_config #refer landingzone.tf for the correct module name.
  virtual_machine_id = module.solution.virtual_machines[each.key].id #refer landingzone.tf for the correct module name.
  extension          = each.value.virtual_machine_extensions.microsoft_azure_diagnostics
  extension_name     = "microsoft_azure_diagnostics"
  settings = {
    var_folder_path                  = var.var_folder_path
    diagnostics                      = module.solution.diagnostics
    xml_diagnostics_file             = try(each.value.virtual_machine_extensions.microsoft_azure_diagnostics.xml_diagnostics_file, null)
    diagnostics_storage_account_keys = each.value.virtual_machine_extensions.microsoft_azure_diagnostics.diagnostics_storage_account_keys
  }
}

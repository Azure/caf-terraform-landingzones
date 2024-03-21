module "dynamic_keyvault_certificates" {
  # source  = "aztfmod/caf/azurerm//modules/security/dynamic_keyvault_certificates"
  # version = "5.6.5"

  source = "git::https://github.com/aztfmod/terraform-azurerm-caf.git//modules/security/dynamic_keyvault_certificates?ref=main"

  for_each = {
    for keyvault_key, certificates in try(var.dynamic_keyvault_certificates, {}) : keyvault_key => {
      for key, value in certificates : key => value
      if try(value.value, null) == null
    }
  }

  settings = each.value
  keyvault = module.solution.keyvaults[each.key]
  objects  = module.solution
}

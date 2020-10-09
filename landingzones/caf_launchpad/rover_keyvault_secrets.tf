

# resource "azurerm_key_vault_secret" "launchpad-secret-prefix" {
#   depends_on   = [module.launchpad]
#   name         = "launchpad-secret-prefix"
#   value        = var.launchpad_key_names.keyvault_client_secret
#   key_vault_id = module.launchpad.keyvaults[var.landingzone.current.level].id

#   lifecycle {
#     ignore_changes = [
#       key_vault_id
#     ]
#   }
# }

module dynamic_keyvault_secrets {
  source   = "./dynamic_keyvault_secrets"
  for_each = try(var.dynamic_keyvault_secrets, {})

  settings    = each.value
  keyvault_id = module.launchpad.keyvaults[each.key].id
  objects     = module.launchpad
}

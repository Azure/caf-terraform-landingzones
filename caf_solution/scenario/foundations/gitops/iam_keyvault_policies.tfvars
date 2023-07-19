# Transitioned to role_mapping and azuread authentication for Keyvault.

# keyvault_access_policies_azuread_apps = {

#   secrets = {
#     caf_launchpad_level0 = {
#       lz_key             = "launchpad"
#       azuread_app_key    = "caf_launchpad_level0"
#       secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
#     }
#   }
# }

# keyvault_access_policies = {
#   secrets = {
#     keyvault_level0_rw = {
#       lz_key             = "launchpad"
#       azuread_group_key  = "keyvault_level0_rw"
#       secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
#     }
#     keyvault_password_rotation = {
#       lz_key             = "launchpad"
#       azuread_group_key  = "keyvault_password_rotation"
#       secret_permissions = ["Set", "Get", "List", "Delete", ]
#     }
#   }
# }

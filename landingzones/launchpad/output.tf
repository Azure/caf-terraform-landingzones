
output aad_apps {
  sensitive = true
  value     = module.azure_applications.aad_apps
}

output global_settings {
  sensitive = true
  value = local.global_settings
}

output resource_groups {
  sensitive = true
  value     = azurerm_resource_group.rg
}

output log_analytics {
  sensitive = true
  value = module.log_analytics.object
}

output diagnostics_map {
  sensitive = true
  value = module.diagnostics.diagnostics_map
}

# output azure_devops_user_admin {
#   depends_on = [ azuread_user.account ]
#   sensitive = true

#   value = {
#     user_principal_name = lookup(azuread_user.account, var.launchpad_key_names.azure_devops_admin_for_pat, null) == null ? null : azuread_user.account[var.launchpad_key_names.azure_devops_admin_for_pat].user_principal_name
#     secret_password_key = lookup(azurerm_key_vault_secret.aad_user_password, var.launchpad_key_names.azure_devops_admin_for_pat, null) == null ? null : azurerm_key_vault_secret.aad_user_password[var.launchpad_key_names.azure_devops_admin_for_pat].name
#     tenant_name         = var.aad_users[var.launchpad_key_names.azure_devops_admin_for_pat].tenant_name
#     tenant_id           = data.azurerm_client_config.current.tenant_id
#     keyvault_id         = azurerm_key_vault.keyvault[var.launchpad_key_names.keyvault].id
#     keyvault_name       = azurerm_key_vault.keyvault[var.launchpad_key_names.keyvault].name
#   }
# }

# Does not work in light mode
output azure_subscriptions {
  sensitive = true
  value     = var.subscriptions
}

output keyvaults {
  sensitive = true
  value     = azurerm_key_vault.keyvault
}

output networking {
  sensitive = true
  value = module.virtual_network
}

output github_token_keyvault {
  sensitive = true

  value = {
    keyvault_secret_name = azurerm_key_vault_secret.github_pat.name
    keyvault_name        = azurerm_key_vault.keyvault[var.launchpad_key_names.keyvault].name
    keyvault_id          = azurerm_key_vault.keyvault[var.launchpad_key_names.keyvault].id
  }
}


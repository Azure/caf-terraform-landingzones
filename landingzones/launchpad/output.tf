
output aad_apps {
  sensitive = true
  value     = module.azure_applications.aad_apps
}

output prefix {
  value = local.prefix
}

output environment {
  value = var.environment
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

# output launchpad_storage {
#   sensitive = true

#   value = {
#     account_name = azurerm_storage_account.stg.name
#   }
# }

output keyvaults {
  sensitive = true
  value     = azurerm_key_vault.keyvault
}

# output tf_name {
#   sensitive = true

#   value = var.tf_name
# }

output github_token_keyvault {
  sensitive = true

  value = {
    keyvault_secret_name = azurerm_key_vault_secret.github_pat.name
    keyvault_name        = azurerm_key_vault.keyvault[var.launchpad_key_names.keyvault].name
    keyvault_id          = azurerm_key_vault.keyvault[var.launchpad_key_names.keyvault].id
  }
}

# locals {
#   devops_admin_user = lookup(azuread_user.account, var.launchpad_key_names.azure_devops_admin_for_pat, null) == null ? "{deleted user}" : azuread_user.account[var.launchpad_key_names.azure_devops_admin_for_pat].user_principal_name
# }

# output next_steps {
#   value = <<EOT

#     # Add Azure Active Directory user ${local.devops_admin_user} in your Azure Devops organization

#     1 - Navigate to ${var.azure_devops.organization_url}/_settings/users
#       a - Add the user to the organization and set a Basic license
#       b - Add the user as Project Administrator for project ${var.azure_devops.project}

#     2 - Navigate to ${var.azure_devops.organization_url}/_settings/agentpools (Optional - if the user is in charge of creating the Agent Pools)
#       a - Got to security and add the user to mange all pools in the organization
#       b - Set the user as Administrator (if not possible put as reader)

#     3 - Upload the Github PAT token to the Azure Keyvault using the following command:

#       read -sp "Github PAT: " PAT && az keyvault secret set --name ${azurerm_key_vault_secret.github_pat.name} --vault-name ${azurerm_key_vault.keyvault[var.launchpad_key_names.keyvault].name} --value $PAT > /dev/null && echo "Token uploaded to keyvault"

#     4 - Execute Step2 - 

#       rover [path_step2_launchpad_folder] plan -w level0 -tfstate caf-launchpad-step2 -var remote_tfstate_step1=${var.tf_name} -var-file [path_configuration_file.tfvars] 



#   EOT
# }


locals {
  transposed = {
    for key, value in var.sp_secrets : key => coalesce(
      try(value.value, null),
      try(var.objects[value.lz_key][value.output_key][value.resource_key][value.attribute_key], null),
      try(var.objects[value.lz_key][value.output_key][value.attribute_key], null),
      try(data.azurerm_key_vault_secret.client_secret[key].value, null)
  ) }
  vault_url       = data.azurerm_key_vault_secret.vault_url.value
  vault_role_id   = data.azurerm_key_vault_secret.vault_role_id.value
  vault_secret_id = data.azurerm_key_vault_secret.vault_secret_id.value
}

resource "vault_generic_secret" "azuresecrets" {
  path         = var.path
  disable_read = try(var.disable_read, false)
  data_json    = jsonencode(local.transposed)
  depends_on = [
    null_resource.set_vault_access
  ]
}

resource "null_resource" "set_vault_access" {
  triggers = {
    client_secrets            = local.transposed
    HASHICORP_VAULT_URL       = local.vault_url
    HASHICORP_VAULT_ROLE_ID   = local.vault_role_id
    HASHICORP_VAULT_SECRET_ID = local.vault_secret_id
  }

  provisioner "local-exec" {
    command     = format("%s/scripts/set_vault_access.sh", path.module)
    interpreter = ["/bin/bash"]
    on_failure  = fail

    environment = {
      HASHICORP_VAULT_URL       = local.vault_url
      HASHICORP_VAULT_ROLE_ID   = local.vault_role_id
      HASHICORP_VAULT_SECRET_ID = local.vault_secret_id
    }
  }
}

# Service Principal secrets
data "azurerm_key_vault_secret" "client_secret" {
  for_each = {
    for key, value in var.sp_secrets : key => value
    if try(value.secretname, null) != null && try(value.secretname, null) != ""
  }
  name         = each.value.secretname
  key_vault_id = var.objects[each.value.lz_key].keyvaults[each.value.keyvault_key].id
}

# Hashicorp vault secrets
data "azurerm_key_vault_secret" "vault_url" {
  name         = var.settings.hashicorp_secrets.vault_url.secret_name
  key_vault_id = var.objects[var.settings.hashicorp_secrets.vault_url.lz_key].keyvaults[var.settings.hashicorp_secrets.vault_url.keyvault_key].id
}

data "azurerm_key_vault_secret" "vault_role_id" {
  name         = var.settings.hashicorp_secrets.vault_role_id.secret_name
  key_vault_id = var.objects[var.settings.hashicorp_secrets.vault_role_id.lz_key].keyvaults[var.settings.hashicorp_secrets.vault_role_id.keyvault_key].id
}

data "azurerm_key_vault_secret" "vault_secret_id" {
  name         = var.settings.hashicorp_secrets.vault_secret_id.secret_name
  key_vault_id = var.objects[var.settings.hashicorp_secrets.vault_secret_id.lz_key].keyvaults[var.settings.hashicorp_secrets.vault_secret_id.keyvault_key].id
}

# resource "vault_azure_secret_backend" "azure" {
#   path            = var.settings.backend
#   subscription_id = var.settings.subscription_id
#   tenant_id       = var.settings.tenant_id
#   client_id       = var.settings.client_id
#   client_secret   = var.settings.client_secret
# }

locals {
  tenant_id     = data.azurerm_key_vault_secret.tenant_id.value
  client_id     = data.azurerm_key_vault_secret.client_id.value
  client_secret = data.azurerm_key_vault_secret.client_secret.value
}

resource "null_resource" "set_backend_secret_config" {
  triggers = {
    subscription_id = var.settings.subscription_id
    tenant_id       = local.tenant_id
    client_id       = local.client_id
    client_secret   = local.client_secret
  }

  provisioner "local-exec" {
    command     = format("%s/scripts/set_backend_secret_config.sh", path.module)
    interpreter = ["/bin/bash"]
    on_failure  = fail

    environment = {
      VAULT_SECRET_BACKEND  = var.settings.backend
      AZURE_SUBSCRIPTION_ID = var.settings.subscription_id
      AZURE_TENANT_ID       = local.tenant_id
      AZURE_CLIENT_ID       = local.client_id
      AZURE_CLIENT_SECRET   = local.client_secret
    }
  }
}

resource "vault_azure_secret_backend_role" "existing_object_id" {
  backend               = var.settings.backend
  role                  = var.settings.role
  application_object_id = var.objects[var.settings.sp_secrets.application_id.lz_key][var.settings.sp_secrets.application_id.output_key][var.settings.sp_secrets.application_id.resource_key][var.settings.sp_secrets.application_id.attribute_key]
  ttl                   = try(var.settings.ttl, null)
  max_ttl               = try(var.settings.max_ttl, null)
  depends_on            = [null_resource.set_backend_secret_config]
}

# Service principal secrets
data "azurerm_key_vault_secret" "tenant_id" {
  name         = var.settings.sp_secrets.tenant_id.secret_name
  key_vault_id = var.objects[var.settings.sp_secrets.tenant_id.lz_key].keyvaults[var.settings.sp_secrets.tenant_id.keyvault_key].id
}

data "azurerm_key_vault_secret" "client_id" {
  name         = var.settings.sp_secrets.client_id.secret_name
  key_vault_id = var.objects[var.settings.sp_secrets.client_id.lz_key].keyvaults[var.settings.sp_secrets.client_id.keyvault_key].id
}

data "azurerm_key_vault_secret" "client_secret" {
  name         = var.settings.sp_secrets.client_secret.secret_name
  key_vault_id = var.objects[var.settings.sp_secrets.client_secret.lz_key].keyvaults[var.settings.sp_secrets.client_secret.keyvault_key].id
}
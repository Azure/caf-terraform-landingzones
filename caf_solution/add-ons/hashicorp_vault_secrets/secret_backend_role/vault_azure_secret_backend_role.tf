resource "vault_azure_secret_backend" "azure" {
  path            = var.settings.backend
  subscription_id = var.settings.subscription_id
  tenant_id       = var.settings.tenant_id
  client_id       = var.settings.client_id
  client_secret   = var.settings.client_secret
}

resource "vault_azure_secret_backend_role" "existing_object_id" {
  backend               = vault_azure_secret_backend.azure.path
  role                  = var.settings.role
  application_object_id = var.objects[var.settings.azuread_application.lz_key][var.settings.azuread_application.output_key][var.settings.azuread_application.resource_key][var.settings.azuread_application.attribute_key]
  ttl                   = try(var.settings.ttl, null)
  max_ttl               = try(var.settings.max_ttl, null)
}

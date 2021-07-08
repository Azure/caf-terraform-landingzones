resource "vault_azure_secret_backend_role" "existing_object_id" {

  backend               = var.settings.backend
  role                  = var.settings.role
  application_object_id = try(var.objects[var.settings.azuread_application.lz_key][var.settings.azuread_application.output_key][var.settings.azuread_application.attribute_key], null)
  ttl                   = var.settings.ttl
  max_ttl               = var.settings.max_ttl
}
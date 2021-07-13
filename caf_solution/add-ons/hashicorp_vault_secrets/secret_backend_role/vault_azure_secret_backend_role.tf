# resource "vault_azure_secret_backend" "azure" {
#   path            = var.settings.backend
#   subscription_id = var.settings.subscription_id
#   tenant_id       = var.settings.tenant_id
#   client_id       = var.settings.client_id
#   # client_secret   = var.settings.client_secret
#   client_secret   = "7vKOwO3hsMCZWjKnG8jpGpTeg9Pd4YadM5QPbkLLW9e718e5Fw6iv5hWF4YFVEjKrCMQxqXvLqcVqWuYyWpx5faMvxUx70u1m7CNvKsYQGnW2GRs6pHSj8C37FDfIGzwGDTUXjyXqFU3PqTrl280aVJSaxh8mV8M2WjEyWoPl4exnwuf4F8eGAc0swYD0agZabPX64kdIDnae81ThpOqz9GjTCdPYtoMUInCJ8ciXoZSeS7ZeohpomAk0o"
# }

resource "null_resource" "set_backend_secret_config" {
  for_each = try(var.settings.service_principal_secrets, {}) != {} ? [1] : []

  triggers = {
    subscription_id = var.settings.subscription_id
    tenant_id       = var.settings.tenant_id
    client_id       = var.settings.client_id
    client_secret   = var.settings.client_secret
  }

  provisioner "local-exec" {
    command     = format("%s/scripts/set_backend_secret_config.sh", path.module)
    interpreter = ["/bin/bash"]
    on_failure  = fail

    environment = {
      VAULT_SECRET_BACKEND  = var.settings.backend
      AZURE_SUBSCRIPTION_ID = var.settings.subscription_id
      AZURE_TENANT_ID       = var.settings.tenant_id
      AZURE_CLIENT_ID       = var.settings.client_id
      AZURE_CLIENT_SECRET   = var.settings.client_secret
    }
  }
}

resource "vault_azure_secret_backend_role" "existing_object_id" {
  backend               = var.settings.backend
  role                  = var.settings.role
  application_object_id = var.objects[var.settings.azuread_application.lz_key][var.settings.azuread_application.output_key][var.settings.azuread_application.resource_key][var.settings.azuread_application.attribute_key]
  ttl                   = try(var.settings.ttl, null)
  max_ttl               = try(var.settings.max_ttl, null)
  depends_on = [
    null_resource.set_backend_secret_config
  ]
}

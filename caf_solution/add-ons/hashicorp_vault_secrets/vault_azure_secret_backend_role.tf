module "vault_azure_secret_backend_roles" {
  source   = "./secret_backend_role"
  for_each = try(var.hashicorp_secret_backend_roles, {})

  settings = each.value
  objects  = local.remote.objects
}
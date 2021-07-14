module "hashicorp_vault_secrets" {
  source = "./secret"
  for_each = {
    for key, value in var.hashicorp_vault_secrets : key => value
    if try(value.secrets, null) != null && try(value.secrets, null) != "" && try(value.path, null) != null && try(value.path, null) != ""
  }
  objects      = local.remote.objects
  settings     = each.value
}


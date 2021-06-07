module "vault_secret" {
  source = "./secret"
  for_each = {
    for key, value in var.dynamic_vault_secrets : key => value
    if try(value.secrets, null) != null && try(value.secrets, null) != ""
  }
  secrets      = each.value.secrets
  path         = each.value.path
  disable_read = try(each.value.disable_read, false)
}
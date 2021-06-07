resource "vault_generic_secret" "azuresecrets" {
  path         = var.path
  disable_read = try(var.disable_read, false)
  data_json    = jsonencode(var.secrets)
}
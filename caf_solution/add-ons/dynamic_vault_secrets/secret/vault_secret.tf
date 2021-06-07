resource "vault_generic_secret" "azuresecrets" {
    path      = var.path
    data_json = jsonencode(var.secrets)
}
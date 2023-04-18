module "keyvault-csi-driver" {
  for_each           = var.kv_csi_driver
  source             = "./keyvault-csi-driver"
  global_settings    = local.global_settings
  settings           = each.value
  secret_identity_id = local.secret_identity_id
  keyvaults          = local.remote.keyvaults
}
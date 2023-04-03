module "keyvault-csi-driver" {
  source      = "./keyvault-csi-driver"
  for_each   = var.kv_csi_driver
  global_settings     = local.global_settings
  settings            = each.value
  aks_clusters = local.remote.aks_clusters
  keyvaults = local.remote.keyvaults
}
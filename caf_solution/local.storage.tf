locals {
  storage = merge(
    var.storage,
    {
      netapp_accounts       = var.netapp_accounts
      storage_account_blobs = var.storage_account_blobs
    }
  )
}

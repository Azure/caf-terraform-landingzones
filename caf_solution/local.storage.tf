locals {
  storage = merge(
    var.storage,
    {
      netapp_accounts             = var.netapp_accounts
      storage_account_blobs       = var.storage_account_blobs
      storage_account_file_shares = var.storage_account_file_shares
      storage_account_queues      = var.storage_account_queues
      storage_containers          = var.storage_containers
    }
  )
}

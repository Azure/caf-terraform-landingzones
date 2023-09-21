locals {
  maps = merge(
    var.maps,
    {
      maps_accounts = var.maps_accounts
    }
  )
}

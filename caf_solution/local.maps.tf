locals {
  maps = merge(
    var.maps,
    {
      maps_account  = var.maps_account
    }
  )
}

locals {
  messaging = merge(
    var.messaging,
    {
      signalr_services = var.signalr_services
    }
  )
}

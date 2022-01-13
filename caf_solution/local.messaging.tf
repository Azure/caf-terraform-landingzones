locals {
  messaging = merge(
    var.messaging,
    {
      signalr_services      = var.signalr_services
      servicebus_namespaces = var.servicebus_namespaces
      servicebus_topics     = var.servicebus_topics
      servicebus_queues     = var.servicebus_queues
    }
  )
}

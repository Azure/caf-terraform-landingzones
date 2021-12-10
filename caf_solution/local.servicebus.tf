locals {
  servicebus = merge(
    var.servicebus,
    {
      servicebus_namespaces = var.servicebus_namespaces
      servicebus_topics     = var.servicebus_topics
      servicebus_queues     = var.servicebus_queues
    }
  )
}

locals {
  service_bus = merge(
    var.service_bus,
    {
      service_bus_namespaces          = var.service_bus_namespaces
      service_bus_topics              = var.service_bus_topics
      service_bus_queues              = var.service_bus_queues
    }
  )
}

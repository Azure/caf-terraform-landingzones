variable "service_bus" {
  description = "Service Bus configurations"
  default = {}
}
variable "service_bus_namespaces" {
  description = "Service Bus Namespace configuration objects"
  default = {}
}
variable "service_bus_topics" {
  default = {}
}
variable "service_bus_queues" {
  default = {}
}
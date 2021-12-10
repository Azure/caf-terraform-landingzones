variable "servicebus" {
  description = "Service Bus configurations"
  default     = {}
}
variable "servicebus_namespaces" {
  description = "Service Bus Namespace configuration objects"
  default     = {}
}
variable "servicebus_topics" {
  default = {}
}
variable "servicebus_queues" {
  default = {}
}
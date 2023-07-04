locals {
  communication = merge(
    var.communication,
    {
      communication_services = var.communication_services
    }
  )
}
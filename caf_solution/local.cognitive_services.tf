locals {
  cognitive_services = merge(
    var.cognitive_services,
    {
      cognitive_services_account = var.cognitive_services_account
    }
  )
}
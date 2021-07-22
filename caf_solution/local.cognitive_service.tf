locals {
  cognitive_service = merge(
    var.cognitive_service,
    {
      cognitive_service_account = var.cognitive_service_account
    }
  )
}
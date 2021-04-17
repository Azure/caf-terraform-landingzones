locals {
  shared_services = merge(
    var.shared_services,
    {
      automations              = var.automations
      recovery_vaults          = var.recovery_vaults
      monitoring               = var.monitoring
      shared_image_galleries   = var.shared_image_galleries
      image_definitions        = var.image_definitions
      packer_service_principal = var.packer_service_principal
      packer_managed_identity  = var.packer_managed_identity
    }
  )
}

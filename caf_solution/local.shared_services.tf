locals {
  shared_services = merge(
    var.shared_services,
    {
      automations                    = var.automations
      automation_log_analytics_links = var.automation_log_analytics_links
      consumption_budgets            = var.consumption_budgets
      image_definitions              = var.image_definitions
      log_analytics_storage_insights = var.log_analytics_storage_insights
      monitor_autoscale_settings     = var.monitor_autoscale_settings
      monitor_action_groups          = var.monitor_action_groups
      monitoring                     = var.monitoring
      packer_managed_identity        = var.packer_managed_identity
      packer_service_principal       = var.packer_service_principal
      packer_build                   = var.packer_build
      recovery_vaults                = var.recovery_vaults
      shared_image_galleries         = var.shared_image_galleries
    }
  )
}

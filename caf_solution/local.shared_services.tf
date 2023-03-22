locals {
  shared_services = merge(
    var.shared_services,
    {
      automation_log_analytics_links = var.automation_log_analytics_links
      automations                    = var.automations
      consumption_budgets            = var.consumption_budgets
      image_definitions              = var.image_definitions
      log_analytics_storage_insights = var.log_analytics_storage_insights
      monitor_action_groups          = var.monitor_action_groups
      monitor_activity_log_alert     = var.monitor_activity_log_alert
      monitor_autoscale_settings     = var.monitor_autoscale_settings
      monitor_metric_alert           = var.monitor_metric_alert
      monitoring                     = var.monitoring
      packer_build                   = var.packer_build
      packer_managed_identity        = var.packer_managed_identity
      packer_service_principal       = var.packer_service_principal
      recovery_vaults                = var.recovery_vaults
      shared_image_galleries         = var.shared_image_galleries
    }
  )
}

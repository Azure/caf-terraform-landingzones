# Shared services
variable "shared_services" {
  description = "Shared services configuration objects"
  default = {
    # automations = {}
    # monitoring = {}
    # recovery_vaults = {}
  }
}

variable "automations" {
  default = {}
}

variable "automation_schedules" {
  default = {}
}

variable "automation_runbooks" {
  default = {}
}

variable "automation_log_analytics_links" {
  default = {}
}

variable "automation_software_update_configurations" {
  default = {}
}

variable "consumption_budgets" {
  default = {}
}

variable "image_definitions" {
  default = {}
}

variable "log_analytics_storage_insights" {
  default = {}
}

variable "monitor_action_groups" {
  default = {}
}

variable "monitor_metric_alert" {
  default = {}
}

variable "monitor_activity_log_alert" {
  default = {}
}

variable "monitoring" {
  default = {}
}

variable "packer_service_principal" {
  default = {}
}

variable "packer_build" {
  default = {}
}

variable "packer_managed_identity" {
  default = {}
}

variable "recovery_vaults" {
  default = {}
}

variable "shared_image_galleries" {
  default = {}
}

variable "monitor_autoscale_settings" {
  default     = {}
  description = "The map from the monitor_autoscale_settings module configuration"
}

variable "monitor_private_link_scope" {
  default = {}
}
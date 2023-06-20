locals {
  logic_app = merge(
    var.logic_app,
    {
      integration_service_environment = var.integration_service_environment
      logic_app_action_custom         = var.logic_app_action_custom
      logic_app_action_http           = var.logic_app_action_http
      logic_app_integration_account   = var.logic_app_integration_account
      logic_app_standard              = var.logic_app_standard
      logic_app_trigger_custom        = var.logic_app_trigger_custom
      logic_app_trigger_http_request  = var.logic_app_trigger_http_request
      logic_app_trigger_recurrence    = var.logic_app_trigger_recurrence
      logic_app_workflow              = var.logic_app_workflow
    }
  )
}

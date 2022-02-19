locals {
  apim = merge(
    var.apim,
    {
      api_management                      = var.api_management
      api_management_api                  = var.api_management_api
      api_management_api_diagnostic       = var.api_management_api_diagnostic
      api_management_logger               = var.api_management_logger
      api_management_api_operation        = var.api_management_api_operation
      api_management_backend              = var.api_management_backend
      api_management_api_policy           = var.api_management_api_policy
      api_management_api_operation_tag    = var.api_management_api_operation_tag
      api_management_api_operation_policy = var.api_management_api_operation_policy
      api_management_user                 = var.api_management_user
      api_management_custom_domain        = var.api_management_custom_domain
      api_management_diagnostic           = var.api_management_diagnostic
      api_management_certificate          = var.api_management_certificate
    }
  )
}

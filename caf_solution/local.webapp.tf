locals {
  webapp = merge(
    var.webapp,
    {
      app_service_environments                       = var.app_service_environments
      app_service_environments_v3                    = var.app_service_environments_v3
      app_service_plans                              = var.app_service_plans
      app_services                                   = var.app_services
      azurerm_application_insights                   = var.azurerm_application_insights
      azurerm_application_insights_web_test          = var.azurerm_application_insights_web_test
      azurerm_application_insights_standard_web_test = var.azurerm_application_insights_standard_web_test
      function_apps                                  = var.function_apps
      static_sites                                   = var.static_sites
    }
  )
}

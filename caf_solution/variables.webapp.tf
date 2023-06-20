
variable "webapp" {
  description = "Web applications configuration objects"
  default = {
    # app_services                 = {}
    # app_service_environments     = {}
    # app_service_plans            = {}
    # azurerm_application_insights = {}
    # ...
  }
}
variable "app_service_environments" {
  default = {}
}
variable "app_service_environments_v3" {
  default = {}
}
variable "app_service_plans" {
  default = {}
}
variable "app_services" {
  default = {}
}
variable "azurerm_application_insights" {
  default = {}
}
variable "azurerm_application_insights_web_test" {
  default = {}
}
variable "azurerm_application_insights_standard_web_test" {
  default = {}
}
variable "function_apps" {
  default = {}
}
variable "static_sites" {
  default = {}
}

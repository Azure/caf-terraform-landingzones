# Map of the remote data state for lower level
variable "lower_storage_account_name" {}
variable "lower_container_name" {}
variable "lower_resource_group_name" {}

variable "tfstate_storage_account_name" {}
variable "tfstate_container_name" {}
variable "tfstate_key" {}
variable "tfstate_resource_group_name" {}

variable "tenant_id" {}
variable "landingzone" {}
variable "tfstate_subscription_id" {
  description = "This value is propulated by the rover. subscription id hosting the remote tfstates"
}
variable "global_settings" {
  default = {}
}
variable "rover_version" {
  default = null
}

variable "logged_user_objectId" {
  default = null
}
variable "logged_aad_app_objectId" {
  default = null
}
variable "security" {
  default = null
}
variable "tags" {
  default = null
}
variable "app_service_environments" {
  default = {}
}
variable "app_service_plans" {
  default = {}
}
variable "app_services" {
  default = {}
}
variable "diagnostics_definition" {
  default = {}
}
variable "resource_groups" {
  default = {}
}
variable "network_security_group_definition" {
  default = {}
}
variable "vnets" {
  default = {}
}
variable "azurerm_redis_caches" {
  default = {}
}
variable "mssql_servers" {
  default = {}
}
variable "storage_accounts" {
  default = {}
}
variable "storage_account_blobs" {
  default = {}
}
variable "azuread" {
  default = {}
}
variable "azuread_groups" {
  default = {}
}
variable "keyvaults" {
  default = {}
}
variable "keyvault_access_policies" {
  default = {}
}
variable "virtual_machines" {
  default = {}
}
variable "diagnostic_storage_accounts" {
  default = {}
}
variable "virtual_machine_extension_scripts" {
  default = {}
}
variable "gha_runner" {
  default = {}
}
variable "role_mapping" {
  default = {}
}
variable "custom_role_definitions" {
  default = {}
}
variable "azuread_apps" {
  default = {}
}
variable "dynamic_keyvault_secrets" {
  default = {}
}
variable "managed_identities" {
  default = {}
}


# Map of the remote data state for lower level
variable "lower_storage_account_name" {}
variable "lower_container_name" {}
variable "lower_resource_group_name" {}

variable "tfstate_storage_account_name" {}
variable "tfstate_container_name" {}
variable "tfstate_key" {}
variable "tfstate_resource_group_name" {}

variable "global_settings" {
  default = {}
}

variable "landingzone" {
  default = ""
}

variable "environment" {
  default = "sandpit"
}
variable "rover_version" {
  default = null
}
variable "max_length" {
  default = 40
}
variable "logged_user_objectId" {
  default = null
}
variable "logged_aad_app_objectId" {
  default = null
}
variable "tags" {
  default = null
  type    = map(any)
}
variable "diagnostic_log_analytics" {
  default = {}
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
  default = null
}
variable "resource_groups" {
  default = null
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
variable "mssql_databases" {
  default = {}
}
variable "mssql_elastic_pools" {
  default = {}
}
variable "storage_accounts" {
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
variable "azure_container_registries" {
  default = {}
}
variable "bastion_hosts" {
  default = {}
}
variable "public_ip_addresses" {
  default = {}
}
variable "diagnostic_storage_accounts" {
  default = {}
}
variable "managed_identities" {
  default = {}
}
variable "private_dns" {
  default = {}
}
variable "synapse_workspaces" {
  default = {}
}
variable "azurerm_application_insights" {
  default = {}
}
variable "role_mapping" {
  default = {}
}
variable "aks_clusters" {
  default = {}
}
variable "databricks_workspaces" {
  default = {}
}
variable "machine_learning_workspaces" {
  default = {}
}
variable "monitoring" {
  default = {}
}
variable "virtual_wans" {
  default = {}
}
variable "event_hub_namespaces" {
  default = {}
}
variable "application_gateways" {
  default = {}
}
variable "application_gateway_applications" {
  default = {}
}
variable "application_gateway_waf_policies" {
  default = {}
}
variable "dynamic_keyvault_secrets" {
  default = {}
}
variable "disk_encryption_sets" {
  default = {}
}
variable "keyvault_keys" {
  default = {}
}
variable "databricks" {
  default = {}
}
variable "var_folder_path" {
  default = {}
}
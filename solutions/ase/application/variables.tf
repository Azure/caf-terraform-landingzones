# Map of the remote data state for lower level
variable lower_storage_account_name {}
variable lower_container_name {}
variable lower_resource_group_name {}

variable tfstate_subscription_id {
  description = "This value is propulated by the rover. subscription id hosting the remote tfstates"
}
variable tfstate_storage_account_name {}
variable tfstate_container_name {}
variable tfstate_key {}
variable tfstate_resource_group_name {}

variable landingzone {}
variable tenant_id {}

variable global_settings {
  default = {}
}
variable rover_version {}
variable logged_user_objectId {
  default = null
}
variable logged_aad_app_objectId {
  default = null
}
variable tags {
  type    = map
  default = {}
}
variable diagnostics_definition {
  default = null
}
variable resource_groups {
  default = {}
}
variable app_service_plans {
  default = {}
}
variable app_services {
  default = {}
}
variable azurerm_redis_caches {
  default = {}
}
variable mssql_servers {
  default = {}
}
variable mssql_databases {
  default = {}
}
variable mssql_elastic_pools {
  default = {}
}
variable storage_accounts {
  default = {}
}
variable azuread_groups {
  default = {}
}
variable keyvaults {
  default = {}
}
variable keyvault_access_policies {
  default = {}
}
variable managed_identities {
  default = {}
}
variable azurerm_application_insights {
  default = {}
}
variable role_mapping {
  default = {}
}
variable custom_role_definitions {
  default = {}
}

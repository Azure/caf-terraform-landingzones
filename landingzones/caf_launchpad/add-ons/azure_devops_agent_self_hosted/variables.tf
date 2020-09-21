# Map of the remote data state for lower level
variable lowerlevel_storage_account_name {}
variable lowerlevel_container_name {}
variable lowerlevel_key {}
variable lowerlevel_resource_group_name {}

variable tfstate_storage_account_name {}
variable tfstate_container_name {}
variable tfstate_key {}
variable tfstate_resource_group_name {}

variable global_settings {
  default = {}
}

variable landingzone_name {
  default = "appservices"
}
variable level {
  default = "level3"
}
variable environment {
  default = "sandpit"
}
variable rover_version {
  default = null
}

variable logged_user_objectId {
  default = null
}
variable logged_aad_app_objectId {
  default = null
}
variable tags {
  default = null
}
variable app_service_environments {
  default = {}
}
variable app_service_plans {
  default = {}
}
variable app_services {
  default = {}
}
variable diagnostics_definition {
  default = null
}
variable resource_groups {
  default = null
}
variable network_security_group_definition {
  default = null
}
variable vnets {
  default = {}
}
variable azurerm_redis_caches {
  default = {}
}
variable mssql_servers {
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
variable virtual_machines {
  default = {}
}
variable diagnostic_storage_accounts {
  default = {}
}
variable virtual_machine_extension_scripts {
  default = {}
}
variable azure_devops {
  default = {}
}
variable role_mapping {
  default = {}
}
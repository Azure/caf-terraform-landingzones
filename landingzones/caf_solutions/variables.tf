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
  type    = map
  default = {}
}
variable resource_groups {
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
variable keyvault_certificates {
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
variable dynamic_keyvault_secrets {
  default = {}
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
variable network_security_group_definition {
  default = null
}
variable route_tables {
  default = {}
}
variable azurerm_routes {
  default = {}
}
variable vnets {
  default = {}
}
variable mssql_managed_instances {
  default = {}
}
variable mssql_managed_instances_secondary {
  default = {}
}

variable mssql_managed_databases {
  default = {}
}
variable mssql_managed_databases_restore {
  default = {}
}

variable mariadb_servers {
  default = {}
}
variable mariadb_databases {
  default = {}
}
variable mssql_failover_groups {
  default = {}
}
variable mssql_mi_failover_groups {
  default = {}
}
variable mssql_mi_administrators {
  default = {}
}
variable azuread_roles {
  default = {}
}
variable keyvault_certificate_issuers {
  default = {}
}
variable keyvault_certificate_requests {
  default = {}
}
variable virtual_machines {
  default = {}
}
variable bastion_hosts {
  default = {}
}
variable public_ip_addresses {
  default = {}
}
variable diagnostic_storage_accounts {
  default = {}
}
variable diagnostic_event_hub_namespaces {
  default = {}
}
variable diagnostic_log_analytics {
  default = {}
}
variable private_dns {
  default = {}
}
variable synapse_workspaces {
  default = {}
}
variable aks_clusters {
  default = {}
}
variable databricks_workspaces {
  default = {}
}
variable machine_learning_workspaces {
  default = {}
}
variable monitoring {
  default = {}
}
variable virtual_wans {
  default = {}
}
variable event_hub_namespaces {
  default = {}
}
variable application_gateways {
  default = {}
}
variable application_gateway_applications {
  default = {}
}
variable mysql_servers {
  default = {}
}
variable postgresql_servers {
  default = {}
}
variable cosmos_db {
  default = {}
}
variable log_analytics {
  default = {}
}
variable recovery_vaults {
  default = {}
}
variable availability_sets {
  default = {}
}
variable proximity_placement_groups {
  default = {}
}
variable network_watchers {
  default = {}
}
variable virtual_network_gateways {
  default = {}
}
variable virtual_network_gateway_connections {
  default = {}
}
variable express_route_circuits {
  default = {}
}
variable express_route_circuit_authorizations {
  default = {}
}
variable diagnostics_destinations {
  default = {}
}
variable vnet_peerings {
  default = {}
}
variable cosmos_dbs {
  default = {}
}
variable front_doors {
  default = {}
}
variable front_door_waf_policies {
  default = {}
}
variable dns_zones {
  default = {}
}
variable private_endpoints {
  default = {}
}
variable local_network_gateways {
  default = {}
}
variable azure_container_registries {
  default = {}
}
variable azuread_api_permissions {
  default = {}
}
variable azuread_apps {
  default = {}
}
variable azuread_users {
  default = {}
}
variable user_type {}
variable domain_name_registrations {
  default = {}
}
variable dns_zone_records {
  default = {}
}
variable keyvault_keys {
  default = {}
}
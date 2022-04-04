# AzureAD Applications
data "azuread_application" "data" {
  for_each = try(var.data_sources.azuread_applications, {})

  application_id = try(each.value.application_id, null)
  display_name   = try(each.value.display_name, null)
  object_id      = try(each.value.object_id, null)
}

# AzureAD Groups
data "azuread_group" "data" {
  for_each = try(var.data_sources.azuread_groups, {})

  display_name     = try(each.value.display_name, null)
  mail_enabled     = try(each.value.mail_enabled, null)
  object_id        = try(each.value.object_id, null)
  security_enabled = try(each.value.security_enabled, null)
}

# AzureAD Serive Principal
data "azuread_service_principal" "data" {
  for_each = try(var.data_sources.azuread_service_principals, {})

  display_name   = try(each.value.display_name, null)
  application_id = try(each.value.application_id, null)
  object_id      = try(each.value.object_id, null)
}

# AzureAD Users
data "azuread_user" "data" {
  for_each = try(var.data_sources.azuread_users, {})

  mail_nickname       = try(each.value.mail_nickname, null)
  object_id           = try(each.value.object_id, null)
  user_principal_name = try(each.value.display_name, null)
}

# AKS Clusters
data "azurerm_kubernetes_cluster" "data" {
  for_each = try(var.data_sources.aks_clusters, {})

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

# App Config
data "azurerm_app_configuration" "data" {
  for_each = try(var.data_sources.app_config, {})

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

# Application Insights
data "azurerm_application_insights" "data" {
  for_each = try(var.data_sources.azurerm_application_insights, {})

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

# API Management
data "azurerm_api_management" "data" {
  for_each = try(var.data_sources.api_management, {})

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

# API Management API
data "azurerm_api_management_api" "data" {
  for_each = try(var.data_sources.api_management_api, {})

  name                = each.value.name
  api_management_name = each.value.api_management_name
  resource_group_name = each.value.resource_group_name
  revision            = each.value.revision
}

# API Management Gateway
data "azurerm_api_management_gateway" "data" {
  for_each = try(var.data_sources.api_management_gateway, {})

  name                = each.value.name
  api_management_id   = each.value.api_management_id
}

# App Service Environment
data "azurerm_app_service_environment" "data" {
  for_each = try(var.data_sources.app_service_environments, {})

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

# App Service Plan (!) Not supported at the current azurerm provider version
# data "azurerm_service_plan" "data" {
#   for_each = try(var.data_sources.app_service_plans, {})

#   name                = each.value.name
#   resource_group_name = each.value.resource_group_name
# }

# App Services
data "azurerm_app_service" "data" {
  for_each = try(var.data_sources.app_services, {})

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

# Application Security Groups
data "azurerm_application_security_group" "data" {
  for_each = try(var.data_sources.application_security_groups, {})

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

# Application Gateways
data "azurerm_application_gateway" "data" {
  for_each = try(var.data_sources.application_gateways, {})

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

# Availability Sets
data "azurerm_availability_set" "data" {
  for_each = try(var.data_sources.availability_sets, {})

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

# CDN Profile
data "azurerm_cdn_profile" "data" {
  for_each = try(var.data_sources.cdn_profile, {})

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

# Consumption Budget Resource Groups
data "azurerm_consumption_budget_resource_group" "data" {
  for_each = try(var.data_sources.consumption_budgets_resource_groups, {})

  name              = each.value.name
  resource_group_id = each.value.resource_group_id
}

# Consumption Budget Subscription
data "azurerm_consumption_budget_subscription" "data" {
  for_each = try(var.data_sources.consumption_budgets_subscriptions, {})

  name            = each.value.name
  subscription_id = each.value.subscription_id
}

# Cognitive Account
data "azurerm_cognitive_account" "data" {
  for_each = try(var.data_sources.cognitive_services_account, {})

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

# Firewall Policies
data "azurerm_web_application_firewall_policy" "data" {
  for_each = try(var.data_sources.azurerm_firewall_policies, {})

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

# Firewall
data "azurerm_firewall" "data" {
  for_each = try(var.data_sources.azurerm_firewalls, {})

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

# Container Registry - ACR
data "azurerm_container_registry" "data" {
  for_each = try(var.data_sources.container_registry, {})

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

# Databricks Workspace
data "azurerm_databricks_workspace" "data" {
  for_each = try(var.data_sources.databricks_workspaces, {})

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

# Datafactory
data "azurerm_data_factory" "data" {
  for_each = try(var.data_sources.data_factory, {})

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

# CosmosDB Account
data "azurerm_cosmosdb_account" "data" {
  for_each = try(var.data_sources.cosmos_dbs, {})

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

# Disk Encryption Set
data "azurerm_disk_encryption_set" "data" {
  for_each = try(var.data_sources.disk_encryption_sets, {})

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

# Dedicated Host
data "azurerm_dedicated_host" "data" {
  for_each = try(var.data_sources.dedicated_hosts, {})

  name                      = each.value.name
  dedicated_host_group_name = each.value.dedicated_host_group_name
  resource_group_name       = each.value.resource_group_name
}

# Dedicated Host Groups
data "azurerm_dedicated_host_group" "data" {
  for_each = try(var.data_sources.dedicated_host_groups, {})

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

# DNS Zones
data "azurerm_dns_zone" "data" {
  for_each = try(var.data_sources.dns_zones, {})

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

# Event HUB Namespace
data "azurerm_eventhub_namespace" "data" {
  for_each = try(var.data_sources.event_hub_namespaces, {})

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

# Express Route Circuit
data "azurerm_express_route_circuit" "data" {
  for_each = try(var.data_sources.express_route_circuits, {})

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

# Keyvaults
data "azurerm_key_vault" "data" {
  for_each = try(var.data_sources.keyvaults, {})

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

# Keyvaults Certificates
data "azurerm_key_vault_certificate" "data" {
  for_each = try(var.data_sources.keyvault_certificates, {})

  name         = each.value.name
  key_vault_id = each.value.key_vault_id
}

# Keyvaults Key
data "azurerm_key_vault_key" "data" {
  for_each = try(var.data_sources.keyvault_keys, {})

  name         = each.value.name
  key_vault_id = each.value.key_vault_id
}

# Kusto Clusters
data "azurerm_kusto_cluster" "data" {
  for_each = try(var.data_sources.kusto_clusters, {})

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

# Load Balancers
data "azurerm_lb" "data" {
  for_each = try(var.data_sources.load_balancers, {})

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

# Logic App Integration Account
data "azurerm_logic_app_integration_account" "data" {
  for_each = try(var.data_sources.logic_app_integration_account, {})

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

# Logic App Workflow
data "azurerm_logic_app_workflow" "data" {
  for_each = try(var.data_sources.logic_app_workflow, {})

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

# Log Analytics Workspace
data "azurerm_log_analytics_workspace" "data" {
  for_each = try(var.data_sources.log_analytics, {})

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

# Machine Learning Workspace
data "azurerm_machine_learning_workspace" "data" {
  for_each = try(var.data_sources.machine_learning_workspaces, {})

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

# Managed Identities
data "azurerm_user_assigned_identity" "data" {
  for_each = try(var.data_sources.managed_identities, {})

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

# Monitor Action Groups
data "azurerm_monitor_action_group" "data" {
  for_each = try(var.data_sources.monitor_action_groups, {})

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

# SignalR Service
data "azurerm_signalr_service" "data" {
  for_each = try(var.data_sources.signalr_services, {})

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

# MSSQL Database
data "azurerm_mssql_database" "data" {
  for_each = try(var.data_sources.mssql_databases, {})

  name      = each.value.name
  server_id = each.value.server_id
}

# MSSQL Elastic Pool
data "azurerm_mssql_elasticpool" "data" {
  for_each = try(var.data_sources.mssql_elastic_pools, {})

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  server_name         = each.value.server_name
}

# MSSQL Managed Instance (!) Not supported at the current azurerm provider version
# data "azurerm_mssql_managed_instance" "data" {
#   for_each = try(var.data_sources.mssql_managed_instances, {})

#   name                = each.value.name
#   resource_group_name = each.value.resource_group_name
# }

# MSSQL Server
data "azurerm_mssql_server" "data" {
  for_each = try(var.data_sources.mssql_servers, {})

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

# MySQL Server
data "azurerm_mysql_server" "data" {
  for_each = try(var.data_sources.mysql_servers, {})

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

# NAT Gateways
data "azurerm_nat_gateway" "data" {
  for_each = try(var.data_sources.nat_gateways, {})

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

# Network Security Groups
data "azurerm_network_security_group" "data" {
  for_each = try(var.data_sources.network_security_groups, {})

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

# Network Watchers
data "azurerm_network_watcher" "data" {
  for_each = try(var.data_sources.network_watchers, {})

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

# Postgres Server
data "azurerm_postgresql_server" "data" {
  for_each = try(var.data_sources.postgresql_servers, {})

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

# Private DNS Zone
data "azurerm_private_dns_zone" "data" {
  for_each = try(var.data_sources.private_dns, {})

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

# Proximity Placement Groups
data "azurerm_proximity_placement_group" "data" {
  for_each = try(var.data_sources.proximity_placement_groups, {})

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

# Public IPs
data "azurerm_public_ip" "data" {
  for_each = try(var.data_sources.public_ip_addresses, {})

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

# Redis Cache
data "azurerm_redis_cache" "data" {
  for_each = try(var.data_sources.redis_caches, {})

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

# Recovery Vaults
data "azurerm_recovery_services_vault" "data" {
  for_each = try(var.data_sources.recovery_vaults, {})

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

# Resource Groups
data "azurerm_resource_group" "data" {
  for_each = try(var.data_sources.resource_groups, {})

  name = each.value.name
}

# Service BUS Namespace
data "azurerm_servicebus_namespace" "data" {
  for_each = try(var.data_sources.servicebus_namespaces, {})

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

# Service BUS Topic
data "azurerm_servicebus_topic" "data" {
  for_each = try(var.data_sources.servicebus_topics, {})

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  namespace_name      = each.value.namespace_name
}

# Service BUS Queue
data "azurerm_servicebus_queue" "data" {
  for_each = try(var.data_sources.servicebus_queues, {})

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  namespace_name      = each.value.namespace_name
}

# Storage Account
data "azurerm_storage_account" "data" {
  for_each = try(var.data_sources.storage_accounts, {})

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

# Storage Container
data "azurerm_storage_container" "data" {
  for_each = try(var.data_sources.storage_containers, {})

  name                 = each.value.name
  storage_account_name = each.value.storage_account_name
}

# Subscriptions
data "azurerm_subscription" "data" {
  for_each = try(var.data_sources.subscriptions, {})

  subscription_id = each.value.subscription_id
}

# Synapse Workspace
data "azurerm_synapse_workspace" "data" {
  for_each = try(var.data_sources.synapse_workspaces, {})

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

# Virtual HUB
data "azurerm_virtual_hub" "data" {
  for_each = try(var.data_sources.virtual_hubs, {})

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

# Virtual WAN
data "azurerm_virtual_wan" "data" {
  for_each = try(var.data_sources.virtual_wans, {})

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

# Virtual Machines
data "azurerm_virtual_machine" "data" {
  for_each = try(var.data_sources.virtual_machines, {})

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

# Virtual Machine Scale Sets
data "azurerm_virtual_machine_scale_set" "data" {
  for_each = try(var.data_sources.virtual_machine_scale_sets, {})

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

# VNets
data "azurerm_virtual_network" "data" {
  for_each = try(var.data_sources.vnets, {})

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

# VPN Gateways
data "azurerm_vpn_gateway" "data" {
  for_each = try(var.data_sources.vpn_gateways, {})

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

# VMWare Private Clouds
data "azurerm_vmware_private_cloud" "data" {
  for_each = try(var.data_sources.vmware_private_clouds, {})

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

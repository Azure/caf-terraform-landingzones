output "azuread_applications" {
  value = data.azuread_application.data
}

output "azuread_groups" {
  value = data.azuread_group.data
}

output "azuread_service_principals" {
  value = data.azuread_service_principal.data
}

output "azuread_users" {
  value = data.azuread_user.data
}

output "aks_clusters" {
  value = data.azurerm_kubernetes_cluster.data
}

output "app_config" {
  value = data.azurerm_app_configuration.data
}

output "azurerm_application_insights" {
  value = data.azurerm_application_insights.data
}

output "api_management" {
  value = data.azurerm_api_management.data
}

output "api_management_api" {
  value = data.azurerm_api_management_api.data
}

output "api_management_gateway" {
  value = data.azurerm_api_management_gateway.data
}

output "app_service_environments" {
  value = data.azurerm_app_service_environment.data
}

# output "app_service_plans" {
#   value = data.azurerm_service_plan.data
# }

output "app_services" {
  value = data.azurerm_app_service.data
}

output "application_security_groups" {
  value = data.azurerm_application_security_group.data
}

output "application_gateways" {
  value = data.azurerm_application_gateway.data
}

output "availability_sets" {
  value = data.azurerm_availability_set.data
}

output "cdn_profile" {
  value = data.azurerm_cdn_profile.data
}

output "cognitive_services_account" {
  value = data.azurerm_cognitive_account.data
}

output "consumption_budgets_resource_groups" {
  value = data.azurerm_consumption_budget_resource_group.data
}

output "consumption_budgets_subscriptions" {
  value = data.azurerm_consumption_budget_subscription.data
}

output "azurerm_firewall_policies" {
  value = data.azurerm_web_application_firewall_policy.data
}

output "azurerm_firewalls" {
  value = data.azurerm_firewall.data
}

output "container_registry" {
  value = data.azurerm_container_registry.data
}

output "databricks_workspaces" {
  value = data.azurerm_databricks_workspace.data
}

output "data_factory" {
  value = data.azurerm_data_factory.data
}

output "cosmos_dbs" {
  value = data.azurerm_cosmosdb_account.data
}

output "disk_encryption_sets" {
  value = data.azurerm_disk_encryption_set.data
}

output "dedicated_hosts" {
  value = data.azurerm_dedicated_host.data
}

output "dedicated_host_groups" {
  value = data.azurerm_dedicated_host_group.data
}

output "dns_zones" {
  value = data.azurerm_dns_zone.data
}

output "event_hub_namespaces" {
  value = data.azurerm_eventhub_namespace.data
}

output "express_route_circuits" {
  value = data.azurerm_express_route_circuit.data
}

output "keyvault_certificates" {
  value = data.azurerm_key_vault_certificate.data
}

output "keyvault_keys" {
  value = data.azurerm_key_vault_key.data
}

output "keyvaults" {
  value = data.azurerm_key_vault.data
}

output "kusto_clusters" {
  value = data.azurerm_kusto_cluster.data
}

output "load_balancers" {
  value = data.azurerm_lb.data
}

output "logic_app_integration_account" {
  value = data.azurerm_logic_app_integration_account.data
}

output "logic_app_workflow" {
  value = data.azurerm_logic_app_workflow.data
}

output "log_analytics" {
  value = data.azurerm_log_analytics_workspace.data
}

output "machine_learning_workspaces" {
  value = data.azurerm_machine_learning_workspace.data
}

output "managed_identities" {
  value = data.azurerm_user_assigned_identity.data
}

output "monitor_action_groups" {
  value = data.azurerm_monitor_action_group.data
}

output "signalr_services" {
  value = data.azurerm_signalr_service.data
}

output "mssql_databases" {
  value = data.azurerm_mssql_database.data
}

output "mssql_elastic_pools" {
  value = data.azurerm_mssql_elasticpool.data
}

# output "mssql_managed_instances" {
#   value = data.azurerm_mssql_managed_instance.data
# }

output "mssql_servers" {
  value = data.azurerm_mssql_server.data
}

output "mysql_servers" {
  value = data.azurerm_mysql_server.data
}

output "nat_gateways" {
  value = data.azurerm_nat_gateway.data
}

output "network_security_groups" {
  value = data.azurerm_network_security_group.data
}

output "network_watchers" {
  value = data.azurerm_network_watcher.data
}

output "postgresql_servers" {
  value = data.azurerm_postgresql_server.data
}

output "private_dns" {
  value = data.azurerm_private_dns_zone.data
}

output "proximity_placement_groups" {
  value = data.azurerm_proximity_placement_group.data
}

output "public_ip_addresses" {
  value = data.azurerm_public_ip.data
}

output "redis_caches" {
  value = data.azurerm_redis_cache.data
}

output "recovery_vaults" {
  value = data.azurerm_recovery_services_vault.data
}

output "resource_groups" {
  value = data.azurerm_resource_group.data
}

output "servicebus_namespaces" {
  value = data.azurerm_servicebus_namespace.data
}

output "servicebus_topics" {
  value = data.azurerm_servicebus_topic.data
}

output "servicebus_queues" {
  value = data.azurerm_servicebus_queue.data
}

output "storage_accounts" {
  value = data.azurerm_storage_account.data
}

output "storage_containers" {
  value = data.azurerm_storage_container.data
}

output "subscriptions" {
  value = data.azurerm_subscription.data
}

output "synapse_workspaces" {
  value = data.azurerm_synapse_workspace.data
}

output "virtual_hubs" {
  value = data.azurerm_virtual_hub.data
}

output "virtual_wans" {
  value = data.azurerm_virtual_wan.data
}

output "virtual_machines" {
  value = data.azurerm_virtual_machine.data
}

output "virtual_machine_scale_sets" {
  value = data.azurerm_virtual_machine_scale_set.data
}

output "vnets" {
  value = data.azurerm_virtual_network.data
}

output "vpn_gateways" {
  value = data.azurerm_vpn_gateway.data
}

output "vmware_private_clouds" {
  value = data.azurerm_vmware_private_cloud.data
}

module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "~> 5.0"

  azuread_groups               = var.azuread_groups
  azuread_roles                = var.azuread_roles
  current_landingzone_key      = var.landingzone.key
  custom_role_definitions      = var.custom_role_definitions
  diagnostics                  = local.remote.diagnostics
  event_hub_namespaces         = var.event_hub_namespaces
  global_settings              = local.global_settings
  keyvault_access_policies     = var.keyvault_access_policies
  keyvault_certificate_issuers = var.keyvault_certificate_issuers
  keyvaults                    = var.keyvaults
  log_analytics                = var.log_analytics
  logged_aad_app_objectId      = var.logged_aad_app_objectId
  logged_user_objectId         = var.logged_user_objectId
  managed_identities           = var.managed_identities
  resource_groups              = var.resource_groups
  role_mapping                 = var.role_mapping
  storage_accounts             = var.storage_accounts
  tags                         = local.tags
  tenant_id                    = var.tenant_id
  tfstates                     = local.tfstates

  compute = {
    aks_clusters               = var.aks_clusters
    availability_sets          = var.availability_sets
    azure_container_registries = var.azure_container_registries
    bastion_hosts              = var.bastion_hosts
    proximity_placement_groups = var.proximity_placement_groups
    virtual_machines           = var.virtual_machines
  }

  database = {
    azurerm_redis_caches              = var.azurerm_redis_caches
    cosmos_dbs                        = var.cosmos_dbs
    databricks_workspaces             = var.databricks_workspaces
    machine_learning_workspaces       = var.machine_learning_workspaces
    mariadb_servers                   = var.mariadb_servers
    mssql_databases                   = var.mssql_databases
    mssql_elastic_pools               = var.mssql_elastic_pools
    mssql_failover_groups             = var.mssql_failover_groups
    mssql_managed_databases           = var.mssql_managed_databases
    mssql_managed_databases_restore   = var.mssql_managed_databases_restore
    mssql_managed_instances           = var.mssql_managed_instances
    mssql_managed_instances_secondary = var.mssql_managed_instances_secondary
    mssql_mi_administrators           = var.mssql_mi_administrators
    mssql_mi_failover_groups          = var.mssql_mi_failover_groups
    mssql_servers                     = var.mssql_servers
    mysql_servers                     = var.mysql_servers
    postgresql_servers                = var.postgresql_servers
    synapse_workspaces                = var.synapse_workspaces
  }

  networking = {
    application_gateway_applications     = var.application_gateway_applications
    application_gateways                 = var.application_gateways
    azurerm_routes                       = var.azurerm_routes
    dns_zones                            = var.dns_zones
    express_route_circuit_authorizations = var.express_route_circuit_authorizations
    express_route_circuits               = var.express_route_circuits
    front_door_waf_policies              = var.front_door_waf_policies
    front_doors                          = var.front_doors
    local_network_gateways               = var.local_network_gateways
    network_security_group_definition    = var.network_security_group_definition
    network_watchers                     = var.network_watchers
    private_dns                          = var.private_dns
    private_endpoints                    = var.private_endpoints
    public_ip_addresses                  = var.public_ip_addresses
    route_tables                         = var.route_tables
    virtual_network_gateway_connections  = var.virtual_network_gateway_connections
    virtual_network_gateways             = var.virtual_network_gateways
    virtual_wans                         = var.virtual_wans
    vnet_peerings                        = var.vnet_peerings
    vnets                                = var.vnets
  }

  remote_objects = {
    app_service_environments         = local.remote.app_service_environments
    app_service_plans                = local.remote.app_service_plans
    app_services                     = local.remote.app_services
    application_gateway_applications = local.remote.application_gateway_applications
    application_gateways             = local.remote.application_gateways
    azuread_groups                   = local.remote.azuread_groups
    keyvaults                        = local.remote.keyvaults
    managed_identities               = local.remote.managed_identities
    mssql_elastic_pools              = local.remote.mssql_elastic_pools
    mssql_servers                    = local.remote.mssql_servers
    private_dns                      = local.remote.private_dns
    public_ip_addresses              = local.remote.public_ip_addresses
    vnets                            = local.remote.vnets
  }

  security = {
    dynamic_keyvault_secrets      = var.dynamic_keyvault_secrets
    keyvault_certificate_requests = var.keyvault_certificate_requests
  }

  shared_services = {
    monitoring      = var.monitoring
    recovery_vaults = var.recovery_vaults
  }

  webapp = {
    app_service_environments     = var.app_service_environments
    app_service_plans            = var.app_service_plans
    app_services                 = var.app_services
    azurerm_application_insights = var.azurerm_application_insights
  }
}

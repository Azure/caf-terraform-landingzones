module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "~>5.1.0"

  azuread_api_permissions      = var.azuread_api_permissions
  azuread_apps                 = var.azuread_apps
  azuread_groups               = var.azuread_groups
  azuread_roles                = var.azuread_roles
  azuread_users                = var.azuread_users
  current_landingzone_key      = var.landingzone.key
  custom_role_definitions      = var.custom_role_definitions
  diagnostics                  = local.diagnostics
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
  user_type                    = var.user_type

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
    dns_zone_records                     = var.dns_zone_records
    domain_name_registrations            = var.domain_name_registrations
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
    aks_clusters                     = local.remote.aks_clusters
    app_service_environments         = local.remote.app_service_environments
    app_service_plans                = local.remote.app_service_plans
    app_services                     = local.remote.app_services
    application_gateway_applications = local.remote.application_gateway_applications
    application_gateways             = local.remote.application_gateways
    availability_sets                = local.remote.availability_sets
    azuread_applications             = local.remote.azuread_applications
    azuread_groups                   = local.remote.azuread_groups
    azuread_users                    = local.remote.azuread_users
    azurerm_firewalls                = local.remote.azurerm_firewalls
    container_registry               = local.remote.container_registry
    event_hub_namespaces             = local.remote.event_hub_namespaces
    front_door_waf_policies          = local.remote.front_door_waf_policies
    keyvaults                        = local.remote.keyvaults
    managed_identities               = local.remote.managed_identities
    mssql_databases                  = local.remote.mssql_databases
    mssql_elastic_pools              = local.remote.mssql_elastic_pools
    mssql_managed_databases          = local.remote.mssql_managed_databases
    mssql_managed_instances          = local.remote.mssql_managed_instances
    mssql_servers                    = local.remote.mssql_servers
    mysql_servers                    = local.remote.mysql_servers
    network_watchers                 = local.remote.network_watchers
    postgresql_servers               = local.remote.postgresql_servers
    private_dns                      = local.remote.private_dns
    proximity_placement_groups       = local.remote.proximity_placement_groups
    public_ip_addresses              = local.remote.public_ip_addresses
    recovery_vaults                  = local.remote.recovery_vaults
    resource_groups                  = local.remote.resource_groups
    storage_accounts                 = local.remote.storage_accounts
    synapse_workspaces               = local.remote.synapse_workspaces
    vnets                            = local.remote.vnets
  }

  security = {
    keyvault_keys                 = var.keyvault_keys
    keyvault_certificate_requests = var.keyvault_certificate_requests
    keyvault_certificate_issuers  = var.keyvault_certificate_issuers
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

locals {
  database = merge(
    var.database,
    {
      app_config                         = var.app_config
      app_config_entries                 = var.app_config_entries
      azurerm_redis_caches               = var.azurerm_redis_caches
      cosmos_dbs                         = var.cosmos_dbs
      cosmosdb_role_definitions          = var.cosmosdb_role_definitions
      cosmosdb_role_mapping              = var.cosmosdb_role_mapping
      cosmosdb_sql_databases             = var.cosmosdb_sql_databases
      database_migration_projects        = var.database_migration_projects
      database_migration_services        = var.database_migration_services
      databricks_workspaces              = var.databricks_workspaces
      machine_learning_workspaces        = var.machine_learning_workspaces
      mariadb_databases                  = var.mariadb_databases
      mariadb_servers                    = var.mariadb_servers
      mssql_databases                    = var.mssql_databases
      mssql_elastic_pools                = var.mssql_elastic_pools
      mssql_failover_groups              = var.mssql_failover_groups
      mssql_managed_databases            = var.mssql_managed_databases
      mssql_managed_databases_backup_ltr = var.mssql_managed_databases_backup_ltr
      mssql_managed_databases_restore    = var.mssql_managed_databases_restore
      mssql_managed_instances            = var.mssql_managed_instances
      mssql_managed_instances_secondary  = var.mssql_managed_instances_secondary
      mssql_mi_administrators            = var.mssql_mi_administrators
      mssql_mi_failover_groups           = var.mssql_mi_failover_groups
      mssql_mi_secondary_tdes            = var.mssql_mi_secondary_tdes
      mssql_mi_tdes                      = var.mssql_mi_tdes
      mssql_servers                      = var.mssql_servers
      mysql_databases                    = var.mysql_databases
      mysql_flexible_server              = var.mysql_flexible_server
      mysql_servers                      = var.mysql_servers
      postgresql_flexible_servers        = var.postgresql_flexible_servers
      postgresql_servers                 = var.postgresql_servers
      synapse_workspaces                 = var.synapse_workspaces

      data_explorer = {
        kusto_attached_database_configurations = var.kusto_attached_database_configurations
        kusto_cluster_customer_managed_keys    = var.kusto_cluster_customer_managed_keys
        kusto_cluster_principal_assignments    = var.kusto_cluster_principal_assignments
        kusto_clusters                         = var.kusto_clusters
        kusto_database_principal_assignments   = var.kusto_database_principal_assignments
        kusto_databases                        = var.kusto_databases
        kusto_eventgrid_data_connections       = var.kusto_eventgrid_data_connections
        kusto_eventhub_data_connections        = var.kusto_eventhub_data_connections
        kusto_iothub_data_connections          = var.kusto_iothub_data_connections
      }
    }
  )
}

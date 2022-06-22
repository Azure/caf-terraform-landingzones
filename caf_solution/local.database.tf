locals {
  database = merge(
    var.database,
    {
      app_config                         = var.app_config
      app_config_entries                 = var.app_config_entries
      azurerm_redis_caches               = var.azurerm_redis_caches
      cosmos_dbs                         = var.cosmos_dbs
      cosmosdb_sql_databases             = var.cosmosdb_sql_databases
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
      mysql_servers                      = var.mysql_servers
      postgresql_servers                 = var.postgresql_servers
      postgresql_flexible_servers        = var.postgresql_flexible_servers
      synapse_workspaces                 = var.synapse_workspaces
    }
  )
}

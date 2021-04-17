locals {
  data_factory = merge(
    var.data_factory,
    {
      data_factory_pipeline         = var.data_factory_pipeline
      data_factory_trigger_schedule = var.data_factory_trigger_schedule
      datasets = {
        azure_blob       = try(var.datasets.azure_blob, {})
        cosmosdb_sqlapi  = try(var.datasets.cosmosdb_sqlapi, {})
        delimited_text   = try(var.datasets.delimited_text, {})
        http             = try(var.datasets.http, {})
        json             = try(var.datasets.json, {})
        mysql            = try(var.datasets.mysql, {})
        postgresql       = try(var.datasets.postgresql, {})
        sql_server_table = try(var.datasets.sql_server_table, {})
      }
      linked_services = {
        azure_blob_storage = try(var.linked_services.azure_blob_storage, {})
      }
    }
  )
}

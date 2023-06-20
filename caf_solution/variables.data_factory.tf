variable "data_factory" {
  default = {}
}
variable "data_factory_pipeline" {
  default = {}
}
variable "data_factory_trigger_schedule" {
  default = {}
}
variable "datasets" {
  default = {
    # azure_blob
    # cosmosdb_sqlapi
    # delimited_text
    # http
    # json
    # mysql
    # postgresql
    # sql_server_table
  }
}
variable "linked_services" {
  default = {
    # azure_blob_storage
  }
}
variable "data_factory_datasets" {
  default = {
    # azure_blob
    # cosmosdb_sqlapi
    # delimited_text
    # http
    # json
    # mysql
    # postgresql
    # sql_server_table
  }
}
variable "data_factory_linked_services" {
  default = {
    # azure_blob_storage
  }
}
variable "data_factory_linked_service_key_vaults" {
  default = {}
}
variable "data_factory_linked_services_azure_blob_storages" {
  default = {}
}
variable "data_factory_linked_service_azure_databricks" {
  default = {}
}
variable "data_factory_integration_runtime_azure_ssis" {
  default = {}
}
variable "data_factory_integration_runtime_self_hosted" {
  default = {}
}
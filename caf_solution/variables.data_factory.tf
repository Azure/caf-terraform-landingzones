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
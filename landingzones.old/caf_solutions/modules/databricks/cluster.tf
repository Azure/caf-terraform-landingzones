resource "databricks_cluster" "cluster" {
  cluster_name            = var.settings.name
  spark_version           = data.databricks_spark_version.version.id
  node_type_id            = var.settings.node_type_id
  autotermination_minutes = try(var.settings.autotermination_minutes, 120)

  dynamic "autoscale" {
    for_each = try(var.settings.autoscale, null) == null ? [] : [1]

    content {
      min_workers = try(var.settings.autoscale.min_workers, null)
      max_workers = try(var.settings.autoscale.max_workers, null)
    }
  }

}

data "databricks_spark_version" "version" {
  latest            = try(var.settings.spark_version.latest, true)
  long_term_support = try(var.settings.spark_version.long_term_support, false)
  ml                = try(var.settings.spark_version.ml, false)
  genomics          = try(var.settings.spark_version.mlgenomics, false)
  gpu               = try(var.settings.spark_version.gpu, false)
  scala             = try(var.settings.spark_version.scala, "2.12")
  spark_version     = try(var.settings.spark_version.spark_version, "3.0")
}
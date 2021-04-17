resource "databricks_cluster" "cluster" {
  cluster_name            = var.settings.name
  spark_version           = var.settings.spark_version
  node_type_id            = var.settings.node_type_id
  autotermination_minutes = var.settings.autotermination_minutes

  dynamic "autoscale" {
    for_each = try(var.settings.autoscale, null) == null ? [] : [1]

    content {
      min_workers = try(var.settings.autoscale.min_workers, null)
      max_workers = try(var.settings.autoscale.max_workers, null)
    }
  }


}
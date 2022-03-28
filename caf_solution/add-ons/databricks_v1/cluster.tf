resource "databricks_cluster" "cluster" {
  for_each = var.databricks_clusters

  #
  # Required
  #

  spark_version = data.databricks_spark_version.runtime[each.key].id

  #
  # Required - Optional if ....
  #

  # Required - optional if instance_pool_id is given
  node_type_id = can(each.value.instance_pool) ? null : data.databricks_node_type.node_type[each.key].id

  #
  # Optional
  #

  autotermination_minutes      = try(each.value.autotermination_minutes, null)
  cluster_name                 = try(each.value.name, null)
  custom_tags                  = try(each.value.custom_tags, null)
  driver_node_type_id          = can(each.value.driver_node_type) ? data.databricks_node_type.driver_node_type[each.key].id : data.databricks_node_type.node_type[each.key].id
  enable_local_disk_encryption = try(each.value.enable_local_disk_encryption, null)
  idempotency_token            = try(each.value.idempotency_token, null)
  is_pinned                    = try(each.value.is_pinned, false)
  single_user_name             = try(each.value.single_user_name, null)
  spark_conf                   = try(each.value.spark_conf, null)
  spark_env_vars               = try(each.value.spark_env_vars, null)
  ssh_public_keys              = try(each.value.ssh_public_keys, null)

  dynamic "autoscale" {
    for_each = try(each.value.autoscale, null) == null ? [] : [1]

    content {
      min_workers = try(each.value.autoscale.min_workers, null)
      max_workers = try(each.value.autoscale.max_workers, null)
    }
  }

  # Add library block - Doc not super clear - https://registry.terraform.io/providers/databrickslabs/databricks/latest/docs/resources/cluster#library-configuration-block

  dynamic "cluster_log_conf" {
    for_each = try(each.value.cluster_log_conf, {})

    content {
      dynamic "dbfs" {
        for_each = each.value.cluster_log_conf.dbfs

        content {
          destination = dbfs.value
        }
      }
    }
  }

}

data "databricks_node_type" "driver_node_type" {
  for_each = {
    for key, value in var.databricks_clusters : key => value
    if can(value.driver_node_type)
  }

  category                = try(each.value.driver_node_type.min_memory_gb, "General Purpose (HDD)")
  gb_per_core             = try(each.value.driver_node_type.min_memory_gb, 0)
  is_io_cache_enabled     = try(each.value.driver_node_type.is_io_cache_enabled, false)
  local_disk              = try(each.value.driver_node_type.local_disk, false)
  min_cores               = try(each.value.driver_node_type.min_cores, 0)
  min_gpus                = try(each.value.driver_node_type.min_gpus, 0)
  min_memory_gb           = try(each.value.driver_node_type.min_memory_gb, 0)
  photon_driver_capable   = try(each.value.driver_node_type.photon_driver_capable, false)
  photon_worker_capable   = try(each.value.driver_node_type.photon_worker_capable, false)
  support_port_forwarding = try(each.value.driver_node_type.support_port_forwarding, false)

}

data "databricks_node_type" "node_type" {
  for_each = {
    for key, value in var.databricks_clusters : key => value
    if can(value.node_type)
  }

  category                = try(each.value.node_type.min_memory_gb, "General Purpose (HDD)")
  gb_per_core             = try(each.value.node_type.min_memory_gb, 0)
  is_io_cache_enabled     = try(each.value.node_type.is_io_cache_enabled, false)
  local_disk              = try(each.value.node_type.local_disk, false)
  min_cores               = try(each.value.node_type.min_cores, 0)
  min_gpus                = try(each.value.node_type.min_gpus, 0)
  min_memory_gb           = try(each.value.node_type.min_memory_gb, 0)
  photon_driver_capable   = try(each.value.node_type.photon_driver_capable, false)
  photon_worker_capable   = try(each.value.node_type.photon_worker_capable, false)
  support_port_forwarding = try(each.value.node_type.support_port_forwarding, false)

}

data "databricks_spark_version" "runtime" {
  for_each = var.databricks_clusters

  beta              = try(each.value.spark_version.beta, false)
  genomics          = try(each.value.spark_version.genomics, false)
  gpu               = try(each.value.spark_version.gpu, false)
  latest            = try(each.value.spark_version.latest, true)
  long_term_support = try(each.value.spark_version.long_term_support, false)
  ml                = try(each.value.spark_version.ml, false)
  photon            = try(each.value.spark_version.photon, false)
  scala             = try(each.value.spark_version.scala, "2.12")
  spark_version     = try(each.value.spark_version.spark_version, "3.0.1")

}
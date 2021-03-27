output "cluster" {
  value = {
    id           = databricks_cluster.cluster.id
    default_tags = databricks_cluster.cluster.default_tags
    state        = databricks_cluster.cluster.state
  }
}
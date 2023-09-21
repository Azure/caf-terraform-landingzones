
resource "azapi_resource" "container_app_environment" {
  type      = "Microsoft.App/managedEnvironments@2023-05-02-preview"
  name      = "acae-${var.settings.name}"
  parent_id = var.resource_group_id
  location  = var.location
  tags      = local.tags

  schema_validation_enabled = false
  ignore_missing_property = true
  ignore_casing = true

  body = jsonencode({
    properties = {
      appLogsConfiguration = {  
        destination = "log-analytics"
        logAnalyticsConfiguration = {
          customerId = var.log_analytics_workspace_id
          sharedKey  = var.log_analytics_primary_shared_key
        }
      }
      vnetConfiguration = {
        dockerBridgeCidr       = null
        infrastructureSubnetId = var.subnet_id
        internal               = true
        platformReservedCidr   = null
        platformReservedDnsIP  = null
      }
      workloadProfiles = var.settings.workload_profiles
    }
  })
}
resource "azapi_resource" "container_app_job" {
  type      = "Microsoft.App/jobs@2023-05-02-preview"
  name      = "acaj-${var.settings.name}" #2-32 Lowercase letters, numbers, and hyphens. Start with letter and end with alphanumeric.
  location  = var.location
  parent_id = var.resource_group_id
  tags      = local.tags

  dynamic "identity" {
    for_each = try(var.settings.identity, false) == false ? [] : [1]

    content {
      type         = var.settings.identity.type
      identity_ids = local.managed_identities
    }
  }

  # Need to set to false because at the moment only 2022-11-01-preview is supported
  schema_validation_enabled = false
  ignore_missing_property = true
  ignore_casing = true

  body = jsonencode({
    properties = {
      environmentId       = var.container_app_environment_id
      workloadProfileName = var.settings.workload_profile_name
      configuration = {
        secrets               = var.settings.secrets
        triggerType           = "Event"
        replicaTimeout        = var.settings.replica_timeout
        replicaRetryLimit     = var.settings.replica_retry_limit
        manualTriggerConfig   = null
        scheduleTriggerConfig = null
        registries            = null
        dapr                  = null
        eventTriggerConfig = {
          replicaCompletionCount = null
          parallelism            = var.settings.parallelism
          scale = {
            minExecutions   = var.settings.scale_min_executions
            maxExecutions   = var.settings.scale_max_executions
            pollingInterval = var.settings.scale_polling_interval
            rules           = var.settings.rules
          }
        }
      }
      template = {
        containers = [
          {
            image   = var.settings.image
            name    = "ghrunnersacajobs"
            command = null
            args    = null
            env     = var.settings.env
            resources = {
              cpu    = var.settings.cpu
              memory = var.settings.memory
            }
            volumeMounts = null
          }
        ]
        initContainers = null
        volumes        = null
      }
    }
  })
}
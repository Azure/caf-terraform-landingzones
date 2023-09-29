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
        secrets               = try(local.secrets, null)
        triggerType           = "Event"
        replicaTimeout        = try(var.settings.replica_timeout,86400)
        replicaRetryLimit     = try(var.settings.replica_retry_limit, 1)
        manualTriggerConfig   = null
        scheduleTriggerConfig = null
        registries            = try(var.settings.registries, null)
        dapr                  = null
        eventTriggerConfig = {
          replicaCompletionCount = try(var.settings.replica_completion_count, 1)
          parallelism            = var.settings.parallelism
          scale = {
            minExecutions   = try(var.settings.scale_min_executions, 0)
            maxExecutions   = try(var.settings.scale_max_executions, 10)
            pollingInterval = try(var.settings.scale_polling_interval, 30)
            rules           = var.settings.rules
          }
        }
      }
      template = {
        containers = [
          {
            image   = var.settings.image
            name    = try(var.settings.container_name, var.settings.name)
            command = try(var.settings.command, null)
            args    = try(var.settings.args, null)
            env     = var.settings.env
            resources = {
              cpu    = var.settings.cpu
              memory = var.settings.memory
            }
            volumeMounts = try(var.settings.volumeMounts, null)
          }
        ]
        initContainers = try(var.settings.initContainers, null)
        volumes        = try(var.settings.volumes, null)
      }
    }
  })
}
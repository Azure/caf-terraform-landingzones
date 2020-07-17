#outputs the ops log repositories
output diagnostics_map {
  value       = module.diagnostics_logging.diagnostics_map
  description = "outputs diagnostics map as desribed in the diagnostics logging module doc"
}

#outputs the sec log repositories 
output activity_logs_map {
  value       = var.accounting_settings.azure_activity_log_enabled ? module.activity_logs.0.seclogs_map : null
  description = "outputs subscription activity logs map as desribed in the activity logging module doc"
}

#log analytics workspace
output log_analytics_workspace {
  value       = module.log_analytics
  description = "outputs the log analytics configuration settings as documented in log analytics module"
}

output location {
  value       = var.location
  description = "exports the location where objects from foundation have been created"
}

output tags {
  value       = var.tags_hub
  description = "exports the tags created in this blueprint"
}

output prefix {
  value       = var.prefix
  description = "exports the prefix as generated in level0"
}

output resource_group_operations {
  value       = azurerm_resource_group.rg_operations
  description = "rg_group_operations"
}
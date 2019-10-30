#outputs the ops log repositories
output "diagnostics_map" {
  value = module.diagnostics_logging.diagnostics_map
  description = "outputs diagnostics map as desribed in the diagnostics logging module doc"
}

#outputs the sec log repositories 
output "activity_logs_map" {
  value = module.activity_logs.seclogs_map
  description = "outputs subscroption activity logs map as desribed in the activity logging module doc"
}

#outputs of the rg data for hub 
output "resource_group_hub_ids" {
  value = module.resource_group_hub.ids 
  description = "outputs a map with RG Terraform names as keys and value is the Azure object ID"
}

output "resource_group_hub_names" {
  value = module.resource_group_hub.names
  description = "outputs a map with RG Terraform names as keys and value is the RG name (as created)"
}

#log analytics workspace
output "log_analytics_workspace" {
  value = module.log_analytics
  description = "outputs the log analytics configuration settings as documented in log analytics module"
}

output "location" {
  value = var.location
  description = "exports the location where objects from foundation have been created"
}

output "tags" {
  value = var.tags_hub
  description = "exports the tags created in this blueprint"
}

output "prefix" {
  value = var.prefix
  description = "exports the prefix as generated in level0"
}
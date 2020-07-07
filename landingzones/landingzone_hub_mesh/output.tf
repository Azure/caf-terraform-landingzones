output "virtual_wan" {
  description = "Output the full Virtual WAN object"
  sensitive   = false # to hide content from logs
  value       = azurerm_virtual_wan.vwan
}

output "hubs" {
  description = "Output the full object for Virtual Hub 1"
  sensitive   = false # to hide content from logs
  value       = module.virtual_hub.*
}


## re-exporting level1 settings (caf_foundations) for level 3 consumption
output "prefix" {
  value = local.prefix
}

output "landingzone_caf_foundations_accounting" {
  sensitive = true # to hide content from logs
  value     = local.caf_foundations_accounting
}

output "landingzone_caf_foundations_global_settings" {
  sensitive = true # to hide content from logs
  value     = local.global_settings
}
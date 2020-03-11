output "virtual_wan" {
  sensitive   = false                      # to hide content from logs
  value       = azurerm_virtual_wan.vwan
}

## re-exporting level1 settings (caf_foundations) for level 3 consumption
output "prefix" {
  value = local.prefix
}

output "landingzone_caf_foundations_accounting" {
  sensitive   = false                      # to hide content from logs
  value       = local.caf_foundations_accounting
}

output "landingzone_caf_foundations_global_settings" {
  sensitive   = false                      # to hide content from logs
  value       = local.global_settings
}
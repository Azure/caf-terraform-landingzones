output "blueprint_operations" {
  sensitive   = true                      # to hide content from logs
  value       = module.blueprint_operations
}

output "blueprint_networking_shared_transit" {
  sensitive   = true                      # to hide content from logs
  value       = module.blueprint_networking_shared_transit
}

output "blueprint_networking_shared_services" {
  sensitive   = true                      # to hide content from logs
  value       = module.blueprint_networking_shared_services
}

output "blueprint_networking_shared_egress" {
  sensitive   = true                      # to hide content from logs
  value       = module.blueprint_networking_shared_egress
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
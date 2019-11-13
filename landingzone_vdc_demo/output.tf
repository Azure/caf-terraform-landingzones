output "blueprint_tranquility" {
  sensitive   = true                      # to hide content from logs
  value       = module.blueprint_tranquility
}

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
  value       = module.blueprint_operations
}

output "blueprint_networking_shared_egress" {
  sensitive   = true                      # to hide content from logs
  value       = module.blueprint_networking_shared_egress
}

output "prefix" {
  value = local.prefix
}

output "tags" {
  value = var.tags_hub
}

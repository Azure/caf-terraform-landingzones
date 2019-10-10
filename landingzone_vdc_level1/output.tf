output "blueprint_tranquility" {
  sensitive   = true                      # to hide content from logs
  value       = module.blueprint_tranquility
}

output "prefix" {
  value = local.prefix
}

output "tags" {
  value = var.tags_hub
}

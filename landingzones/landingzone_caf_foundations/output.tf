output "blueprint_foundations" {
  sensitive   = true                      # to hide content from logs
  value       = module.blueprint_foundations
  description = "Full output of the foundations blueprint."
}

output "prefix" {
  value = local.prefix
  description = "prefix from level0"
}

output "tags" {
  value = var.tags_hub
  description = "default tags for the objects in foundations blueprint"
}

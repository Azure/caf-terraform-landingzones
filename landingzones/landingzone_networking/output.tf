output vnets {
  value       = module.vnets
  sensitive   = true
  description = "Map of the vnet objects"
}

output firewalls {
  value       = module.az_firewall
  sensitive   = true
  description = "Map of the firewalls"
}


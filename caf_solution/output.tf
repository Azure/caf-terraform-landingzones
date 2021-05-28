output "objects" {
  value = tomap(
    {
      (var.landingzone.key) = {
        for key, value in module.solution : key => value
        if try(value, {}) != {}
      }
    }
  )
  sensitive = true
}

output "global_settings" {
  value = module.solution.global_settings
  sensitive = true
}

output "diagnostics" {
  value = module.solution.diagnostics
  sensitive = true
}

output "tfstates" {
  value     = local.tfstates
  sensitive = true
}

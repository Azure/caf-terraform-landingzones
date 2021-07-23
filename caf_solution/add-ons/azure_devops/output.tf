output "keyvaults" {
  value = tomap(
    {
      (var.landingzone.key) = module.caf.keyvaults
    }
  )
  sensitive = true
}
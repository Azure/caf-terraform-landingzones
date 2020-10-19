output keyvaults {
  value = map(
    var.landingzone.key, module.caf.keyvaults
  )
  sensitive = true
}
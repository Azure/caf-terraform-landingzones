locals {
  security = merge(
    var.security,
    {
      disk_encryption_sets                = var.disk_encryption_sets
      dynamic_keyvault_secrets            = var.dynamic_keyvault_secrets
      keyvault_certificate_issuers        = var.keyvault_certificate_issuers
      keyvault_certificate_requests       = var.keyvault_certificate_requests
      keyvault_certificates               = var.keyvault_certificates
      keyvault_keys                       = var.keyvault_keys
      lighthouse_definitions              = var.lighthouse_definitions
      sentinel_ar_fusions                 = var.sentinel_ar_fusions
      sentinel_ar_ml_behavior_analytics   = var.sentinel_ar_ml_behavior_analytics
      sentinel_ar_ms_security_incidents   = var.sentinel_ar_ms_security_incidents
      sentinel_ar_scheduled               = var.sentinel_ar_scheduled
      sentinel_automation_rules           = var.sentinel_automation_rules
      sentinel_dc_aad                     = var.sentinel_dc_aad
      sentinel_dc_app_security            = var.sentinel_dc_app_security
      sentinel_dc_aws                     = var.sentinel_dc_aws
      sentinel_dc_azure_threat_protection = var.sentinel_dc_azure_threat_protection
      sentinel_dc_ms_threat_protection    = var.sentinel_dc_ms_threat_protection
      sentinel_dc_office_365              = var.sentinel_dc_office_365
      sentinel_dc_security_center         = var.sentinel_dc_security_center
      sentinel_dc_threat_intelligence     = var.sentinel_dc_threat_intelligence
      sentinel_watchlist_items            = var.sentinel_watchlist_items
      sentinel_watchlists                 = var.sentinel_watchlists
    }
  )
}

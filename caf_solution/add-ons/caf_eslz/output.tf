output "objects" {
  value = merge(
    tomap(
      {
        (var.landingzone.key) = {
          "vnets" = {
            for key, value in module.enterprise_scale.azurerm_virtual_network.connectivity : value.location => value
          }
          "virtual_subnets" = {
            for key, value in module.enterprise_scale.azurerm_subnet.connectivity : value.name => value
          }
          "azurerm_firewalls" = {
            for key, value in module.enterprise_scale.azurerm_firewall.connectivity : value.location => value
          }
          "azurerm_firewall_policies" = {
            for key, value in module.enterprise_scale.azurerm_firewall_policy.connectivity : value.location => value
          }
          "private_dns_zones" = {
            for key, value in module.enterprise_scale.azurerm_private_dns_zone.connectivity : value.name => value
          }
          "virtual_network_gateways" = {
            for key, value in module.enterprise_scale.azurerm_virtual_network_gateway.connectivity : value.name => value
          }
        }
      }
    ),
    module.enterprise_scale
  )
  sensitive = true
}

output "custom_landing_zones" {
  value = local.custom_landing_zones
}
## creates a virtual hub in the region
resource "azurerm_virtual_hub" "vwan_hub" {
  name                = var.vwan.hub_name
  resource_group_name = var.rg
  location            = var.location
  virtual_wan_id      = var.vwan_id
  address_prefix      = var.vwan.hub_address_prefix
  tags                = var.tags

  timeouts {
    delete = "60m"
  }
}

## create the VPN S2S if var.vwan.s2s_gateway is set to true 
## TBD: implement fully as: https://www.terraform.io/docs/providers/azurerm/r/vpn_gateway.html 
resource "azurerm_vpn_gateway" "s2s_gateway" {
  count = var.vwan.deploy_s2s ? 1 : 0

  name                = "s2s_gateway"
  location            = var.location
  resource_group_name = var.rg
  tags                = var.tags
  virtual_hub_id      = azurerm_virtual_hub.vwan_hub.id

  scale_unit            = lookup(var.vwan.s2s_config, "scale_unit", null)
  #bgp_settings
  timeouts {
    create = "60m"
    delete = "60m"
  }
}

# ## create the VPN P2S if var.vwan.p2s_gateway is set to true 
# ## TBD: implement fully as: https://www.terraform.io/docs/providers/azurerm/r/point_to_site_vpn_gateway.html
resource "azurerm_point_to_site_vpn_gateway" "p2s_gateway" {
  count = var.vwan.deploy_p2s ? 1 : 0

  name                = "p2s_gateway"
  location            = var.location
  resource_group_name = var.rg
  tags                = var.tags
  virtual_hub_id      = azurerm_virtual_hub.vwan_hub.id
  vpn_server_configuration_id = azurerm_vpn_server_configuration.p2s_configuration[0].id

  scale_unit            = lookup(var.vwan.p2s_config, "scale_unit", null)
  #bgp_settings
  connection_configuration {
    name = "connection"
    vpn_client_address_pool {
      address_prefixes = ["192.168.0.0/24"]
    }
  }
  timeouts {
    create = "60m"
    delete = "60m"
  }
}

# ## creates the VPN P2S server configuration, this is required for P2S site.
# ## TBD: https://www.terraform.io/docs/providers/azurerm/r/vpn_server_configuration.html
resource "azurerm_vpn_server_configuration" "p2s_configuration" {
  count = var.vwan.deploy_p2s ? 1 : 0
  name                     = "s2s_gateway"
  resource_group_name      = var.rg
  location                 = var.location
  vpn_authentication_types = ["Certificate"]
  
  client_root_certificate {
    name             = "DigiCert-Federated-ID-Root-CA"
    public_cert_data = <<EOF
MIIDuzCCAqOgAwIBAgIQCHTZWCM+IlfFIRXIvyKSrjANBgkqhkiG9w0BAQsFADBn
MQswCQYDVQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYDVQQLExB3
d3cuZGlnaWNlcnQuY29tMSYwJAYDVQQDEx1EaWdpQ2VydCBGZWRlcmF0ZWQgSUQg
Um9vdCBDQTAeFw0xMzAxMTUxMjAwMDBaFw0zMzAxMTUxMjAwMDBaMGcxCzAJBgNV
BAYTAlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdp
Y2VydC5jb20xJjAkBgNVBAMTHURpZ2lDZXJ0IEZlZGVyYXRlZCBJRCBSb290IENB
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAvAEB4pcCqnNNOWE6Ur5j
QPUH+1y1F9KdHTRSza6k5iDlXq1kGS1qAkuKtw9JsiNRrjltmFnzMZRBbX8Tlfl8
zAhBmb6dDduDGED01kBsTkgywYPxXVTKec0WxYEEF0oMn4wSYNl0lt2eJAKHXjNf
GTwiibdP8CUR2ghSM2sUTI8Nt1Omfc4SMHhGhYD64uJMbX98THQ/4LMGuYegou+d
GTiahfHtjn7AboSEknwAMJHCh5RlYZZ6B1O4QbKJ+34Q0eKgnI3X6Vc9u0zf6DH8
Dk+4zQDYRRTqTnVO3VT8jzqDlCRuNtq6YvryOWN74/dq8LQhUnXHvFyrsdMaE1X2
DwIDAQABo2MwYTAPBgNVHRMBAf8EBTADAQH/MA4GA1UdDwEB/wQEAwIBhjAdBgNV
HQ4EFgQUGRdkFnbGt1EWjKwbUne+5OaZvRYwHwYDVR0jBBgwFoAUGRdkFnbGt1EW
jKwbUne+5OaZvRYwDQYJKoZIhvcNAQELBQADggEBAHcqsHkrjpESqfuVTRiptJfP
9JbdtWqRTmOf6uJi2c8YVqI6XlKXsD8C1dUUaaHKLUJzvKiazibVuBwMIT84AyqR
QELn3e0BtgEymEygMU569b01ZPxoFSnNXc7qDZBDef8WfqAV/sxkTi8L9BkmFYfL
uGLOhRJOFprPdoDIUBB+tmCl3oDcBy3vnUeOEioz8zAkprcb3GHwHAK+vHmmfgcn
WsfMLH4JCLa/tRYL+Rw/N3ybCkDp00s0WUZ+AoDywSl0Q/ZEnNY0MsFiw6LyIdbq
M/s/1JRtO3bDSzD9TazRVzn2oBqzSa8VgIo5C1nOnoAKJTlsClJKvIhnRlaLQqk=
EOF
  }
  timeouts {
    create = "60m"
    delete = "60m"
  }
}

## vwan peering objects with Virtual Network
# bug pending resolving SDK version? 

## create the ER Gateway 
# resource "azurerm_virtual_network_gateway" "er_gateway" {
#   count = var.vwan.deploy_er ? 1 : 0
# }

## create the diagnostics
# module "diagnostics_virtual_wan" {
#   source  = "aztfmod/caf-diagnostics/azurerm"
#   version = "1.0.0"

#     name                            = azurerm_virtual_wan.vwan.name
#     resource_id                     = azurerm_virtual_wan.vwan.id
#     log_analytics_workspace_id      = var.log_analytics_workspace_id
#     diagnostics_map                 = var.diagnostics_map
#     diag_object                     = var.bastion_config.diagnostics_settings
# }


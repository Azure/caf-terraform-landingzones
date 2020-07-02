# Configuration sample for Azure Virtual WAN hub and spoke 
virtual_hub_config = {
  virtual_wan = {
    resource_group_name = "virtualwan"
    name                = "ContosovWAN"
    dns_name            = "private.contoso.com"

    hubs = {
      hub1 = {
        hub_name                      = "SEA-HUB"
        region                        = "southeastasia"
        hub_address_prefix            = "10.0.3.0/24"
        deploy_firewall               = true
        peerings                      = {}
        firewall_name                 = "azfwsg"
        firewall_resource_groupe_name = "azfwsg"
        deploy_p2s                    = false
        p2s_config = {
          name       = "caf-sea-vpn-p2s"
          scale_unit = 2
          connection_configuration = {
            name = "client-connections"
            vpn_client_address_pool = {
              address_prefixes = ["192.168.0.0/24"]
            }
          }
          server_config = {
            vpn_authentication_types = ["Certificate"]
            client_root_certificate = {
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
          }
        }
        deploy_s2s = false
        s2s_config = {
          name       = "caf-sea-vpn-s2s"
          scale_unit = 1
        }
        deploy_er = false
        er_config = {
          name        = "caf-sea-er"
          scale_units = 1
        }

      }

      hub2 = {
        hub_name                      = "HK-HUB"
        region                        = "eastasia"
        hub_address_prefix            = "10.0.4.0/24"
        deploy_firewall               = true
        firewall_name                 = "azfhk"
        firewall_resource_groupe_name = "azfhk"
        peerings = {
          ## this key must match with the key of the virtual network declared in the var.spokes structure
          spoke1 = {
            # TODO: add support for remote_virtual_network_id = <ID of the virtual network>
            # optional if the virtual network has been provisionned outside.
            hub_to_vitual_network_traffic_allowed          = true
            vitual_network_to_hub_gateways_traffic_allowed = true
            internet_security_enabled                      = false
          }
        }
        deploy_p2s = false
        p2s_config = {}
        deploy_s2s = false
        s2s_config = {}
        deploy_er  = false
        er_config  = {}
      }
    }
  }
}

spokes = {
  spoke1 = {
    rg = {
      name     = "virtualhub-spoke-test"
      location = "eastasia"
    }
    peering_name = "spoke1-hub-hk-link"
    network = {
      vnet = {
        name          = "Core-Network"
        address_space = ["10.0.10.0/24"]
      }
      specialsubnets = {}

      subnets = {
        subnet0 = {
          name     = "Web_tier"
          cidr     = ["10.0.10.0/26"]
          nsg_name = "Web_tier_nsg"
          nsg = [
            {
              name                       = "HTTP-In",
              priority                   = "100"
              direction                  = "Inbound"
              access                     = "Allow"
              protocol                   = "tcp"
              source_port_range          = "*"
              destination_port_range     = "80"
              source_address_prefix      = "*"
              destination_address_prefix = "*"
            },
            {
              name                       = "HTTPS-In",
              priority                   = "101"
              direction                  = "Inbound"
              access                     = "Allow"
              protocol                   = "tcp"
              source_port_range          = "*"
              destination_port_range     = "443"
              source_address_prefix      = "*"
              destination_address_prefix = "*"
            },
          ]
        }
        subnet2 = {
          name     = "Data_tier"
          cidr     = ["10.0.10.128/26"]
          nsg_name = "Data_tier_nsg"
          nsg = [
            {
              name                       = "TDS-In",
              priority                   = "100"
              direction                  = "Inbound"
              access                     = "Allow"
              protocol                   = "UDP"
              source_port_range          = "*"
              destination_port_range     = "1433"
              source_address_prefix      = "*"
              destination_address_prefix = "*"
            }
          ]
        }
      }
      diagnostics = {
        log = [
          # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period] 
          ["VMProtectionAlerts", true, true, 60],
        ]
        metric = [
          #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]                 
          ["AllMetrics", true, true, 60],
        ]
      }
    }
  }
}
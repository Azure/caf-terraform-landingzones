level = "level2"

landingzone_name = "networking_hub"

tfstates = {
  caf_foundations = {
    tfstate = "caf_foundations.tfstate"
  }
  networking = {
    tfstate = "caf_foundations.tfstate"
  }
}

resource_groups = {
  vnet_rg1 = {
    name   = "vnet-spoke-rg1"
    region = "region1"
  }
  hub_rg1 = {
    name   = "vnet-hub-rg1"
    region = "region1"
  }
  hub_fw_rg1 = {
    name   = "vnet-hub-fw-rg1"
    region = "region1"
  }
  hub_fw_rg2 = {
    name   = "vnet-hub-fw-rg2"
    region = "region2"
  }
}

vnets = {
  vnet_rg1 = {
    resource_group_key = "vnet_rg1"
    region             = "region1"
    vnet = {
      name          = "hub-rg1"
      address_space = ["10.10.100.0/24"]
    }
    specialsubnets = {
      AzureFirewallSubnet = {
        name = "AzureFirewallSubnet" #Must be called AzureFirewallSubnet
        cidr = ["10.10.100.192/26"]
      }
    }
    subnets = {
      AzureBastionSubnet = {
        name    = "AzureBastionSubnet" #Must be called AzureBastionSubnet
        cidr    = ["10.10.100.160/27"]
        nsg_key = "azure_bastion_nsg"
      }
    }
  }
}

network_security_group_definition = {
  empty_nsg = {

    diagnostic_profiles = {
      nsg = {
        definition_key   = "network_security_group"
        destination_type = "storage"
        destination_key  = "all_regions"
      }
      operations = {
        name             = "operations"
        definition_key   = "network_security_group"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
    }
  }

  azure_bastion_nsg = {
    diagnostic_profiles = {
      nsg = {
        definition_key   = "network_security_group"
        destination_type = "storage"
        destination_key  = "all_regions"
      }
      operations = {
        name             = "operations"
        definition_key   = "network_security_group"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
    }

    nsg = [
      {
        name                       = "bastion-in-allow",
        priority                   = "100"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      {
        name                       = "bastion-control-in-allow-443",
        priority                   = "120"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "135"
        source_address_prefix      = "GatewayManager"
        destination_address_prefix = "*"
      },
      {
        name                       = "Kerberos-password-change",
        priority                   = "121"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "4443"
        source_address_prefix      = "GatewayManager"
        destination_address_prefix = "*"
      },
      {
        name                       = "bastion-vnet-out-allow-22",
        priority                   = "103"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "VirtualNetwork"
      },
      {
        name                       = "bastion-vnet-out-allow-3389",
        priority                   = "101"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "3389"
        source_address_prefix      = "*"
        destination_address_prefix = "VirtualNetwork"
      },
      {
        name                       = "bastion-azure-out-allow",
        priority                   = "120"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "AzureCloud"
      }
    ]
  }
}

virtual_wans = {
  vwan_rg1 = {
    resource_group_key = "hub_rg1"
    name               = "ContosovWAN-rg1"
    region             = "region1"

    hubs = {
      hub_rg1 = {
        hub_name                    = "hub-rg1"
        region                      = "region1"
        hub_address_prefix          = "10.0.3.0/24"
        deploy_firewall             = true
        firewall_name               = "hub-fw-rg1"
        firewall_resource_group_key = "hub_fw_rg1"
        deploy_p2s                  = false
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

      hub_rg2 = {
        hub_name                    = "hub-rg2"
        region                      = "region2"
        hub_address_prefix          = "10.0.4.0/24"
        deploy_firewall             = true
        firewall_name               = "hub-fw-rg2"
        firewall_resource_group_key = "hub_fw_rg2"
        deploy_p2s                  = false
        p2s_config                  = {}
        deploy_s2s                  = false
        s2s_config                  = {}
        deploy_er                   = false
        er_config                   = {}
      }
    }
  }
}



vhub_peerings = {
  # Establish the peering with Virtual Hubs
  hub_rg1-TO-vnet_rg1 = {
    vhub = {
      virtual_wan_key = "vwan_rg1"
      virtual_hub_key = "hub_rg1"
    }
    vnet = {
      # If the virtual network is stored in another another landing zone, use the following attributes to refer the state file:
      # tfstate_key = "networking"
      # lz_key      = "networking"
      # output_key  = "vnets"
      vnet_key = "vnet_rg1"
    }
    name                                           = "vhub_peering_hub_sg"
    hub_to_vitual_network_traffic_allowed          = true
    vitual_network_to_hub_gateways_traffic_allowed = true
    internet_security_enabled                      = true
  }
}

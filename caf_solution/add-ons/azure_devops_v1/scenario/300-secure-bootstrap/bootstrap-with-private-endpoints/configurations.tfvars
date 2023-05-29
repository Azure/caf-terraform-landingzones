landingzone = {
  backend_type = "azurerm"
  level        = "level0"
  key          = "bootstrap"
}

global_settings = {
  default_region = "region1"
  inherit_tags   = true
  passthrough    = false
  prefix         = ""
  random_length  = 3
  regions = {
    region1 = "southeastasia"
  }
  use_slug = true

}

resource_groups = {
  bootstrap = {
    name   = "bootstrap"
    region = "region1"
  }
}

vnets = {
  bootstrap = {
    resource_group_key = "bootstrap"
    vnet = {
      name          = "bootstrap"
      address_space = ["192.168.123.0/24"]
    }
  }
}

virtual_subnets = {
  gateway_subnet = {
    name           = "GatewaySubnet"
    special_subnet = true
    cidr           = ["192.168.123.0/25"]
    nsg_key        = "empty_nsg"
    vnet = {
      key = "bootstrap"
    }
  }
  dns_in = {
    name    = "in"
    cidr    = ["192.168.123.128/26"]
    nsg_key = "empty_nsg"
    vnet = {
      key = "bootstrap"
    }
    delegation = {
      name               = "Microsoft.Network.dnsResolvers"
      service_delegation = "Microsoft.Network/dnsResolvers"
      actions            = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  }
  dns_out = {
    name    = "out"
    cidr    = ["192.168.123.192/26"]
    nsg_key = "empty_nsg"
    vnet = {
      key = "bootstrap"
    }
    delegation = {
      name               = "Microsoft.Network.dnsResolvers"
      service_delegation = "Microsoft.Network/dnsResolvers"
      actions            = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  }
}

public_ip_addresses = {
  gw_pip0 = {
    name                    = "pip0"
    resource_group_key      = "bootstrap"
    sku                     = "Basic"
    allocation_method       = "Dynamic"
    ip_version              = "IPv4"
    idle_timeout_in_minutes = "4"
  }
}

virtual_network_gateways = {
  p2s_gw = {
    name               = "gw"
    resource_group_key = "bootstrap"
    type               = "Vpn"
    sku                = "VpnGw1"
    vpn_type           = "RouteBased"
    # multiple IP configs are needed for active_active state. VPN Type only.
    ip_configuration = {
      pip0 = {
        ipconfig_name                 = "gw_pip0"
        public_ip_address_key         = "gw_pip0"
        subnet_key                    = "gateway_subnet"
        private_ip_address_allocation = "Dynamic"
      }
    }

    custom_route = {
      default = {
        address_prefixes = [
          "10.101.0.0/16",
          "10.102.0.0/16"
        ]
      }
    }

    vpn_client_configuration = {
      # The following vpn client config allows AzureAD authentication together with certificate authentication
      clients = {
        address_space = ["192.168.124.0/29"]

        vpn_auth_types       = ["Certificate"]
        vpn_client_protocols = ["OpenVPN"]

        root_certificates = {
          laurent = {
            name                  = "laurent"
            public_cert_data_file = "~/.certs/caCert64.pem"
          }
        }
      }
    }
  }
}

private_dns_resolvers = {
  dns1 = {
    name               = "dns"
    resource_group_key = "bootstrap"
    region             = "region1"
    vnet = {
      #lz_key = ""
      key = "bootstrap"
      #id = ""
    }
  }

}

private_dns_resolver_inbound_endpoints = {
  inbound = {
    name = "inbound"
    private_dns_resolver = {
      key = "dns1"
      #lz_key = ""
    }
    ip_configurations = {
      ip_config1 = {
        #subnet_id=""
        vnet = {
          #lz_key = ""
          key = "bootstrap"
          #id = ""
          subnet_key = "dns_in"
        }

      }
    }
  }
}

private_dns_resolver_outbound_endpoints = {
  outbound = {
    name = "outbound"
    private_dns_resolver = {
      key = "dns1"
      #lz_key = ""
    }
    #subnet_id =""
    vnet = {
      #lz_key = ""
      key = "bootstrap"
      #id = ""
      subnet_key = "dns_out"
    }


  }
}

private_dns_resolver_dns_forwarding_rulesets = {
  ruleset1 = {
    name = "test-forwarding-ruleset1"
    resource_group = {
      #lz_key = ""
      key = "bootstrap"
    }
    dns_resolver_outbound_endpoints = {
      outbound = {
        #lz_key =""
        #id = ""
        key = "outbound"
      }
    }
  }
}

private_dns_resolver_virtual_network_links = {
  bootstrap = {
    dns_forwarding_ruleset = {
      #lz_key =""
      #id=""
      key = "ruleset1"
    }
    virtual_network_links = {
      bootstrap = {
        #lz_key = ""
        key = "bootstrap"
        #id = ""
        name = "bootstrap"
      }
    }
  }
}
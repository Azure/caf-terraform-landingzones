appgw_object               = {
    name                   = "example-appgateway"
    sku                    = {
    name                   = "Standard_Small"
    tier                   = "Standard"
    capacity               = 2
  }

  gateway_ip_configuration = {
    name                   = "my-gateway-ip-configuration"
  }

  frontend_port            = {                                 
    name                   = "myfrontend"
    port                   = 80
  }
}

app_object                 = {
  app1                   = {
    frontend_ip_configuration  = {                   
            name                   = "myfrontendip"
            public_ip_address_id   = "/subscriptions/461377a7-433d-4980-9506-c35defb10a49/resourceGroups/rg_neu_terraform/providers/Microsoft.Network/publicIPAddresses/test-gw-pip"
          ## public/private
    }
    backend_address_pool       = {
             name                  = "mybackendip"
    }

    backend_http_settings      = {
             name                   = "mybackendsettings"
             cookie_based_affinity  = "Disabled"
             path                   = "/path1/"
             port                   = 80
             protocol               = "Http"
             request_timeout        = 1
    }

    http_listener              = {
            name                           = "mylistenername"
            frontend_ip_configuration_name = "myfrontendip"
            frontend_port_name             = "myfrontend"
            protocol                       = "Http"
    }
    ## move to appgtw and reference here to type (http/https)

    request_routing_rule       = {
            name                           = "routingrulename"
            rule_type                      = "Basic"
            http_listener_name             = "mylistenername"
            backend_address_pool_name      = "mybackendip"
            backend_http_settings_name     = "mybackendsettings"   
    }
  }
}
resource "azurerm_application_gateway" "appgtw" {
  name                             = var.appgw_object.name
  resource_group_name              = var.resource_group_name
  location                         = var.location
  tags                             = local.tags

  identity                        = lookup(var.appgw_object, "identity", null)
  zones                           = lookup(var.appgw_object, "zones", null)
  ssl_policy                      = lookup(var.appgw_object, "ssl_policy", null)
  enable_http2                    = lookup(var.appgw_object, "enable_http2", null)

  sku {
    name                           = var.appgw_object.sku.name
    tier                           = var.appgw_object.sku.tier
    capacity                       = var.appgw_object.sku.capacity
  }

  gateway_ip_configuration {
    name                           = var.appgw_object.gateway_ip_configuration.name
    subnet_id                      = var.subnet_id
  }

  frontend_port {                                 
    name                           = var.appgw_object.frontend_port.name
    port                           = var.appgw_object.frontend_port.port
  }

  for_each                          = var.app_object
  #following dynamic objects iterated from the app_object structure (multiple applications can be deployed )

      dynamic "frontend_ip_configuration" {                  # in the appgw object 
        for_each =  [each.value.frontend_ip_configuration]
          content {
            name                           = frontend_ip_configuration.value.name
            subnet_id                      = frontend_ip_configuration.value.subnet_id
            public_ip_address_id           = lookup(frontend_ip_configuration.value, public_ip_address_id, null)
            private_ip_address             = lookup(frontend_ip_configuration.value, private_ip_address, null)
          }
      }
      
      dynamic "backend_address_pool" {
      for_each = [each.value.backend_address_pool]   
        content {                     #for each application 
          name                           = backend_address_pool.value.name
        }
      }

      dynamic "backend_http_settings" {
        for_each = [each.value.backend_http_settings]
          content {  #for each with application object 
            name                           = backend_http_settings.value.name
            cookie_based_affinity          = backend_http_settings.value.cookie_based_affinity
            path                           = backend_http_settings.value.path
            port                           = backend_http_settings.value.port
            protocol                       = backend_http_settings.value.protocol
            request_timeout                = backend_http_settings.value.request_timeout
          }
      }

      dynamic "http_listener" {
        for_each = [each.value.http_listener] 
          content  {   #need one http and https per application so object for each 
          ## not per app? get out of this loop? 
            name                           = http_listener.value.name 
            frontend_ip_configuration_name = http_listener.value.frontend_ip_configuration_name
            frontend_port_name             = http_listener.value.frontend_port_name
            protocol                       = http_listener.value.protocol
          }
      }

      dynamic "request_routing_rule" {    #for each application 
          for_each = [each.value.request_routing_rule] 
          content {
            name                           = request_routing_rule.value.name
            rule_type                      = request_routing_rule.value.rule_type
            http_listener_name             = request_routing_rule.value.http_listener_name
            backend_address_pool_name      = request_routing_rule.value.backend_address_pool_name
            backend_http_settings_name     = request_routing_rule.value.backend_http_settings_name
          }
      }
}

//todo: add diagnostics 
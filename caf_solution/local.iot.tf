locals {
  iot = {
    digital_twins_endpoint_eventgrids   = var.digital_twins_endpoint_eventgrids
    digital_twins_endpoint_eventhubs    = var.digital_twins_endpoint_eventhubs
    digital_twins_endpoint_servicebuses = var.digital_twins_endpoint_servicebuses
    digital_twins_instances             = var.digital_twins_instances
    iot_central_application             = var.iot_central_application
    iot_dps_certificate                 = var.iot_dps_certificate
    iot_dps_shared_access_policy        = var.iot_dps_shared_access_policy
    iot_hub                             = var.iot_hub
    iot_hub_certificate                 = var.iot_hub_certificate
    iot_hub_consumer_groups             = var.iot_hub_consumer_groups
    iot_hub_dps                         = var.iot_hub_dps
    iot_hub_shared_access_policy        = var.iot_hub_shared_access_policy
    iot_security_device_group           = var.iot_security_device_group
    iot_security_solution               = var.iot_security_solution
  }
}

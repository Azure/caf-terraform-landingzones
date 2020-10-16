virtual_wans = {
  vwan_re1 = {
    resource_group_key = "hub_re1"
    name               = "contosovWAN-re1"
    region             = "region1"

    hubs = {
      hub_re1 = {
        hub_name                    = "hub-re1"
        region                      = "region1"
        hub_address_prefix          = "10.0.3.0/24"
        deploy_firewall             = true
        firewall_name               = "hub-fw-re1"
        firewall_resource_group_key = "hub_re1"
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

      hub_re2 = {
        hub_name                    = "hub-re2"
        region                      = "region2"
        hub_address_prefix          = "10.0.4.0/24"
        deploy_firewall             = true
        firewall_name               = "hub-fw-re2"
        firewall_resource_group_key = "hub_re2"
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


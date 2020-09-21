global_settings = {
  regions = {
    region1 = "eastasia"
  }
}

resource_groups = {
  vnet_sg = {
    name = "vnet-hub-sg"
  }
}

storage_accounts = {
  diagnostics = {
    name               = "diag"
    resource_group_key = "vnet_sg"
  }
}

vnets = {
  hub_sg = {
    resource_group_key = "vnet_sg"
    vnet = {
      name          = "hub"
      address_space = ["10.10.100.0/24"]
    }
    specialsubnets = {
      AzureFirewallSubnet = {
        name = "AzureFirewallSubnet" #Must be called AzureFirewallSubnet
        cidr = ["10.10.100.192/26"]
      }
    }
    subnets = {
      jumpbox = {
        name    = "jumpbox"
        cidr    = ["10.10.100.0/25"]
        nsg_key = "jumpbox"
      }
    }

  }

}

# firewalls = {
#   # Southeastasia firewall (do not change the key when created)
#   southeastasia = {
#     location           = "southeastasia"
#     resource_group_key = "vnet_sg"
#     vnet_key           = "hub_sg"

#     # Settings for the public IP address to be used for Azure Firewall
#     # Must be standard and static for
#     firewall_ip_addr_config = {
#       ip_name           = "firewall"
#       allocation_method = "Static"
#       sku               = "Standard" #defaults to Basic
#       ip_version        = "IPv4"     #defaults to IP4, Only dynamic for IPv6, Supported arguments are IPv4 or IPv6, NOT Both
#       diagnostics = {
#         log = [
#           #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
#           ["DDoSProtectionNotifications", true, true, 30],
#           ["DDoSMitigationFlowLogs", true, true, 30],
#           ["DDoSMitigationReports", true, true, 30],
#         ]
#         metric = [
#           ["AllMetrics", true, true, 30],
#         ]
#       }
#     }

#     # Settings for the Azure Firewall settings
#     az_fw_config = {
#       name = "azfw"
#       diagnostics = {
#         log = [
#           #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
#           ["AzureFirewallApplicationRule", true, true, 30],
#           ["AzureFirewallNetworkRule", true, true, 30],
#         ]
#         metric = [
#           ["AllMetrics", true, true, 30],
#         ]
#       }
#     }

#   }

# }

# User assigned identities
managed_identities = {
  kubernetes_retail = {
    name               = "kubernetes_retail_landingzone"
    resource_group_key = "vnet_sg"
  }
  datalake_retail = {
    name               = "datalake_retail_landingzones"
    resource_group_key = "vnet_sg"
  }
}

# Virtual machines
virtual_machines = {

  # Configuration to deploy a bastion host linux virtual machine
  bastion_host = {
    resource_group_key = "vnet_sg"

    # Define the number of networking cards to attach the virtual machine
    networking_interfaces = {
      nic0 = {
        # Value of the keys from networking.tfvars
        vnet_key                = "hub_sg"
        subnet_key              = "jumpbox"
        name                    = "nic0"
        enable_ip_forwarding    = false
        internal_dns_name_label = "nic0"
      }
      nic1 = {
        # Value of the keys from networking.tfvars
        vnet_key                = "hub_sg"
        subnet_key              = "jumpbox"
        name                    = "nic1"
        enable_ip_forwarding    = false
        internal_dns_name_label = "nic1"
      }
    }

    #
    virtual_machine_settings = {
      linux = {
        name                            = "bastion"
        resource_group_key              = "vnet_sg"
        size                            = "Standard_F2"
        admin_username                  = "adminuser"
        disable_password_authentication = true

        # Value of the nic keys to attach the VM. The first one in the list is the default nic
        network_interface_keys = ["nic0", "nic1"]

        os_disk = {
          name                 = "bastion-os"
          caching              = "ReadWrite"
          storage_account_type = "Standard_LRS"
        }

        source_image_reference = {
          publisher = "Canonical"
          offer     = "UbuntuServer"
          sku       = "16.04-LTS"
          version   = "latest"
        }

        identity = {
          type = "UserAssigned"
          managed_identity_keys = [
            "kubernetes_retail",
            "datalake_retail"
          ]
        }

      }
    }

    data_disks = {
      db_data1 = {
        name                 = "bastion-db-data1"
        storage_account_type = "Standard_LRS"
        # Only Empty is supported. More community contributions required to cover other scenarios
        create_option = "Empty"
        disk_size_gb  = "10"
        lun           = 1
      }
      # db_data2 = {
      #   name                  = "bastion-db-data2"
      #   storage_account_type  = "Standard_LRS"
      #   create_option = "Empty"
      #   disk_size_gb = "10"
      #   lun           = 2
      # }
    }


  }
}
##################################################
#
# Compute resources
#
##################################################

bastion_hosts = {
  launchpad_host = {
    name               = "bastion"
    resource_group_key = "bastion_launchpad"
    vnet_key           = "devops_region1"
    subnet_key         = "AzureBastionSubnet"
    public_ip_key      = "bastion_host_rg1"

    # you can setup up to 5 profiles
    diagnostic_profiles = {
      operations = {
        definition_key   = "bastion_host"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
    }

  }
}

# Virtual machines
virtual_machines = {

  # Configuration to deploy a bastion host linux virtual machine
  bastion_host = {
    resource_group_key                   = "bastion_launchpad"
    region                               = "region1"
    boot_diagnostics_storage_account_key = "bootdiag_region1"
    provision_vm_agent                   = true

    os_type = "linux"

    # the auto-generated ssh key in keyvault secret. Secret name being {VM name}-ssh-public and {VM name}-ssh-private
    keyvault_key = "secrets"

    # Define the number of networking cards to attach the virtual machine
    networking_interfaces = {
      nic0 = {
        # Value of the keys from networking.tfvars
        vnet_key                = "devops_region1"
        subnet_key              = "jumpbox"
        name                    = "0"
        enable_ip_forwarding    = false
        internal_dns_name_label = "nic0"

        # you can setup up to 5 profiles
        diagnostic_profiles = {
          operations = {
            definition_key   = "network_interface_card"
            destination_type = "storage"
            destination_key  = "all_regions"
          }
        }

      }
    }

    virtual_machine_settings = {
      linux = {
        name                            = "bastion"
        size                            = "Standard_F2"
        admin_username                  = "adminuser"
        disable_password_authentication = true
        custom_data                     = "scripts/cloud-init-install-rover-tools.config"

        # Value of the nic keys to attach the VM. The first one in the list is the default nic
        network_interface_keys = ["nic0"]

        os_disk = {
          name                 = "bastion-os"
          caching              = "ReadWrite"
          storage_account_type = "Standard_LRS"
        }

        source_image_reference = {
          publisher = "Canonical"
          offer     = "UbuntuServer"
          sku       = "18.04-LTS"
          version   = "latest"
        }

        identity = {
          type = "UserAssigned"
          managed_identity_keys = [
            "level0", "level1", "level2", "level3", "level4"
          ]
        }

      }
    }

  }
}


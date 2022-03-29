
# Virtual machines
virtual_machines = {

  # Configuration to deploy a bastion host linux virtual machine
  level0 = {
    resource_group_key                   = "rg1"
    provision_vm_agent                   = true
    boot_diagnostics_storage_account_key = "bootdiag_region1"

    os_type = "linux"

    keyvault_key = "ssh"

    # Define the number of networking cards to attach the virtual machine
    networking_interfaces = {
      nic0 = {
        # Value of the keys from networking.tfvars
        lz_key                  = "launchpad"
        vnet_key                = "devops_region1"
        subnet_key              = "release_agent_level0"
        name                    = "0-release-agent-level0"
        enable_ip_forwarding    = false
        internal_dns_name_label = "release-agent-level0"
      }
    }

    virtual_machine_settings = {
      linux = {
        name                            = "release-agent-level0"
        size                            = "Standard_F2s_v2"
        admin_username                  = "adminuser"
        disable_password_authentication = true

        # Value of the nic keys to attach the VM. The first one in the list is the default nic
        network_interface_keys = ["nic0"]

        os_disk = {
          name                 = "release-agent-level0-os"
          caching              = "ReadWrite"
          storage_account_type = "Standard_LRS"
        }

        source_image_reference = {
          publisher = "canonical"
          offer     = "0001-com-ubuntu-server-focal"
          sku       = "20_04-lts"
          version   = "latest"
        }

        identity = {
          type = "UserAssigned"

          remote = {
            launchpad = {
              managed_identity_keys = [
                "level0",
              ]
            }
          }
        }


      }
    }

    virtual_machine_extensions = {
      devops_selfhosted_agent = {
        version             = 1
        virtual_machine_key = "vm_devops_level0"
        agent_init_script   = "devops_runtime_baremetal.sh"
        # You can define storage_account_blobs_urls directly
        # storage_account_blobs_urls = ["https://somelocation/container/script.ps1"]
        storage_account_blobs = [
          "devops_runtime_baremetal"
        ]
      }
    }

  }
}

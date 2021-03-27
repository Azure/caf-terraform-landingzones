
# Virtual machines
virtual_machines = {

  # Configuration to deploy a bastion host linux virtual machine
  level1 = {
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
        subnet_key              = "release_agent_level1"
        name                    = "0-release-agent-level1"
        enable_ip_forwarding    = false
        internal_dns_name_label = "release-agent-level1"
      }
    }

    virtual_machine_settings = {
      linux = {
        name                            = "release-agent-level1"
        size                            = "Standard_F2s_v2"
        admin_username                  = "adminuser"
        disable_password_authentication = true

        # Value of the nic keys to attach the VM. The first one in the list is the default nic
        network_interface_keys = ["nic0"]

        os_disk = {
          name                 = "release-agent-level1-os"
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
            lz_key = "launchpad"
            managed_identity_keys = [
              "level1",
            ]
          }
        }


      }
    }

    virtual_machine_extensions = {
      devops_selfhosted_agent = {
        version           = 1
        agent_init_script = "devops_runtime_baremetal.sh"
        storage_account_blobs = [
          "devops_runtime_baremetal"
        ]
      }
    }

  }
}

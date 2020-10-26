
# Virtual machines
virtual_machines = {

  # Configuration to deploy a bastion host linux virtual machine
  vm_devops_level0 = {
    resource_group_key                   = "devops_region1"
    provision_vm_agent                   = true
    boot_diagnostics_storage_account_key = "bootdiag_region1"

    os_type = "linux"

    # the auto-generated ssh key in keyvault secret. Secret name being {VM name}-ssh-public and {VM name}-ssh-private
    lz_key       = "launchpad"
    keyvault_key = "devops_vm_rg1"

    # Define the number of networking cards to attach the virtual machine
    networking_interfaces = {
      nic0 = {
        # Value of the keys from networking.tfvars
        lz_key                  = "launchpad"
        vnet_key                = "devops_region1"
        subnet_key              = "release_agent_level0"
        name                    = "ptsg-5devopslevel0-Nic01"
        enable_ip_forwarding    = false
        internal_dns_name_label = "release-agent-level0"
      }
    }

    virtual_machine_settings = {
      linux = {
        name                            = "ptsg-5devopslevel0" //"release-agent-level0"
        size                            = "Standard_F2s_v2"
        admin_username                  = "adminuser"
        disable_password_authentication = true

        # Value of the nic keys to attach the VM. The first one in the list is the default nic
        network_interface_keys = ["nic0"]

        os_disk = {
          name                 = "ptsg-5devopslevel0-os"
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
          type   = "UserAssigned"
          lz_key = "launchpad"
          managed_identity_keys = [
            "level0",
          ]
        }


      }
    }

    virtual_machine_extensions = {
      devops_selfhosted_agent = {
        version             = 1
        agent_pool_key      = "level0"
        virtual_machine_key = "vm_devops_level0"
        agent_init_script   = "devops_runtime_baremetal.sh"
        storage_account_blobs = [
          "devops_runtime_baremetal"
        ]
      }
    }

  }

  # Configuration to deploy a bastion host linux virtual machine
  vm_devops_level1 = {
    resource_group_key                   = "devops_region1"
    provision_vm_agent                   = true
    boot_diagnostics_storage_account_key = "bootdiag_region1"

    os_type = "linux"

    # the auto-generated ssh key in keyvault secret. Secret name being {VM name}-ssh-public and {VM name}-ssh-private
    lz_key       = "launchpad"
    keyvault_key = "devops_vm_rg1"

    # Define the number of networking cards to attach the virtual machine
    networking_interfaces = {
      nic0 = {
        # Value of the keys from networking.tfvars
        lz_key                  = "launchpad"
        vnet_key                = "devops_region1"
        subnet_key              = "release_agent_level1"
        name                    = "ptsg-5devopslevel1-Nic01"
        enable_ip_forwarding    = false
        internal_dns_name_label = "release-agent-level1"
      }
    }

    virtual_machine_settings = {
      linux = {
        name                            = "ptsg-5devopslevel1"
        size                            = "Standard_F2s_v2"
        admin_username                  = "adminuser"
        disable_password_authentication = true

        # Value of the nic keys to attach the VM. The first one in the list is the default nic
        network_interface_keys = ["nic0"]

        os_disk = {
          name                 = "ptsg-5devopslevel1-os"
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
          type   = "UserAssigned"
          lz_key = "launchpad"
          managed_identity_keys = [
            "level1",
          ]
        }


      }
    }

    virtual_machine_extensions = {
      devops_selfhosted_agent = {
        version             = 1
        agent_pool_key      = "level1"
        virtual_machine_key = "vm_devops_level1"
        agent_init_script   = "devops_runtime_baremetal.sh"
        storage_account_blobs = [
          "devops_runtime_baremetal"
        ]
      }
    }

  }

  # Configuration to deploy a bastion host linux virtual machine
  vm_devops_level2 = {
    resource_group_key                   = "devops_region1"
    provision_vm_agent                   = true
    boot_diagnostics_storage_account_key = "bootdiag_region1"

    os_type = "linux"

    # the auto-generated ssh key in keyvault secret. Secret name being {VM name}-ssh-public and {VM name}-ssh-private
    lz_key       = "launchpad"
    keyvault_key = "devops_vm_rg1"

    # Define the number of networking cards to attach the virtual machine
    networking_interfaces = {
      nic0 = {
        # Value of the keys from networking.tfvars
        lz_key                  = "launchpad"
        vnet_key                = "devops_region1"
        subnet_key              = "release_agent_level2"
        name                    = "ptsg-5devopslevel2-Nic01"
        enable_ip_forwarding    = false
        internal_dns_name_label = "release-agent-level2"
      }
    }

    virtual_machine_settings = {
      linux = {
        name                            = "ptsg-5devopslevel2"
        size                            = "Standard_F2s_v2"
        admin_username                  = "adminuser"
        disable_password_authentication = true

        # Value of the nic keys to attach the VM. The first one in the list is the default nic
        network_interface_keys = ["nic0"]

        os_disk = {
          name                 = "ptsg-5devopslevel2-os"
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
          type       = "UserAssigned"
          lz_key     = "launchpad"
          output_key = "managed_identities"
          managed_identity_keys = [
            "level2",
          ]
        }


      }
    }



    virtual_machine_extensions = {
      devops_selfhosted_agent = {
        version             = 1
        agent_pool_key      = "level2"
        virtual_machine_key = "vm_devops_level2"
        agent_init_script   = "devops_runtime_baremetal.sh"
        storage_account_blobs = [
          "devops_runtime_baremetal"
        ]
      }
    }

  }

  # Configuration to deploy a bastion host linux virtual machine
  vm_devops_level3 = {
    resource_group_key                   = "devops_region1"
    provision_vm_agent                   = true
    boot_diagnostics_storage_account_key = "bootdiag_region1"

    os_type = "linux"

    # the auto-generated ssh key in keyvault secret. Secret name being {VM name}-ssh-public and {VM name}-ssh-private
    lz_key       = "launchpad"
    keyvault_key = "devops_vm_rg1"

    # Define the number of networking cards to attach the virtual machine
    networking_interfaces = {
      nic0 = {
        # Value of the keys from networking.tfvars
        lz_key                  = "launchpad"
        vnet_key                = "devops_region1"
        subnet_key              = "release_agent_level3"
        name                    = "ptsg-5devopslevel3-Nic01"
        enable_ip_forwarding    = false
        internal_dns_name_label = "release-agent-level3"
      }
    }

    virtual_machine_settings = {
      linux = {
        name                            = "ptsg-5devopslevel3"
        size                            = "Standard_F2s_v2"
        admin_username                  = "adminuser"
        disable_password_authentication = true

        # Value of the nic keys to attach the VM. The first one in the list is the default nic
        network_interface_keys = ["nic0"]

        os_disk = {
          name                 = "ptsg-5devopslevel3-os"
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
          type       = "UserAssigned"
          lz_key     = "launchpad"
          output_key = "managed_identities"
          managed_identity_keys = [
            "level3",
          ]
        }


      }
    }

    virtual_machine_extensions = {
      devops_selfhosted_agent = {
        version             = 1
        agent_pool_key      = "level3"
        virtual_machine_key = "vm_devops_level3"
        agent_init_script   = "devops_runtime_baremetal.sh"
        storage_account_blobs = [
          "devops_runtime_baremetal"
        ]
      }
    }

  }

  # Configuration to deploy a bastion host linux virtual machine
  vm_devops_level4 = {
    resource_group_key                   = "devops_region1"
    provision_vm_agent                   = true
    boot_diagnostics_storage_account_key = "bootdiag_region1"

    os_type = "linux"

    # the auto-generated ssh key in keyvault secret. Secret name being {VM name}-ssh-public and {VM name}-ssh-private
    # You can retrieve the key
    # 
    #  az keyvault secret download \
    #    --vault-name lsqy-kv-vmsecrets \
    #    --name lsqy-vm-release-agent-level4-ssh-private-key \
    #    --file ~/.ssh/lsqy-vm-release-agent-level4.prv && \
    #  sudo chmod 600 ~/.ssh/lsqy-vm-release-agent-level4.prv
    #
    #  ssh -i ~/.ssh/lsqy-vm-release-agent-level4.prv adminuser@10.100.100.76
    #
    lz_key       = "launchpad"
    keyvault_key = "devops_vm_rg1"

    # Define the number of networking cards to attach the virtual machine
    networking_interfaces = {
      nic0 = {
        # Value of the keys from networking.tfvars
        lz_key                  = "launchpad"
        vnet_key                = "devops_region1"
        subnet_key              = "release_agent_level4"
        name                    = "ptsg-5devopslevel4-Nic01"
        enable_ip_forwarding    = false
        internal_dns_name_label = "release-agent-level4"
      }
    }

    virtual_machine_settings = {
      linux = {
        name                            = "ptsg-5devopslevel4"
        size                            = "Standard_F2s_v2"
        admin_username                  = "adminuser"
        disable_password_authentication = true

        # Value of the nic keys to attach the VM. The first one in the list is the default nic
        network_interface_keys = ["nic0"]

        os_disk = {
          name                 = "ptsg-5devopslevel4-os"
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
          type   = "UserAssigned"
          lz_key = "launchpad"
          managed_identity_keys = [
            "level4",
          ]
        }


      }
    }

    virtual_machine_extensions = {
      devops_selfhosted_agent = {
        version             = 1
        agent_pool_key      = "level4"
        virtual_machine_key = "vm_devops_level4"
        agent_init_script   = "devops_runtime_baremetal.sh"
        storage_account_blobs = [
          "devops_runtime_baremetal"
        ]
      }
    }

  }
}

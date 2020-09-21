
resource_groups = {
  devops_region1 = {
    name = "devops-agents-rg1"
  }
}

# Virtual machines
virtual_machines = {

  # Configuration to deploy a bastion host linux virtual machine
  vm_devops_level0 = {
    resource_group_key                   = "devops_region1"
    provision_vm_agent                   = true
    boot_diagnostics_storage_account_key = "bootdiag_region1"

    os_type = "linux"

    # the auto-generated ssh key in keyvault secret. Secret name being {VM name}-ssh-public and {VM name}-ssh-private
    keyvault_key = "devops_vm_rg1"

    # Define the number of networking cards to attach the virtual machine
    networking_interfaces = {
      nic0 = {
        # Value of the keys from networking.tfvars
        networking = {
          remote_tfstate = {
            tfstate_key = "launchpad"
            output_key  = "vnets"
            lz_key      = "launchpad"
            vnet_key    = "devops_region1"
            subnet_key  = "release_agent_level0"
          }
        }
        name                    = "0-release-agent-level0"
        enable_ip_forwarding    = false
        internal_dns_name_label = "release-agent-level0"
      }
    }

    virtual_machine_settings = {
      linux = {
        name                            = "release-agent-level0"
        size                            = "Standard_F2"
        admin_username                  = "adminuser"
        disable_password_authentication = true
        custom_data                     = "scripts/cloud-init-install-rover-tools.config"

        # Value of the nic keys to attach the VM. The first one in the list is the default nic
        network_interface_keys = ["nic0"]

        os_disk = {
          name                 = "level0-os"
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
          remote_tfstate = {
            tfstate_key = "launchpad"
            output_key  = "managed_identities"
          }
          managed_identity_keys = [
            "level0",
          ]
        }


      }
    }



    virtual_machine_extensions = {
      devops_selfhosted_agent = {
        version             = 1
        virtual_machine_key = "vm_devops_level0"
        agent_init_script   = "devops_runtime_baremetal.sh"
        fileUris = {
          azure_devops_script = {
            storage_account_key = "scripts_region1"
            container_key       = "scripts"
            storage_blob_keys   = ["azure_devops_script"]
          }
        }
      }
    }

  }
}



storage_accounts = {
  # Is used to store the azure devops deployment script to setup the Azure Devops Selfhosted agents
  scripts_region1 = {
    name                     = "scripts"
    resource_group_key       = "devops_region1"
    account_kind             = "StorageV2"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    allow_blob_public_access = true

    containers = {
      scripts = {
        name                  = "deployment-scripts"
        container_access_type = "blob"

        # Attributes available https://www.terraform.io/docs/providers/azurerm/r/storage_blob.html
        storage_blobs = {
          azure_devops_script = {
            name   = "devops_runtime_baremetal.sh"
            source = "scripts/devops_runtime_baremetal.sh"
          }
        }

      }
    }
  }
}

diagnostic_storage_accounts = {
  # Stores boot diagnostic for region1
  bootdiag_region1 = {
    name                     = "bootrg1"
    resource_group_key       = "devops_region1"
    account_kind             = "StorageV2"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    access_tier              = "Cool"
  }
}



keyvaults = {
  devops_vm_rg1 = {
    name               = "vmsecrets"
    resource_group_key = "devops_region1"
    sku_name           = "standard"
  }
}

keyvault_access_policies = {
  # A maximum of 16 access policies per keyvault
  devops_vm_rg1 = {
    logged_in_user = {
      secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
    }
    logged_in_aad_app = {
      secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
    }
  }
}

azure_devops = {

  rover_version = "aztfmod/roveralpha:2009.040557"
  url           = "https://dev.azure.com/dapr-landingzone"
  project       = "caf-devops"

  pipeline_level = "level0"

  pats = {
    admin = {
      lz_key       = "launchpad"
      secret_name  = "azdo-pat-admin"
      keyvault_key = "secrets"
    }
    agent = {
      lz_key       = "launchpad"
      secret_name  = "azdo-pat-agent"
      keyvault_key = "secrets"
    }
  }


  agent_pool = {
    name              = "caf-sandpit-level0"
    auto_provision    = true
    num_agents        = 4
    agent_name_prefix = "agent"
  }

}
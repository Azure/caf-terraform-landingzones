
convention = "cafrandom"

vm_object = {   

    agent_init_script   = "./scripts/devops_runtime.sh"

    resource_group_key = "devops"
    
    name = "devopslevel0"
    computer_name = "devopslevel0"
    
    subnet_name = "level0"
    
    admin_username = "devopsadmin"
    


    # vm_size = "Standard_B1s"
    vm_size = "Standard_F4s_v2"

    os = "Linux"

    save_ssh_private_key_pem = true

    source_image_reference = {
        publisher = "OpenLogic"
        offer     = "Centos"
        sku       = "7.6"
        version   = "latest"
    }


    os_disk = {
        caching                     = "ReadWrite"
        storage_account_type        = "Standard_LRS"
        disk_size_gb                = 128
    }

    availability_set = {
        name                                = "avs"
        platform_update_domain_count        = 5
        platform_fault_domain_count         = 2
        tags                                = {}
    }
}


azure_devops = {

    url     = "https://dev.azure.com/azure-terraform/"

    agent_pool = {
        name                = "test-level0"
        auto_provision      = true                  # Auto pro
        num_agents          = 3
        agent_name_prefix   = "agent"
    }

}





resource "azurecaf_naming_convention" "nic" {
  name          = "${var.vm_object.name}-nic"
  prefix        = local.prefix
  resource_type = "azurerm_network_interface"
  convention    = lookup(var.vm_object, "convention", local.global_settings.convention)
}


resource "azurerm_network_interface" "nic" {
  name                = azurecaf_naming_convention.nic.result
  location            = lookup(var.vm_object, "location", local.global_settings.default_location)
  resource_group_name = local.resource_groups[var.vm_object.resource_group_key].name

  ip_configuration {
    name                          = local.networking.subnet_ids_map[var.vm_object.subnet_key].name
    subnet_id                     = local.networking.subnet_ids_map[var.vm_object.subnet_key].id
    private_ip_address_allocation = "Dynamic"
  }
}

# Name of the VM in the Azure Control Plane
resource "azurecaf_naming_convention" "vm" {
  name          = var.vm_object.name
  prefix        = local.prefix
  resource_type = "vml"
  convention    = lookup(var.vm_object, "convention", local.global_settings.convention)
}

# Name of the Linux computer name
resource "azurecaf_naming_convention" "computer_name" {
  name          = var.vm_object.computer_name
  prefix        = local.prefix
  resource_type = "vml"
  convention    = lookup(var.vm_object, "convention", local.global_settings.convention)
}

resource "azurerm_linux_virtual_machine" "vm" {
  depends_on = [azurerm_network_interface.nic, azurerm_availability_set.avs]

  name                  = azurecaf_naming_convention.vm.result
  location              = lookup(var.vm_object, "location", local.global_settings.default_location)
  resource_group_name   = local.resource_groups[var.vm_object.resource_group_key].name
  size                  = var.vm_object.vm_size
  admin_username        = var.vm_object.admin_username
  computer_name         = azurecaf_naming_convention.computer_name.result
  zone                  = lookup(var.vm_object, "zone", null)

  availability_set_id   = lookup(var.vm_object, "availability_set", null) == null ? 0 : azurerm_availability_set.avs.0.id

  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  admin_ssh_key {
    username   = var.vm_object.admin_username
    public_key = local.public_key
  }

  os_disk {
    name                        = lookup(var.vm_object.os_disk, "name", "${var.vm_object.name}-os_disk")
    caching                     = lookup(var.vm_object.os_disk, "caching", "ReadWrite")
    storage_account_type        = lookup(var.vm_object.os_disk, "storage_account_type", "Standard_LRS")
    disk_encryption_set_id      = var.disk_encryption_set_id == null ? null : var.disk_encryption_set_id 
    disk_size_gb                = lookup(var.vm_object.os_disk, "disk_size_gb", null)
    write_accelerator_enabled   = lookup(var.vm_object.os_disk, "write_accelerator_enabled", false)

    dynamic "diff_disk_settings" {

        for_each =  lookup(var.vm_object.os_disk, "diff_disk_settings", null) == null ? [] : [1]

        content {
            option = lookup(var.vm_object.os_disk.diff_disk_settings, "option", "Local")
        }
    }
  }

  boot_diagnostics {
      storage_account_uri = azurerm_storage_account.devops.primary_blob_endpoint
  }

  source_image_reference {
    publisher = lookup(var.vm_object.source_image_reference, "publisher", null)
    offer     = lookup(var.vm_object.source_image_reference, "offer", null)
    sku       = lookup(var.vm_object.source_image_reference, "sku", null)
    version   = lookup(var.vm_object.source_image_reference, "version", "latest")
  }

  identity {
      type = "UserAssigned"

      identity_ids = [
        azurerm_user_assigned_identity.user_msi.id
      ]
  }

}


resource "tls_private_key" "ssh" {
  count = var.private_key_pem_file == "" ? 1 : 0

  algorithm   = "RSA"
  rsa_bits    = 4096
}

locals {
  public_key = tls_private_key.ssh.0.public_key_openssh
}


resource "azurerm_user_assigned_identity" "user_msi" {
  location            = lookup(var.vm_object, "location", local.global_settings.default_location)
  resource_group_name = local.resource_groups[var.vm_object.resource_group_key].name

  name = "release-agent-${var.azure_devops.pipeline_level}"
}

# To be refactored based on configuration
resource "azurerm_role_assignment" "contributor" {
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.user_msi.principal_id
}
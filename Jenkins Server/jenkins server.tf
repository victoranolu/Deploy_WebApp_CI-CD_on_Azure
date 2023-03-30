resource "azurerm_resource_group" "voa-rg" {
  name     = var.poor_rg
  location = var.poor_loc
}

resource "azurerm_virtual_network" "v_net" {
  name                = var.virt
  address_space       = var.add_space
  location            = azurerm_resource_group.voa-rg.location
  resource_group_name = azurerm_resource_group.voa-rg.name
}

resource "azurerm_subnet" "v_sub" {
  name                 = var.sub
  resource_group_name  = azurerm_resource_group.voa-rg.name
  virtual_network_name = azurerm_virtual_network.v_net.name
  address_prefixes     = var.pre_add_space
}

resource "azurerm_network_interface" "nic" {
  name                = var.nic
  location            = azurerm_resource_group.voa-rg.location
  resource_group_name = azurerm_resource_group.voa-rg.name

  ip_configuration {
    name                          = var.IP_config_name
    subnet_id                     = azurerm_subnet.v_sub.id
    private_ip_address_allocation = var.IP_allocation
  }
}

resource "azurerm_linux_virtual_machine" "linux" {
  name                = var.linux_name
  resource_group_name = azurerm_resource_group.voa-rg.name
  location            = azurerm_resource_group.voa-rg.location
  size                = var.size
  admin_username      = var.admin
  user_data           = file("jenkins-install.sh")
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  admin_ssh_key {
    username   = var.admin
    public_key = file("~/.ssh/pmakey.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "22.04-LTS"
    version   = "latest"
  }
}
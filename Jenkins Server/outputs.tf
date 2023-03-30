output "ubuntu_server_pub_ip" {
  value       = azurerm_linux_virtual_machine.linux.public_ip_address
  description = "Public IP address for Jenkins server"
}

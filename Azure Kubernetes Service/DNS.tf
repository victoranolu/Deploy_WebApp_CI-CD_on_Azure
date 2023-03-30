# Setting DNS record to be used to route the apps deployed in AKS
resource "azurerm_dns_zone" "dns" {
  name                = var.dns_name
  resource_group_name = azurerm_resource_group.pma-rg.name
}

resource "azurerm_public_ip" "Pub-IP" {
  name                = var.pub_ip
  location            = azurerm_resource_group.pma-rg.location
  resource_group_name = azurerm_resource_group.pma-rg.name
  allocation_method   = var.pub_ip_allocation
  ip_version          = "IPv4"
}

resource "azurerm_dns_a_record" "domain-name" {
  name                = var.dns_rec_name
  zone_name           = azurerm_dns_zone.dns.name
  resource_group_name = azurerm_resource_group.pma-rg.name
  ttl                 = var.ttl
  target_resource_id  = azurerm_public_ip.Pub-IP.id
}

resource "azurerm_dns_a_record" "web-domain-name" {
  name                = var.web
  zone_name           = azurerm_dns_zone.dns.name
  resource_group_name = azurerm_resource_group.pma-rg.name
  ttl                 = var.ttl
  target_resource_id  = azurerm_public_ip.Pub-IP.id
}
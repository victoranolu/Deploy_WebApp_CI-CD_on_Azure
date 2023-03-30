output "ak8s_id" {
  value       = azurerm_kubernetes_cluster.ak8s.id
  description = "Kubernetes id"
}

output "ak8s_fpdn" {
  value = azurerm_kubernetes_cluster.ak8s.fqdn
}

output "ak8s_node_rg" {
  value = azurerm_kubernetes_cluster.ak8s.node_resource_group
}


output "acr_id" {
  value = azurerm_container_registry.acr.id
}

output "acr_login_server" {
  value = azurerm_container_registry.acr.login_server
}

resource "local_file" "kubeconfig" {
  depends_on = [azurerm_kubernetes_cluster.ak8s]
  filename   = "kubeconfig"
  content    = azurerm_kubernetes_cluster.ak8s.kube_config_raw
}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.ak8s.kube_config.0.client_certificate
  sensitive = true
}
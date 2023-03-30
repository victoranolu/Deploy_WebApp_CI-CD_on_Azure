# Creating the resource group for the Azure Kubernetes Service (AKS)
resource "azurerm_resource_group" "pma-rg" {
  name     = var.resource_group_name
  location = var.location
}

# Using the default role assignment for the Azure Container Registry to connect to AKS
resource "azurerm_role_assignment" "ars" {
  principal_id                     = azurerm_kubernetes_cluster.ak8s.kubelet_identity[0].object_id
  role_definition_name             = var.role_definition_name
  scope                            = azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
}

# Creating an Azure Container Registry to store and manage container images for the AKS to run with but there wold not any container in it
resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.pma-rg.name
  location            = azurerm_resource_group.pma-rg.location
  sku                 = var.acr_sku
  admin_enabled       = false
}

# The AKS configuration having a network profile and add-ons for Ingress and load balancer to manage the different apps deployment 
resource "azurerm_kubernetes_cluster" "ak8s" {
  name                              = var.ak8s_name
  location                          = azurerm_resource_group.pma-rg.location
  resource_group_name               = azurerm_resource_group.pma-rg.name
  dns_prefix                        = var.dns_prefix
  role_based_access_control_enabled = true
  azure_policy_enabled              = true

  default_node_pool {
    name       = var.node_name
    node_count = var.node_count
    vm_size    = var.node_vm_size
  }

  identity {
    type = "SystemAssigned"
  }

  oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.log_anal.id
  }


  network_profile {
    load_balancer_sku = "standard"
    network_plugin    = "kubenet"
  }

  tags = {
    Environment = "Dev"
  }
}

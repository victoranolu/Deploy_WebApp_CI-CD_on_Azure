# Setting Log analytics and workspace for AKS
resource "azurerm_log_analytics_workspace" "log_anal" {
  name                = var.log_workspace
  location            = azurerm_resource_group.pma-rg.location
  resource_group_name = azurerm_resource_group.pma-rg.name
  sku                 = var.log_analytics_sku
}

resource "azurerm_log_analytics_solution" "log-anal-sol" {
  solution_name         = var.log_solution_name
  location              = azurerm_resource_group.pma-rg.location
  resource_group_name   = azurerm_resource_group.pma-rg.name
  workspace_resource_id = azurerm_log_analytics_workspace.log_anal.id
  workspace_name        = azurerm_log_analytics_workspace.log_anal.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ContainerInsights"
  }
}

resource "azurerm_log_analytics_cluster" "log_clust" {
  name                = var.log_clust
  resource_group_name = azurerm_resource_group.pma-rg.name
  location            = azurerm_resource_group.pma-rg.location

  identity {
    type = "SystemAssigned"
  }
}
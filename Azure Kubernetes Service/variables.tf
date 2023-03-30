variable "resource_group_name" {
  type        = string
  description = "Name of resource group"
}

variable "location" {
  type        = string
  description = "Location for all the resource infrastructure"
}

variable "role_definition_name" {
  type        = string
  description = "Azure role definition name"
}

variable "acr_name" {
  type        = string
  description = "Azure Container Registry name"
}

variable "acr_sku" {
  type        = string
  description = "ACR sku type"
}

variable "ak8s_name" {
  type        = string
  description = "Azure Kubernetes Service name"
}

variable "dns_prefix" {
  type        = string
  description = "DNS prefix"
}

variable "node_name" {
  type        = string
  description = "AKS node name"
}

variable "node_count" {
  type        = number
  description = "AKS node number"
}

variable "node_vm_size" {
  type        = string
  description = "AKS default Virtual Machine"
}

variable "log_workspace" {
  type        = string
  description = "Log analytics workspace name"
}

variable "log_analytics_sku" {
  type        = string
  description = "AKS log analytics sku"
}

variable "log_solution_name" {
  type        = string
  description = "Log analytics solution name"
}

variable "log_clust" {
  type        = string
  description = "Log analytic cluster name"
}

variable "dns_name" {
  type        = string
  description = "Domain Name"
}

variable "dns_rec_name" {
  type        = string
  description = "DNS A record name"
}

variable "ttl" {
  type        = number
  description = "Time to live"
}

variable "pub_ip" {
  type        = string
  description = "Public IP name"
}

variable "pub_ip_allocation" {
  type        = string
  description = "Public IP allocation"
}

variable "web" {
  type        = string
  description = "name of the second A-record for the second application to be deployed"
}

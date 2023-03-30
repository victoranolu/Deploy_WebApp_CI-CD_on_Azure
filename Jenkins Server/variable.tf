variable "poor_rg" {
  type        = string
  description = "Jenkins server resource group"
}

variable "poor_loc" {
  type        = string
  description = "Jenkins server location"
}

variable "virt" {
  type        = string
  description = "Virtual network"
}

variable "sub" {
  type        = string
  description = "subnet name"
}


variable "add_space" {
  type        = map(any)
  description = "virtual address space"
}

variable "pre_add_space" {
  type        = map(any)
  description = "subnet IP range"
}

variable "nic" {
  type        = string
  description = "Network Interface name"
}

variable "IP_config_name" {
  type        = string
  description = "Network Interface IP config name"
}

variable "IP_allocation" {
  type        = string
  description = "Ip allocation type"
}

variable "linux_name" {
  type        = string
  description = "Jenkins server name"
}

variable "size" {
  type        = string
  description = "Linux size of CPU"
}

variable "admin" {
  type        = string
  description = "login admin"
}

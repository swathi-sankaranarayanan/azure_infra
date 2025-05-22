variable "address_virtual_network" {
  type = list(string)
  description = "address for the virtual network"
}

variable "address_subnet" {
  type = list(string)
  description = "address for the virtual network"
}

variable "port_range" {
  type = list(string)
  description = "source port ranges allowed access to VM"
}

variable "name_prefix" {
  type = string
  description = "Name prefix of the resources"
}

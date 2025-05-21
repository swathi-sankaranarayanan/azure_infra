resource "azurerm_resource_group" "rg-swathi" {
  name     = var.resource_group
  location = "France Central"
}

resource "azurerm_network_security_group" "swathi-sec-group" {
  name                = "swathi-security-group"
  location            = azurerm_resource_group.rg-swathi.location
  resource_group_name = azurerm_resource_group.rg-swathi.name
}

resource "azurerm_network_security_rule" "swathi-sec-rule" {
for_each = toset(var.port_range)
  name                        = "port-${each.key}"
  priority                    = 100+each.key
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = each.key
  destination_port_range      = each.key
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg-swathi.name
  network_security_group_name = azurerm_network_security_group.swathi-sec-group.name
}

resource "azurerm_virtual_network" "swathi-vm" {
  name                = "swathi-vm"
  location            = azurerm_resource_group.rg-swathi.location
  resource_group_name = azurerm_resource_group.rg-swathi.name
  address_space       = var.address_virtual_network
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  tags = {
  environment = "development"
  }
}

resource "azurerm_subnet" "swathi-subnet" {
  name                 = "swathi-subnet"
  resource_group_name  = azurerm_resource_group.rg-swathi.name
  virtual_network_name = azurerm_virtual_network.swathi-vm.name
  address_prefixes     = var.address_subnet
}

resource "azurerm_subnet_network_security_group_association" "swathi-sec-association" {
  subnet_id                 = azurerm_subnet.swathi-subnet.id
  network_security_group_id = azurerm_network_security_group.swathi-sec-group.id
}

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.29.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features{}
  subscription_id="537bb5af-974a-40ed-9493-5761b69e345a"
}

module "create_resources" {
  source = "./modules/network"

  name_prefix = var.name
  address_virtual_network = ["10.0.0.0/16"]
  address_subnet = ["10.0.1.0/24"]
  port_range = ["80", "443"]
}
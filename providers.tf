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
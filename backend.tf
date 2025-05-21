terraform {
  backend "azurerm" {
    resource_group_name  = "rg-swathi-storeacc"
    storage_account_name = "swathistoreacc"
    container_name       = "swathi-tfstate"
    key                  = "terraform.tfstate"
  }
}
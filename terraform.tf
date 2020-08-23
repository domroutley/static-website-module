terraform {
  required_version = ">= 0.13"
  backend "azurerm" {
    resource_group_name  = "tf-states-rg"
    storage_account_name = "tfstatesdom"
    container_name       = "tfstate"
    key                  = "tfstate"
  }
}

provider "azurerm" {
  version = "=2.20.0"
  features {}
}

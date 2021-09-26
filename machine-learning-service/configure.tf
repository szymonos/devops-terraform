terraform {
  backend "azurerm" {
    subscription_id      = "026b5895-980a-4fdb-a8fd-f59fe3e04231"
    resource_group_name  = "RG-Infra-WEU"
    storage_account_name = "stacdevopstf"
    container_name       = "terraform-state"
    key                  = "res/ml.tfstate"
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
  required_version = "~>1.0"
}

# *PROVIDERS*
provider "azurerm" {
  features {}
  skip_provider_registration = true
  subscription_id            = var.subscription_id
}

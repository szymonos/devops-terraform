terraform {
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

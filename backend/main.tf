terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      # version = "~>2.48"
    }
  }
}

########################################################################
# *VARIABLES*
########################################################################
variable "location" {
  type    = string
  default = "westeurope"
}

variable "rg_devops_name" {
  type    = string
  default = "RG-Infra-WEU"
}

variable "sa_devops_name" {
  type    = string
  default = "stacdevopstf"
}

##################################################################################
# *PROVIDERS*
##################################################################################
provider "azurerm" {
  subscription_id = "026b5895-980a-4fdb-a8fd-f59fe3e04231" # SZYMONOS-MSDN
  features {}
}

##################################################################################
# *LOCALS*
##################################################################################
locals {
  common_tags = {
    ENV = "PROD"
  }
}

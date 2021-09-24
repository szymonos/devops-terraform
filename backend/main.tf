# *LOCALS*
locals {
  common_tags = {
    ENV = "PROD"
  }
}

# *RESOURCES*
resource "azurerm_resource_group" "default" {
  name     = var.resource_group
  location = var.location
  tags     = local.common_tags
}

resource "azurerm_storage_account" "default" {
  name                     = var.storage_account
  location                 = var.location
  resource_group_name      = azurerm_resource_group.default.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"

  tags = local.common_tags
}

resource "azurerm_storage_container" "default" {
  name                 = var.container
  storage_account_name = azurerm_storage_account.default.name
}

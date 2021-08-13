##################################################################################
# *RESOURCES*
##################################################################################
resource "azurerm_resource_group" "devops" {
  name     = var.rg_devops_name
  location = var.location
  tags     = local.common_tags
}

resource "azurerm_storage_account" "devops" {
  name                     = var.sa_devops_name
  location                 = var.location
  resource_group_name      = azurerm_resource_group.devops.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"

  tags = local.common_tags
}

resource "azurerm_storage_container" "state" {
  name                 = "terraform-state"
  storage_account_name = azurerm_storage_account.devops.name
}

##################################################################################
# *OUTPUT*
##################################################################################
output "rg_name_out" {
  value = azurerm_resource_group.devops.name
}
output "sa_name_out" {
  value = azurerm_storage_account.devops.name
}
output "sc_name_out" {
  value = azurerm_storage_container.state.name
}

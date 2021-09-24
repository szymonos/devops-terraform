# *OUTPUTS*
output "rg_name_out" {
  value = azurerm_resource_group.default.name
}

output "sa_name_out" {
  value = azurerm_storage_account.default.name
}

output "sc_name_out" {
  value = azurerm_storage_container.default.name
}

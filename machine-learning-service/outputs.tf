# *OUTPUTS*
output id {
  description = "ID of the machine learning workspace created"
  value       = azurerm_machine_learning_workspace.default.id
}

output application_insights_id {
  description = "Id for the application insights that is created"
  value       = azurerm_application_insights.default.id
}

output storage_account_id {
  description = "Id for the storage account that is created"
  value       = azurerm_storage_account.default.id
}

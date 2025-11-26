output "storage_account_id" {
  description = "ID of the storage account"
  value       = azurerm_storage_account.datalake.id
}

output "storage_account_name" {
  description = "Name of the storage account"
  value       = azurerm_storage_account.datalake.name
}

output "storage_account_access_key" {
  description = "Storage account access key"
  value       = azurerm_storage_account.datalake.primary_access_key
  sensitive   = true
}

output "primary_blob_endpoint" {
  description = "Primary blob endpoint of the storage account"
  value       = azurerm_storage_account.datalake.primary_blob_endpoint
}

output "container_names" {
  description = "Names of created containers"
  value       = [for container in azurerm_storage_container.containers : container.name]
}

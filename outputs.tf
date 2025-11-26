# Resource Group Outputs
output "resource_group_id" {
  description = "ID of the created resource group"
  value       = azurerm_resource_group.main.id
}

output "resource_group_name" {
  description = "Name of the created resource group"
  value       = azurerm_resource_group.main.name
}

# Storage Account Outputs
output "storage_account_id" {
  description = "ID of the storage account"
  value       = module.storage_account_datalake.storage_account_id
}

output "storage_account_name" {
  description = "Name of the storage account"
  value       = module.storage_account_datalake.storage_account_name
}

output "storage_account_primary_blob_endpoint" {
  description = "Primary blob endpoint of the storage account"
  value       = module.storage_account_datalake.primary_blob_endpoint
}

# Key Vault Outputs
output "key_vault_id" {
  description = "ID of the Key Vault"
  value       = module.key_vault.key_vault_id
}

output "key_vault_uri" {
  description = "URI of the Key Vault"
  value       = module.key_vault.key_vault_uri
}

# Event Hub Outputs
output "event_hub_namespace_id" {
  description = "ID of the Event Hub namespace"
  value       = module.event_hub.event_hub_namespace_id
}

output "event_hub_namespace_connection_string" {
  description = "Connection string for Event Hub namespace"
  value       = module.event_hub.event_hub_namespace_connection_string
  sensitive   = true
}

# Data Factory Outputs
output "data_factory_id" {
  description = "ID of the Data Factory"
  value       = module.data_factory.data_factory_id
}

output "data_factory_name" {
  description = "Name of the Data Factory"
  value       = module.data_factory.data_factory_name
}

# Databricks Outputs
output "databricks_workspace_id" {
  description = "ID of the Databricks workspace"
  value       = module.databricks.workspace_id
}

output "databricks_workspace_url" {
  description = "URL of the Databricks workspace"
  value       = module.databricks.workspace_url
}

# Synapse Outputs
output "synapse_workspace_id" {
  description = "ID of the Synapse workspace"
  value       = module.synapse.synapse_workspace_id
}

output "synapse_workspace_connectivity_endpoints" {
  description = "Connectivity endpoints for Synapse workspace"
  value       = module.synapse.synapse_workspace_connectivity_endpoints
}

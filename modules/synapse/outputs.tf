output "synapse_workspace_id" {
  description = "ID of the Synapse workspace"
  value       = azurerm_synapse_workspace.main.id
}

output "synapse_workspace_name" {
  description = "Name of the Synapse workspace"
  value       = azurerm_synapse_workspace.main.name
}

output "synapse_workspace_connectivity_endpoints" {
  description = "Connectivity endpoints for the Synapse workspace"
  value       = azurerm_synapse_workspace.main.connectivity_endpoints
}

output "synapse_sql_pool_id" {
  description = "ID of the SQL pool"
  value       = azurerm_synapse_sql_pool.main.id
}

output "synapse_spark_pool_id" {
  description = "ID of the Spark pool"
  value       = azurerm_synapse_spark_pool.main.id
}

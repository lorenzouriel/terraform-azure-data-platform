output "event_hub_namespace_id" {
  description = "ID of the Event Hub namespace"
  value       = azurerm_eventhub_namespace.main.id
}

output "event_hub_namespace_name" {
  description = "Name of the Event Hub namespace"
  value       = azurerm_eventhub_namespace.main.name
}

output "event_hub_namespace_connection_string" {
  description = "Connection string for the Event Hub namespace"
  value       = azurerm_eventhub_namespace_authorization_rule.main.primary_connection_string
  sensitive   = true
}

output "event_hub_ids" {
  description = "IDs of created Event Hubs"
  value       = { for hub in azurerm_eventhub.main : hub.name => hub.id }
}

output "event_hub_names" {
  description = "Names of created Event Hubs"
  value       = [for hub in azurerm_eventhub.main : hub.name]
}

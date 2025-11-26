resource "azurerm_eventhub_namespace" "main" {
  name                = var.event_hub_namespace_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  capacity            = 1

  tags = var.tags
}

# Create Event Hubs within the namespace
resource "azurerm_eventhub" "main" {
  for_each = toset(var.event_hub_names)

  name                = each.value
  namespace_name      = azurerm_eventhub_namespace.main.name
  resource_group_name = var.resource_group_name
  partition_count     = 4
  message_retention   = 1
}

# Create authorization rule for the namespace
resource "azurerm_eventhub_namespace_authorization_rule" "main" {
  name                = "${var.event_hub_namespace_name}-auth-rule"
  namespace_name      = azurerm_eventhub_namespace.main.name
  resource_group_name = var.resource_group_name
  listen              = true
  send                = true
  manage              = true
}

# Create authorization rules for each Event Hub
resource "azurerm_eventhub_authorization_rule" "main" {
  for_each = azurerm_eventhub.main

  name                = "${each.value.name}-auth-rule"
  namespace_name      = azurerm_eventhub_namespace.main.name
  eventhub_name       = each.value.name
  resource_group_name = var.resource_group_name
  listen              = true
  send                = true
  manage              = false
}

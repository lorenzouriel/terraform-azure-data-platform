resource "azurerm_data_factory" "main" {
  name                = var.data_factory_name
  location            = var.location
  resource_group_name = var.resource_group_name

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

# Linked Service for Storage Account
resource "azurerm_data_factory_linked_service_azure_blob_storage" "storage" {
  name                 = "${var.data_factory_name}-storage-linked-service"
  data_factory_id      = azurerm_data_factory.main.id
  use_managed_identity = true
  service_endpoint     = "https://${var.storage_account_name}.blob.core.windows.net"
}

# Linked Service for Key Vault
resource "azurerm_data_factory_linked_service_key_vault" "keyvault" {
  name            = "${var.data_factory_name}-keyvault-linked-service"
  data_factory_id = azurerm_data_factory.main.id
  key_vault_id    = var.key_vault_id
}

# Grant Data Factory managed identity access to Key Vault
resource "azurerm_key_vault_access_policy" "data_factory" {
  key_vault_id = var.key_vault_id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_data_factory.main.identity[0].principal_id

  secret_permissions = [
    "Get",
    "List",
  ]
}

# Data source to get current Azure client configuration
data "azurerm_client_config" "current" {}

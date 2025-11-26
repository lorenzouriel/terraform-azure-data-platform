resource "azurerm_storage_account" "datalake" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  is_hns_enabled           = true # Enable hierarchical namespace for Data Lake Gen2

  access_tier = "Hot"

  tags = var.tags
}

# Create containers in the storage account
resource "azurerm_storage_container" "containers" {
  for_each = toset(var.container_names)

  name                  = each.value
  storage_account_name  = azurerm_storage_account.datalake.name
  container_access_type = "private"
}

# Storage account network rules
resource "azurerm_storage_account_network_rules" "main" {
  storage_account_id = azurerm_storage_account.datalake.id

  default_action = "Deny"
  bypass         = ["AzureServices"]
}

resource "azurerm_synapse_workspace" "main" {
  name                                 = var.synapse_workspace_name
  resource_group_name                  = var.resource_group_name
  location                             = var.location
  storage_data_lake_gen2_filesystem_id = var.synapse_filesystem_id
  sql_administrator_login              = var.synapse_sql_admin_login
  sql_administrator_login_password     = var.synapse_sql_admin_password

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

# Synapse SQL Pool
resource "azurerm_synapse_sql_pool" "main" {
  storage_account_type      = "LRS"
  name                      = "sqlpool"
  synapse_workspace_id      = azurerm_synapse_workspace.main.id
  sku_name                  = "DW100c"
  create_mode               = "Default"
  geo_backup_policy_enabled = false

  tags = var.tags
}

# Synapse Firewall Rule for Azure Services
resource "azurerm_synapse_firewall_rule" "azure_services" {
  name                 = "AllowAzureServices"
  synapse_workspace_id = azurerm_synapse_workspace.main.id
  start_ip_address     = "0.0.0.0"
  end_ip_address       = "0.0.0.0"
}

# Synapse Spark Pool
resource "azurerm_synapse_spark_pool" "main" {
  name                 = "sparkpool"
  spark_version        = "3.4"
  synapse_workspace_id = azurerm_synapse_workspace.main.id
  node_size_family     = "MemoryOptimized"
  node_size            = "Medium"
  cache_size           = 100

  auto_scale {
    max_node_count = 10
    min_node_count = 3
  }

  auto_pause {
    delay_in_minutes = 15
  }

  tags = var.tags
}

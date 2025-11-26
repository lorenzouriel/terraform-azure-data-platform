terraform {
    required_version = ">=1.3.9"

    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "3.46.0"
        }

        azapi = {
            source = "Azure/azapi"
            version = "1.4.0"
        }
    }
}

provider "azapi" {
}

provider "azurerm" {
    features {}
}

resource "azurerm_resource_group" "example-rg" {
    name     = "example-rg"
    location = "West Europe"
}

resource "azurerm_data_factory" "example-adf" {
    name                = "example-adf"
    location            = azurerm_resource_group.example-rg.location
    resource_group_name = azurerm_resource_group.example-rg.name
}

# This feature is in public preview at time of writing, hence the `schema_validation_enabled = false`
resource "azapi_resource" "example-adf_airflow" {
    type = "Microsoft.DataFactory/factories/integrationRuntimes@2018-06-01"
    name = "example-adf-airflow"
    parent_id = azurerm_data_factory.example-adf.id
    schema_validation_enabled = false

    body = jsonencode({
        properties = {
            type = "Airflow"
            description = "Airflow integration runtime"
            typeProperties = {
                computeProperties = {
                    location = azurerm_data_factory.example-adf.location
                    computeSize = "Small"
                    extraNodes = 0
                }
                airflowProperties = {
                    environmentVariables = {
                        foo = "bar"
                    }
                    airflowVersion = "2.4.3"
                    enableAADIntegration = true
                    airflowRequiredArguments = ["apache-airflow-providers-microsoft-azure"]
                    airflowEntityReferences = []
                    encryptedSecrets = []
                    secrets = []
                }
            }
        }
    })
}
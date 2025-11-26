terraform {
  backend "azurerm" {
    # Configure these values via -backend-config flags or environment variables
    # Example:
    # terraform init -backend-config="resource_group_name=tfstate-rg" \
    #            -backend-config="storage_account_name=tfstate147" \
    #            -backend-config="container_name=tfstate" \
    #            -backend-config="key=dev.terraform.tfstate"

    resource_group_name  = "tfstate-rg"
    storage_account_name = "tfstate147"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

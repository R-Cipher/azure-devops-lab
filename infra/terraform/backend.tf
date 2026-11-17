terraform {
  backend "azurerm" {
    resource_group_name  = "rg-service-status-tfstate"
    storage_account_name = "tfstatelab2611"
    container_name       = "tfstate"
    key                  = "service-status-lab.tfstate"

    use_azuread_auth = true
    use_cli          = true
  }
}

locals {
  name_prefix = "service-status-${var.environment}"

  common_tags = {
    application = "service-status-api"
    environment = var.environment
    managed_by  = "terraform"
    work_item   = "5"
  }
}

data "azurerm_resource_group" "api" {
  name = "rg-${local.name_prefix}"
}

resource "azurerm_service_plan" "api" {
  name                = "asp-${local.name_prefix}"
  location            = data.azurerm_resource_group.api.location
  resource_group_name = data.azurerm_resource_group.api.name
  os_type             = "Linux"
  sku_name            = "F1"
  tags                = local.common_tags
}

resource "azurerm_linux_web_app" "api" {
  name                                           = var.web_app_name
  location                                       = data.azurerm_resource_group.api.location
  resource_group_name                            = data.azurerm_resource_group.api.name
  service_plan_id                                = azurerm_service_plan.api.id
  https_only                                     = true
  ftp_publish_basic_authentication_enabled       = false
  webdeploy_publish_basic_authentication_enabled = false
  tags                                           = local.common_tags

  site_config {
    always_on = false

    application_stack {
      dotnet_version = "10.0"
    }
  }
}

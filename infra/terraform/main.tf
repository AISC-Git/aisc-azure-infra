locals {
  rg_name     = "rg-${var.app_base_name}-${var.environment}"
  asp_name    = "asp-${var.app_base_name}-${var.environment}"
  webapp_name = "${var.app_base_name}-${var.environment}-webapp"
  ai_name     = "ai-${var.app_base_name}-${var.environment}"
}

resource "azurerm_resource_group" "rg" {
  name     = local.rg_name
  location = var.location
}

resource "azurerm_application_insights" "ai" {
  name                = local.ai_name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  application_type    = "web"
}

resource "azurerm_service_plan" "plan" {
  name                = local.asp_name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_linux_web_app" "app" {
  name                = local.webapp_name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.plan.id
  https_only          = true

  identity {
    type = "SystemAssigned"
  }

  site_config {
    http2_enabled = true
    always_on     = true
  }

  app_settings = {
    APPLICATIONINSIGHTS_CONNECTION_STRING = azurerm_application_insights.ai.connection_string
    NODE_ENV = "development"
  }
}

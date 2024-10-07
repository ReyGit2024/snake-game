# Definición de locales para reutilización
locals { 
  resource_group_name   = "${data.azurerm_resource_group.existingResourceGroup.name}"
  location              = "${data.azurerm_resource_group.existingResourceGroup.location}"
  app_service_plan_name = "${data.azurerm_service_plan.existingAppServicePlan.name}-plan"
  app_service_name      = "${data.azurerm_linux_web_app.existingAppService.name}-service-snake"
}

# Data sources
data "azurerm_resource_group" "existingResourceGroup" {
  name = "my-resource-group"
}

data "azurerm_service_plan" "existingAppServicePlan" {
  name                 = "my-app-service"
  resource_group_name  = data.azurerm_resource_group.existingResourceGroup.name
}

data "azurerm_linux_web_app" "existingAppService" {
  name                 = "my-app"
  resource_group_name  = data.azurerm_resource_group.existingResourceGroup.name
}

# Configuración del proveedor (debe cargar valores sensibles de manera segura)
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

# Recursos (creación de nuevo plan de servicio y app service)
resource "azurerm_service_plan" "newAppServicePlan"{
  name                 = local.app_service_plan_name
  location             = local.location
  resource_group_name  = local.resource_group_name
  sku_name ="S1"
  os_type ="Windows"
  
}

resource "azurerm_linux_web_app" "newAppService" {
  name                 = local.app_service_name
  location             = azurerm_service_plan.newAppServicePlan.location
  resource_group_name  = local.resource_group_name
  service_plan_id      = azurerm_service_plan.newAppServicePlan.id

  site_config {}
}




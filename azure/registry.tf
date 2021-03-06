resource "azurerm_container_registry" "acr" {
  name                     = replace(var.environment_name, "/-/", "")
  resource_group_name      = "${azurerm_resource_group.cluster.name}"
  location                 = "${azurerm_resource_group.cluster.location}"
  sku                      = "Premium"
  admin_enabled            = false
  georeplication_locations = ["East US", "West Europe"]
}

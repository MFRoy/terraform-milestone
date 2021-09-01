resource "azurerm_virtual_network" "scale_set" {
    name = "${var.environment}-vnet"
    resource_group_name = azurerm_resource_group.scale_set.name
    location = var.location
    address_space = ["10.0.0.0/16"]
    
}
resource "azurerm_subnet" "scale_set" {
    name = "${var.environment}-subnet"
    resource_group_name = azurerm_resource_group.scale_set.name
    location = var.location
    address_prefix = ["10.0.0.0/24"]
}
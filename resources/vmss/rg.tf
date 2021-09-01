resource "azurerm_resource_group" "scale_set" {
    name = "${var.environment}-rg"
    location = var.variable

    tags = {
        environment = var.environment 
    }
}

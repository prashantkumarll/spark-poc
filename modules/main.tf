resource "azurerm_resource_group" "rg" {
    name     = var.resource_group_name
    location = var.location
}

resource "random_pet" "name" {
  length    = 2
  separator = "-"
}

resource "azurerm_data_factory" "datafactory" {
  name                = "${random_pet.name}-df"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_databricks_workspace" "databricks" {
  name                = "${random_pet.name}-dbw"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "standard"

  tags = {
    Environment = "Production"
  }
}
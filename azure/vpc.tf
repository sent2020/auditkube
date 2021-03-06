resource "azurerm_route_table" "cluster" {
  name                = "${var.environment_name}"
  location            = "${azurerm_resource_group.cluster.location}"
  resource_group_name = "${azurerm_resource_group.cluster.name}"

  route {
    name                   = "default"
    address_prefix         = "10.100.0.0/14"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.10.1.1"
  }
}

resource "azurerm_virtual_network" "cluster" {
  name                = "${var.environment_name}"
  location            = "${azurerm_resource_group.cluster.location}"
  resource_group_name = "${azurerm_resource_group.cluster.name}"
  address_space       = ["10.1.0.0/16"]
}

resource "azurerm_subnet" "cluster" {
  name                 = "internal"
  resource_group_name  = "${azurerm_resource_group.cluster.name}"
  address_prefix       = "10.1.0.0/24"
  virtual_network_name = "${azurerm_virtual_network.cluster.name}"

  # this field is deprecated and will be removed in 2.0 - but is required until then
  route_table_id = "${azurerm_route_table.cluster.id}"
}

resource "azurerm_subnet_route_table_association" "cluster" {
  subnet_id      = "${azurerm_subnet.cluster.id}"
  route_table_id = "${azurerm_route_table.cluster.id}"
}

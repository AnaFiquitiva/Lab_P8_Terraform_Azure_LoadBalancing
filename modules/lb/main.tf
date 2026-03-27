# ──────────────────────────────────────────────
# Módulo LB — Load Balancer público + NSG
# ──────────────────────────────────────────────

# IP pública para el Load Balancer
resource "azurerm_public_ip" "pip" {
  name                = "${var.prefix}-lb-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

# Load Balancer estándar (L4)
resource "azurerm_lb" "lb" {
  name                = "${var.prefix}-lb"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "Public"
    public_ip_address_id = azurerm_public_ip.pip.id
  }
  tags = var.tags
}

# Backend pool del Load Balancer
resource "azurerm_lb_backend_address_pool" "bepool" {
  name            = "${var.prefix}-bepool"
  loadbalancer_id = azurerm_lb.lb.id
}

# Asociar NICs de las VMs al backend pool
resource "azurerm_network_interface_backend_address_pool_association" "assoc" {
  count                   = length(var.backend_nic_ids)
  network_interface_id    = var.backend_nic_ids[count.index]
  ip_configuration_name   = "ipconfig1"
  backend_address_pool_id = azurerm_lb_backend_address_pool.bepool.id
}

# Health probe — verificación TCP en puerto 80
resource "azurerm_lb_probe" "probe" {
  name            = "http-80"
  loadbalancer_id = azurerm_lb.lb.id
  protocol        = "Tcp"
  port            = 80
}

# Regla de balanceo — 80 (frontend) → 80 (backend)
resource "azurerm_lb_rule" "rule" {
  name                           = "http-80"
  loadbalancer_id                = azurerm_lb.lb.id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "Public"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.bepool.id]
  probe_id                       = azurerm_lb_probe.probe.id
}

# Network Security Group — controla tráfico entrante
resource "azurerm_network_security_group" "nsg" {
  name                = "${var.prefix}-web-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  # Permitir HTTP (80) desde Internet
  security_rule {
    name                       = "Allow-HTTP-Internet"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  # Permitir SSH (22) solo desde la IP del estudiante
  security_rule {
    name                       = "Allow-SSH-From-Home"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.allow_ssh_from_cidr
    destination_address_prefix = "*"
  }
  tags = var.tags
}

# Asociar NSG a cada NIC de las VMs
resource "azurerm_network_interface_security_group_association" "nsg_assoc" {
  count                     = length(var.backend_nic_ids)
  network_interface_id      = var.backend_nic_ids[count.index]
  network_security_group_id = azurerm_network_security_group.nsg.id
}

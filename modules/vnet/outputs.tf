# ──────────────────────────────────────────────
# Outputs del módulo VNet
# ──────────────────────────────────────────────

output "vnet_name" {
  description = "Nombre de la Virtual Network"
  value       = azurerm_virtual_network.vnet.name
}

output "subnet_web_id" {
  description = "ID de la subnet web (para VMs detrás del LB)"
  value       = azurerm_subnet.web.id
}

output "subnet_mgmt_id" {
  description = "ID de la subnet de administración"
  value       = azurerm_subnet.mgmt.id
}

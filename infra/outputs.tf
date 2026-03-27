# ──────────────────────────────────────────────
# Outputs del Root Module
# ──────────────────────────────────────────────

output "lb_public_ip" {
  description = "IP pública del Load Balancer — acceder vía http://<IP>"
  value       = module.lb.public_ip
}

output "resource_group_name" {
  description = "Nombre del Resource Group creado"
  value       = azurerm_resource_group.rg.name
}

output "vm_names" {
  description = "Lista de nombres de las VMs desplegadas"
  value       = module.compute.vm_names
}

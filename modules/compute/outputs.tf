# ──────────────────────────────────────────────
# Outputs del módulo Compute
# ──────────────────────────────────────────────

output "vm_names" {
  description = "Lista de nombres de las VMs creadas"
  value       = [for v in azurerm_linux_virtual_machine.vm : v.name]
}

output "nic_ids" {
  description = "Lista de IDs de las NICs creadas"
  value       = [for n in azurerm_network_interface.nic : n.id]
}

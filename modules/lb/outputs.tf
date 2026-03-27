# ──────────────────────────────────────────────
# Outputs del módulo LB
# ──────────────────────────────────────────────

output "public_ip" {
  description = "IP pública del Load Balancer"
  value       = azurerm_public_ip.pip.ip_address
}

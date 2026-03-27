# ──────────────────────────────────────────────
# Variables de entrada del Root Module
# ──────────────────────────────────────────────

variable "subscription_id" {
  description = "ID de la suscripción de Azure"
  type        = string
}

variable "prefix" {
  description = "Prefijo para nombrar todos los recursos (ej. lab8)"
  type        = string
  default     = "lab8"
}

variable "location" {
  description = "Región de Azure donde se despliega la infraestructura"
  type        = string
  default     = "eastus"
}

variable "vm_count" {
  description = "Número de VMs a crear detrás del Load Balancer"
  type        = number
  default     = 2

  validation {
    condition     = var.vm_count >= 2
    error_message = "Se requieren al menos 2 VMs para alta disponibilidad."
  }
}

variable "admin_username" {
  description = "Nombre del usuario administrador en las VMs"
  type        = string
  default     = "student"
}

variable "ssh_public_key" {
  description = "Ruta al archivo de llave pública SSH"
  type        = string
  default     = "~/.ssh/id_ed25519.pub"
}

variable "allow_ssh_from_cidr" {
  description = "CIDR de la IP autorizada para SSH (formato: X.X.X.X/32)"
  type        = string
}

variable "tags" {
  description = "Etiquetas aplicadas a todos los recursos"
  type        = map(string)
  default = {
    owner   = "AnaFiquitiva"
    course  = "ARSW/BluePrints"
    env     = "dev"
    expires = "2026-06-30"
  }
}

# ──────────────────────────────────────────────
# Variables del módulo Compute
# ──────────────────────────────────────────────

variable "resource_group_name" {
  description = "Nombre del Resource Group donde se despliegan las VMs"
  type        = string
}

variable "location" {
  description = "Región de Azure"
  type        = string
}

variable "prefix" {
  description = "Prefijo para nombrar recursos"
  type        = string
}

variable "admin_username" {
  description = "Usuario administrador de las VMs"
  type        = string
}

variable "ssh_public_key" {
  description = "Contenido de la llave pública SSH para autenticación"
  type        = string
}

variable "subnet_id" {
  description = "ID de la subnet donde se conectan las NICs"
  type        = string
}

variable "vm_count" {
  description = "Número de VMs a crear"
  type        = number
}

variable "cloud_init" {
  description = "Contenido del script cloud-init para configurar las VMs"
  type        = string
}

variable "tags" {
  description = "Etiquetas para los recursos"
  type        = map(string)
}

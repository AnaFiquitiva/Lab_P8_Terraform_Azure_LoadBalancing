# ──────────────────────────────────────────
# Variables de entorno: dev
# Ana Fiquitiva — ARSW / BluePrints
# ──────────────────────────────────────────

subscription_id     = "fbf6fc28-0508-4f3d-bf93-d8910f7d8a9c"
prefix              = "lab8"
location            = "eastus2"
vm_count            = 2
admin_username      = "student"
ssh_public_key      = "~/.ssh/id_ed25519.pub"
allow_ssh_from_cidr = "186.29.35.50/32"

tags = {
  owner   = "AnaFiquitiva"
  course  = "ARSW/BluePrints"
  env     = "dev"
  expires = "2026-06-30"
}

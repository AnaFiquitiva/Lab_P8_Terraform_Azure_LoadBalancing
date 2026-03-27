# ──────────────────────────────────────────────
# Resource Group y wiring de módulos
# ──────────────────────────────────────────────

resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.prefix}-AnaFiquitiva"
  location = var.location
  tags     = var.tags
}

# ── Red Virtual con 2 subredes ─────────────────
module "vnet" {
  source              = "../modules/vnet"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  prefix              = var.prefix
  tags                = var.tags
}

# ── VMs Linux con nginx (cloud-init) ───────────
module "compute" {
  source              = "../modules/compute"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  prefix              = var.prefix
  admin_username      = var.admin_username
  ssh_public_key      = file(var.ssh_public_key)
  subnet_id           = module.vnet.subnet_web_id
  vm_count            = var.vm_count
  cloud_init          = file("${path.module}/cloud-init.yaml")
  tags                = var.tags
}

# ── Load Balancer público + NSG ─────────────────
module "lb" {
  source              = "../modules/lb"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  prefix              = var.prefix
  backend_nic_ids     = module.compute.nic_ids
  allow_ssh_from_cidr = var.allow_ssh_from_cidr
  tags                = var.tags
}

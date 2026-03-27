# ──────────────────────────────────────────────
# Terraform & Provider Configuration
# ──────────────────────────────────────────────

terraform {
  required_version = ">= 1.6.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  # Backend remoto en Azure Storage (configurado vía backend.hcl)
  backend "azurerm" {}
}

provider "azurerm" {
  features {}
  subscription_id                 = var.subscription_id
  resource_provider_registrations = "none"
}

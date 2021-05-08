# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 2.26"
    }
  }
  required_version = ">= 0.14.9"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "terraform_RG" {
  name = "terraform_RG"
  location = "brazilsouth"

  tags = {
    Environment = "Terraform Getting Started"
    Team = "DevOps"
  }
}

resource "azurerm_container_group" "terraform_CG" {
  name = "terraform_CG"
  location = azurerm_resource_group.terraform_RG.location
  resource_group_name = azurerm_resource_group.terraform_RG.name

  tags = {
    Environment = "Terraform Getting Started"
    Team = "DevOps"
  }

  ip_address_type = "public"
  dns_name_label = "terraformdnswebapi"
  os_type = "Linux"

  container {
    name = "vaadin"
    image = "marceloedsa/vaadin"
    cpu = "1"
    memory = "1"
    ports {
      port = 80
      protocol = "TCP"
    }
  }
}

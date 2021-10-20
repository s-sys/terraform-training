# Lab06
# Atividade 6.1.
# 
# Crie uma automação para a criação de uma máquina virtual no ambiente Microsoft Azure.
# Defina através de variáveis em "terraform.tfvars" as propriedades principais e crie
# uma lista para as regras de segurança de acesso. As regras deverão ser populadas
# pelo terraform utilizando blocos dinâmicos.


# Crie um arquivo chamado "~/terraform/lab06/exe01/main.tf", com o seguinte conteúdo:
 
# Configure the Microsoft Azure Provider
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~> 2.81"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = var.subscription_id == "" ? null : var.subscription_id
  tenant_id       = var.tenant_id == ""       ? null : var.tenant_id
  client_id       = var.client_id == ""       ? null : var.client_id
  client_secret   = var.client_secret == ""   ? null : var.client_secret
}

# resource "azurerm_resource_group" "rg" {
#   name     = var.resource_group
#   location = var.location
# }

data "azurerm_resource_group" "rg" {
  name     = var.resource_group
}

resource "azurerm_virtual_network" "network" {
  name                = "network"
  address_space       = ["10.0.0.0/16"]
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "internal"
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.network.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "public_ip" {
  name                = "public_ip"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "nic" {
  name                = "nic"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "ip-internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id 
  }
}

resource "azurerm_network_security_group" "nsg" {
  name                = "nsg"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  dynamic "security_rule" {
    for_each = var.rules
    content {
      name                       = security_rule.value.name
      priority                   = 1000 + tonumber(index(var.rules.*.name, security_rule.value.name))
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = security_rule.value.protocol
      source_port_range          = "*"
      destination_port_range     = tonumber(security_rule.value.port)
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }
}

resource "azurerm_network_interface_security_group_association" "nsg_association" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# Create virtual machines for SAP
resource "azurerm_linux_virtual_machine" "vm" {
  name                            = "vm1"
  location                        = data.azurerm_resource_group.rg.location
  resource_group_name             = data.azurerm_resource_group.rg.name
  network_interface_ids           = [azurerm_network_interface.nic.id]
  size                            = "Standard_B1ls"
  computer_name                   = "vm1"
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password
  disable_password_authentication = false

  os_disk {
    name                 = "disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }

  admin_ssh_key {
    username   = var.admin_username
    public_key = file("~/.ssh/id_rsa.pub")
  }
}


# Crie um arquivo chamado "~/terraform/lab06/exe01/variables.tf",
# com o seguinte conteúdo:
# 
# variable "subscription_id" {
#   type = string
# }
# 
# variable "tenant_id" {
#   type = string
# }
# 
# variable "client_id" {
#   type = string
# }
# 
# variable "client_secret" {
#   type = string
# }
# 
# variable "resource_group" {
#   type = string
# }
# 
# variable "location" {
#   type = string
# }
# 
# variable "admin_username" {
#   type = string
# }
# 
# variable "admin_password" {
#   type = string
# }
# 
# variable "rules" {
#   type = list(object({
#     name      = string
#     protocol  = string
#     port      = number
#     })
#   )
# }


# Crie um arquivo chamado "~/terraform/lab05/exe05/output.tf",
# com o seguinte conteúdo:
# 
# output "ip" {
#   value = azurerm_public_ip.public_ip.ip_address
# }
# 
# output "username" {
#   value = var.admin_username
# }
# 
# output "password" {
#   value     = var.admin_password
#   sensitive = true
# }
# 
# output "ssh_command" {
#   value = "ssh ${var.admin_username}@${azurerm_public_ip.public_ip.ip_address}"
# }


# Crie um arquivo chamado "~/terraform/lab05/exe05/terraform.tfvars",
# com o seguinte conteúdo:
# 
# subscription_id = ""
# tenant_id       = ""
# client_id       = ""
# client_secret   = ""
# 
# resource_group  = "terraform-rg-student-XX"
# location        = "centralus"
# admin_username  = "azureroot"
# admin_password  = "Passw0rd123"
# 
# rules = [
#   {
#     name      = "SSH"
#     protocol  = "Tcp"
#     port      = 22
#   },
#   {
#     name      = "HTTP"
#     protocol  = "Tcp"
#     port      = 80
#   },
#   {
#     name      = "HTTPS"
#     protocol  = "Tcp"
#     port      = 443
#   },
#   {
#     name      = "My-API"
#     protocol  = "Tcp"
#     port      = 8081
#   },
# ]


# Preencha os dados de acesso do Azure e do "Resource Group" com as informações fornecidas pelo instrutor.


# Execute o comando abaixo para inicializar o diretório do terraform:
# 
# $ terraform init
# 
# Initializing the backend...
# 
# Initializing provider plugins...
# - Finding hashicorp/azurerm versions matching "~> 2.81"...
# - Installing hashicorp/azurerm v2.81.0...
# - Installed hashicorp/azurerm v2.81.0 (signed by HashiCorp)
# 
# Terraform has created a lock file .terraform.lock.hcl to record the provider
# selections it made above. Include this file in your version control repository
# so that Terraform can guarantee to make the same selections by default when
# you run "terraform init" in the future.
# 
# Terraform has been successfully initialized!
# 
# You may now begin working with Terraform. Try running "terraform plan" to see
# any changes that are required for your infrastructure. All Terraform commands
# should now work.
# 
# If you ever set or change modules or backend configuration for Terraform,
# rerun this command to reinitialize your working directory. If you forget, other
# commands will detect it and remind you to do so if necessary.


# Em seguida execute o comando abaixo para aplicar a configuração do terraform:
# 
# $ terraform apply -auto-approve
# 
# Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
#   + create
# 
# Terraform will perform the following actions:
# 
#   # azurerm_linux_virtual_machine.vm will be created
#   + resource "azurerm_linux_virtual_machine" "vm" {
#       + admin_password                  = (sensitive value)
#       + admin_username                  = "azureroot"
#       + allow_extension_operations      = true
#       + computer_name                   = "vm1"
#       + disable_password_authentication = false
#       + extensions_time_budget          = "PT1H30M"
#       + id                              = (known after apply)
#       + location                        = "centralus"
#       + max_bid_price                   = -1
#       + name                            = "vm1"
#       + network_interface_ids           = (known after apply)
#       + platform_fault_domain           = -1
#       + priority                        = "Regular"
#       + private_ip_address              = (known after apply)
#       + private_ip_addresses            = (known after apply)
#       + provision_vm_agent              = true
#       + public_ip_address               = (known after apply)
#       + public_ip_addresses             = (known after apply)
#       + resource_group_name             = "terraform-rg-student-01"
#       + size                            = "Standard_B1ls"
#       + virtual_machine_id              = (known after apply)
#       + zone                            = (known after apply)
# 
#       + admin_ssh_key {
#           + public_key = <<-EOT
#                 ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDb6VI1UvD8kHvCfjioiFgTseLSn5/MvvAUKFp/miqjM5YOHMIEWvgKNNBoz5REYp2GKSVFiXBKcrsYq8FpZePd7CMX2NZoJOraEMl/2IqHeo2Y+Y1F+VWUilHx98Co/0epgRG1UgVY7ZxC0SjX2rjxBV4LOulOVxDjyJc/RUatT/x7D9gIKo2DW5z6U2zO4hiTvoeY9tU2XubgDNu7bkoL75U49uToKsy/R4Paf1EOHCC/Hfdxyoyx6yibNA5KxqManBMY4dcWAnt3O03pBW7vJRAJ2M9p7VJsx7iSRKdktdf6yr54UFhCFkMMTiEuto8RVIObNs5DYo5dYKWsNewwcoYsotFTPrXXb7FiMTTsGjPEJ57TzNupemmupmfTUPEDo2J/GLVI9ah9nilK+RU4uyvaO4SU6JpSplHGUJbMXd2gpm5ahoPjZ3thjuSbRbek/7cIxvaPB4OV6YBsM4qPYGxYTaiOfprXspe9vJvQlHLYeTCv1VErtyzXlWzFqpc= azureroot@terraform-01
#             EOT
#           + username   = "azureroot"
#         }
# 
#       + os_disk {
#           + caching                   = "ReadWrite"
#           + disk_size_gb              = (known after apply)
#           + name                      = "disk"
#           + storage_account_type      = "Standard_LRS"
#           + write_accelerator_enabled = false
#         }
# 
#       + source_image_reference {
#           + offer     = "0001-com-ubuntu-server-focal"
#           + publisher = "canonical"
#           + sku       = "20_04-lts-gen2"
#           + version   = "latest"
#         }
#     }
# 
#   # azurerm_network_interface.nic will be created
#   + resource "azurerm_network_interface" "nic" {
#       + applied_dns_servers           = (known after apply)
#       + dns_servers                   = (known after apply)
#       + enable_accelerated_networking = false
#       + enable_ip_forwarding          = false
#       + id                            = (known after apply)
#       + internal_dns_name_label       = (known after apply)
#       + internal_domain_name_suffix   = (known after apply)
#       + location                      = "centralus"
#       + mac_address                   = (known after apply)
#       + name                          = "nic"
#       + private_ip_address            = (known after apply)
#       + private_ip_addresses          = (known after apply)
#       + resource_group_name           = "terraform-rg-student-01"
#       + virtual_machine_id            = (known after apply)
# 
#       + ip_configuration {
#           + name                          = "ip-internal"
#           + primary                       = (known after apply)
#           + private_ip_address            = (known after apply)
#           + private_ip_address_allocation = "dynamic"
#           + private_ip_address_version    = "IPv4"
#           + public_ip_address_id          = (known after apply)
#           + subnet_id                     = (known after apply)
#         }
#     }
# 
#   # azurerm_network_interface_security_group_association.nsg_association will be created
#   + resource "azurerm_network_interface_security_group_association" "nsg_association" {
#       + id                        = (known after apply)
#       + network_interface_id      = (known after apply)
#       + network_security_group_id = (known after apply)
#     }
# 
#   # azurerm_network_security_group.nsg will be created
#   + resource "azurerm_network_security_group" "nsg" {
#       + id                  = (known after apply)
#       + location            = "centralus"
#       + name                = "nsg"
#       + resource_group_name = "terraform-rg-student-01"
#       + security_rule       = [
#           + {
#               + access                                     = "Allow"
#               + description                                = ""
#               + destination_address_prefix                 = "*"
#               + destination_address_prefixes               = []
#               + destination_application_security_group_ids = []
#               + destination_port_range                     = "22"
#               + destination_port_ranges                    = []
#               + direction                                  = "Inbound"
#               + name                                       = "SSH"
#               + priority                                   = 1000
#               + protocol                                   = "Tcp"
#               + source_address_prefix                      = "*"
#               + source_address_prefixes                    = []
#               + source_application_security_group_ids      = []
#               + source_port_range                          = "*"
#               + source_port_ranges                         = []
#             },
#           + {
#               + access                                     = "Allow"
#               + description                                = ""
#               + destination_address_prefix                 = "*"
#               + destination_address_prefixes               = []
#               + destination_application_security_group_ids = []
#               + destination_port_range                     = "443"
#               + destination_port_ranges                    = []
#               + direction                                  = "Inbound"
#               + name                                       = "HTTPS"
#               + priority                                   = 1002
#               + protocol                                   = "Tcp"
#               + source_address_prefix                      = "*"
#               + source_address_prefixes                    = []
#               + source_application_security_group_ids      = []
#               + source_port_range                          = "*"
#               + source_port_ranges                         = []
#             },
#           + {
#               + access                                     = "Allow"
#               + description                                = ""
#               + destination_address_prefix                 = "*"
#               + destination_address_prefixes               = []
#               + destination_application_security_group_ids = []
#               + destination_port_range                     = "80"
#               + destination_port_ranges                    = []
#               + direction                                  = "Inbound"
#               + name                                       = "HTTP"
#               + priority                                   = 1001
#               + protocol                                   = "Tcp"
#               + source_address_prefix                      = "*"
#               + source_address_prefixes                    = []
#               + source_application_security_group_ids      = []
#               + source_port_range                          = "*"
#               + source_port_ranges                         = []
#             },
#           + {
#               + access                                     = "Allow"
#               + description                                = ""
#               + destination_address_prefix                 = "*"
#               + destination_address_prefixes               = []
#               + destination_application_security_group_ids = []
#               + destination_port_range                     = "8081"
#               + destination_port_ranges                    = []
#               + direction                                  = "Inbound"
#               + name                                       = "My-API"
#               + priority                                   = 1003
#               + protocol                                   = "Tcp"
#               + source_address_prefix                      = "*"
#               + source_address_prefixes                    = []
#               + source_application_security_group_ids      = []
#               + source_port_range                          = "*"
#               + source_port_ranges                         = []
#             },
#         ]
#     }
# 
#   # azurerm_public_ip.public_ip will be created
#   + resource "azurerm_public_ip" "public_ip" {
#       + allocation_method       = "Static"
#       + availability_zone       = (known after apply)
#       + fqdn                    = (known after apply)
#       + id                      = (known after apply)
#       + idle_timeout_in_minutes = 4
#       + ip_address              = (known after apply)
#       + ip_version              = "IPv4"
#       + location                = "centralus"
#       + name                    = "public_ip"
#       + resource_group_name     = "terraform-rg-student-01"
#       + sku                     = "Basic"
#       + sku_tier                = "Regional"
#       + zones                   = (known after apply)
#     }
# 
#   # azurerm_subnet.subnet will be created
#   + resource "azurerm_subnet" "subnet" {
#       + address_prefix                                 = (known after apply)
#       + address_prefixes                               = [
#           + "10.0.1.0/24",
#         ]
#       + enforce_private_link_endpoint_network_policies = false
#       + enforce_private_link_service_network_policies  = false
#       + id                                             = (known after apply)
#       + name                                           = "internal"
#       + resource_group_name                            = "terraform-rg-student-01"
#       + virtual_network_name                           = "network"
#     }
# 
#   # azurerm_virtual_network.network will be created
#   + resource "azurerm_virtual_network" "network" {
#       + address_space         = [
#           + "10.0.0.0/16",
#         ]
#       + dns_servers           = (known after apply)
#       + guid                  = (known after apply)
#       + id                    = (known after apply)
#       + location              = "centralus"
#       + name                  = "network"
#       + resource_group_name   = "terraform-rg-student-01"
#       + subnet                = (known after apply)
#       + vm_protection_enabled = false
#     }
# 
# Plan: 7 to add, 0 to change, 0 to destroy.
# 
# Changes to Outputs:
#   + ip          = (known after apply)
#   + password    = (sensitive value)
#   + ssh_command = (known after apply)
#   + username    = "azureroot"
# azurerm_public_ip.public_ip: Creating...
# azurerm_virtual_network.network: Creating...
# azurerm_network_security_group.nsg: Creating...
# ...
# azurerm_subnet.subnet: Creating...
# azurerm_network_interface.nic: Creating...
# azurerm_network_interface_security_group_association.nsg_association: Creating...
# azurerm_linux_virtual_machine.vm: Creating...
# azurerm_linux_virtual_machine.vm: Still creating... [10s elapsed]
# 
# Apply complete! Resources: 7 added, 0 changed, 0 destroyed.
# 
# Outputs:
# 
# ip = "104.43.198.204"
# password = <sensitive>
# ssh_command = "ssh azureroot@104.43.198.204"
# username = "azureroot"


# Faça o login no portal Azure em https://portal.azure.com utilizando as credenciais fornecidas pelo instrutor e verifique dentro do "Resource Group" os recursos que foram criados pelo terraform.
#


# Verifique as regras de segurança que foram criadas.
#


# Conecte-se por SSH na máquina criada e verifique suas configurações.
#


# Execute o comando "terraform destroy" para destruir o ambiente, conforme abaixo:
# 
# $ TF_LOG=debug terraform apply -auto-approve -destroy 


# Verifique através do Portal do Azure se todos os recursos foram removidos.

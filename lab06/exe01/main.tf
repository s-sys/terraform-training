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
      version = "~> 3.83.0"
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
# O script "az.sh" pode ser utilizado para preencher as variáveis referentes aos dados da aplicação 
# do Azure que serão utilizadas para as atividades do laboratório.


# Execute o comando abaixo para inicializar o diretório do terraform:
# 
# $ terraform init
# 
# Initializing the backend...
# 
# Initializing provider plugins...
# - Finding hashicorp/azurerm versions matching "~> 3.83.0"...
# - Installing hashicorp/azurerm v3.83.0...
# - Installed hashicorp/azurerm v3.83.0 (signed by HashiCorp)
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
# data.azurerm_resource_group.rg: Reading...
# data.azurerm_resource_group.rg: Read complete after 0s [id=/subscriptions/f4d6246c-29d3-4562-b7f0-43e4c51c2374/resourceGroups/terraform-rg-student-01]
# 
# Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the
# following symbols:
#   + create
# 
# Terraform will perform the following actions:
# 
#   # azurerm_linux_virtual_machine.vm will be created
#   + resource "azurerm_linux_virtual_machine" "vm" {
#       + admin_password                                         = (sensitive value)
#       + admin_username                                         = "azureroot"
#       + allow_extension_operations                             = true
#       + bypass_platform_safety_checks_on_user_schedule_enabled = false
#       + computer_name                                          = "vm1"
#       + disable_password_authentication                        = false
#       + extensions_time_budget                                 = "PT1H30M"
#       + id                                                     = (known after apply)
#       + location                                               = "centralus"
#       + max_bid_price                                          = -1
#       + name                                                   = "vm1"
#       + network_interface_ids                                  = (known after apply)
#       + patch_assessment_mode                                  = "ImageDefault"
#       + patch_mode                                             = "ImageDefault"
#       + platform_fault_domain                                  = -1
#       + priority                                               = "Regular"
#       + private_ip_address                                     = (known after apply)
#       + private_ip_addresses                                   = (known after apply)
#       + provision_vm_agent                                     = true
#       + public_ip_address                                      = (known after apply)
#       + public_ip_addresses                                    = (known after apply)
#       + resource_group_name                                    = "terraform-rg-student-01"
#       + size                                                   = "Standard_B1ls"
#       + virtual_machine_id                                     = (known after apply)
# 
#       + admin_ssh_key {
#           + public_key = <<-EOT
#                 ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDDerMYphqZbqxnAQ4fTzTFKq865w+1arOORCtzj8yX9gv29EQPBQlK5VoSlLk8TEax/0MYtrb4GhPvn30eialp59EtO4A6SiFVR0JUKBen3z4QixnQXsBjNLOI5qKlIYN62RDnzv2p4WbggNsLPLkFoqfZZaZjF7oXvQtrIJqXEY77roQZnUFQLhJox0G5HNJgUJVTkrAedpcR9UpB48d/ji+uXXeoZbxsGbJZmv/xENnbSqq4R5QLJJ0gTaP2gdRPBxifT1Hm0XzvQQtDuN/OWuNK4A2hVCkvYMzvp5Pa2XzKskWjjawITMUuHQraVEWzuIXc1N+xn7eTZV8X4OrZIDU17IQZn4GlYhwgRr+4rvVoM+y1WiIc+vvQvA1rIdYNB/zKVqNNPNxKRrjCUsMHPvZeDWLcyY4mexagk0v1R9UOXkp/taDiUR5XFh9nY/Va9AeWwXsNSHHxfhn9ol9Q/+PFYLWKTlJwCHyWGNpqs5URNGNCvTjMA+IeEt0AmYE= azureroot@t01-tf201
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
#           + gateway_load_balancer_frontend_ip_configuration_id = (known after apply)
#           + name                                               = "ip-internal"
#           + primary                                            = (known after apply)
#           + private_ip_address                                 = (known after apply)
#           + private_ip_address_allocation                      = "Dynamic"
#           + private_ip_address_version                         = "IPv4"
#           + public_ip_address_id                               = (known after apply)
#           + subnet_id                                          = (known after apply)
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
#       + ddos_protection_mode    = "VirtualNetworkInherited"
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
#     }
# 
#   # azurerm_subnet.subnet will be created
#   + resource "azurerm_subnet" "subnet" {
#       + address_prefixes                               = [
#           + "10.0.1.0/24",
#         ]
#       + enforce_private_link_endpoint_network_policies = (known after apply)
#       + enforce_private_link_service_network_policies  = (known after apply)
#       + id                                             = (known after apply)
#       + name                                           = "internal"
#       + private_endpoint_network_policies_enabled      = (known after apply)
#       + private_link_service_network_policies_enabled  = (known after apply)
#       + resource_group_name                            = "terraform-rg-student-01"
#       + virtual_network_name                           = "network"
#     }
# 
#   # azurerm_virtual_network.network will be created
#   + resource "azurerm_virtual_network" "network" {
#       + address_space       = [
#           + "10.0.0.0/16",
#         ]
#       + dns_servers         = (known after apply)
#       + guid                = (known after apply)
#       + id                  = (known after apply)
#       + location            = "centralus"
#       + name                = "network"
#       + resource_group_name = "terraform-rg-student-01"
#       + subnet              = (known after apply)
#     }
# 
# Plan: 7 to add, 0 to change, 0 to destroy.
# 
# Changes to Outputs:
#   + ip          = (known after apply)
#   + password    = (sensitive value)
#   + ssh_command = (known after apply)
#   + username    = "azureroot"
# 
# Do you want to perform these actions?
#   Terraform will perform the actions described above.
#   Only 'yes' will be accepted to approve.
# 
#   Enter a value: yes
# 
# azurerm_virtual_network.network: Creating...
# azurerm_public_ip.public_ip: Creating...
# azurerm_network_security_group.nsg: Creating...
# azurerm_network_security_group.nsg: Creation complete after 2s [id=/subscriptions/f4d6246c-29d3-4562-b7f0-43e4c51c2374/resourceGroups/terraform-rg-student-01/providers/Microsoft.Network/networkSecurityGroups/nsg]
# azurerm_public_ip.public_ip: Creation complete after 2s [id=/subscriptions/f4d6246c-29d3-4562-b7f0-43e4c51c2374/resourceGroups/terraform-rg-student-01/providers/Microsoft.Network/publicIPAddresses/public_ip]
# azurerm_virtual_network.network: Creation complete after 4s [id=/subscriptions/f4d6246c-29d3-4562-b7f0-43e4c51c2374/resourceGroups/terraform-rg-student-01/providers/Microsoft.Network/virtualNetworks/network]
# azurerm_subnet.subnet: Creating...
# azurerm_subnet.subnet: Creation complete after 3s [id=/subscriptions/f4d6246c-29d3-4562-b7f0-43e4c51c2374/resourceGroups/terraform-rg-student-01/providers/Microsoft.Network/virtualNetworks/network/subnets/internal]
# azurerm_network_interface.nic: Creating...
# azurerm_network_interface.nic: Still creating... [10s elapsed]
# azurerm_network_interface.nic: Creation complete after 11s [id=/subscriptions/f4d6246c-29d3-4562-b7f0-43e4c51c2374/resourceGroups/terraform-rg-student-01/providers/Microsoft.Network/networkInterfaces/nic]
# azurerm_network_interface_security_group_association.nsg_association: Creating...
# azurerm_linux_virtual_machine.vm: Creating...
# azurerm_network_interface_security_group_association.nsg_association: Creation complete after 1s [id=/subscriptions/f4d6246c-29d3-4562-b7f0-43e4c51c2374/resourceGroups/terraform-rg-student-01/providers/Microsoft.Network/networkInterfaces/nic|/subscriptions/f4d6246c-29d3-4562-b7f0-43e4c51c2374/resourceGroups/terraform-rg-student-01/providers/Microsoft.Network/networkSecurityGroups/nsg]
# azurerm_linux_virtual_machine.vm: Still creating... [10s elapsed]
# azurerm_linux_virtual_machine.vm: Still creating... [20s elapsed]
# azurerm_linux_virtual_machine.vm: Still creating... [30s elapsed]
# azurerm_linux_virtual_machine.vm: Still creating... [40s elapsed]
# azurerm_linux_virtual_machine.vm: Creation complete after 47s [id=/subscriptions/f4d6246c-29d3-4562-b7f0-43e4c51c2374/resourceGroups/terraform-rg-student-01/providers/Microsoft.Compute/virtualMachines/vm1]
# 
# Apply complete! Resources: 7 added, 0 changed, 0 destroyed.
# 
# Outputs:
# 
# ip = "20.12.184.22"
# password = <sensitive>
# ssh_command = "ssh azureroot@20.12.184.22"
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

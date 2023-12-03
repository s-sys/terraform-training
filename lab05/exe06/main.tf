# Lab05
# Atividade 5.6.
# 
# Crie uma automação para a criação de máquinas virtuais KVM utilizando libvirt.
# A quantidade de máquinas virtuais a serem criadas será definida pela quantidade
# de elementos em uma lista de objetos definidas no arquivo "terraform.tfvars".
# Ao final do processo, o terraform conectará por SSH nas máquinas virtuais e
# executará alguns comandos de configuração.


# Crie um arquivo chamado "~/terraform/lab05/exe06/main.tf",
# com o seguinte conteúdo:

module "kvm" {
  source = "./modules/kvm"
  vms    = var.vms
}


# Crie um arquivo chamado "~/terraform/lab05/exe05/variables.tf",
# com o seguinte conteúdo:
# 
# variable "vms" {
#   type = list(object({
#     name   = string
#     memory = optional(number)
#     vcpu   = optional(number)
#   }))
# }


# Crie um arquivo chamado "~/terraform/lab05/exe05/output.tf",
# com o seguinte conteúdo:
# 
# output "hostnames" {
#   value = module.kvm.hostnames
# }
# 
# output "ips" {
#   value = module.kvm.ips
# }


# Crie um arquivo chamado "~/terraform/lab05/exe05/terraform.tfvars",
# com o seguinte conteúdo:
# 
# vms = [
#   {
#    name   = "vm1"
#    vcpu   = 1
#   },
#   {
#    name   = "vm2"
#    memory = 512
#   },
#   {
#    name   = "vm3"
#    vcpu   = 1
#    memory = 512
#   },
#   {
#    name   = "vm4"
#    vcpu   = 1
#    memory = 512
#   },
#   {
#    name   = "vm5"
#    vcpu   = 1
#    memory = 512
#   },
#   {
#    name   = "vm6"
#    vcpu   = 1
#    memory = 512
#   },
# ]


# Obtenha o arquivo "modules.tar.gz" disponível no repositório do exercício
# e descompacte, conforme abaixo:
#
# tar xvf modules.tar.gz
#
# Verifique a estrutura dos arquivos, conforme abaixo:
#
# $ ls -lR modules/
# modules:
# total 0
# drwxr-xr-x 2 azureroot users 106 Dec  2 19:35 kvm
# 
# modules/kvm:
# total 20
# -rw-r--r-- 1 azureroot users  832 Dec  2 19:30 cloud_init.cfg
# -rw-r--r-- 1 azureroot users 2550 Dec  2 19:35 main.tf
# -rw-r--r-- 1 azureroot users   95 Dec  2 19:29 network_config.cfg
# -rw-r--r-- 1 azureroot users  146 Dec  2 19:29 output.tf
# -rw-r--r-- 1 azureroot users  115 Dec  2 19:29 variables.tf


# Ajuste o arquivo modules/kvm/cloud_init.cfg para que contenha a chave pública de SSH correta.


# Execute o comando abaixo para inicializar o diretório do terraform:
# 
# $ terraform init
# 
# Initializing the backend...
# Initializing modules...
# - kvm in modules/kvm
# 
# Initializing provider plugins...
# - Finding dmacvicar/libvirt versions matching "~> 0.7.6"...
# - Finding latest version of hashicorp/null...
# - Finding latest version of hashicorp/template...
# - Installing dmacvicar/libvirt v0.7.6...
# - Installed dmacvicar/libvirt v0.7.6 (self-signed, key ID 0833E38C51E74D26)
# - Installing hashicorp/null v3.2.2...
# - Installed hashicorp/null v3.2.2 (signed by HashiCorp)
# - Installing hashicorp/template v2.2.0...
# - Installed hashicorp/template v2.2.0 (signed by HashiCorp)
# 
# Partner and community providers are signed by their developers.
# If you'd like to know more about provider signing, you can read about it here:
# https://www.terraform.io/docs/cli/plugins/signing.html
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
# module.kvm.data.template_file.network_config: Reading...
# module.kvm.data.template_file.user_data[2]: Reading...
# module.kvm.data.template_file.user_data[5]: Reading...
# module.kvm.data.template_file.user_data[1]: Reading...
# module.kvm.data.template_file.user_data[4]: Reading...
# module.kvm.data.template_file.user_data[0]: Reading...
# module.kvm.data.template_file.user_data[3]: Reading...
# module.kvm.data.template_file.network_config: Read complete after 0s [id=98585aaf6c6ab040bbb6943114277cec19c43ff9543db03ed0d772104e8cf42e]
# module.kvm.data.template_file.user_data[2]: Read complete after 0s [id=4550334f89885a433a7e230e1c373f3cc1006f412277dbeeac9e84e754704383]
# module.kvm.data.template_file.user_data[1]: Read complete after 0s [id=4550334f89885a433a7e230e1c373f3cc1006f412277dbeeac9e84e754704383]
# module.kvm.data.template_file.user_data[4]: Read complete after 0s [id=4550334f89885a433a7e230e1c373f3cc1006f412277dbeeac9e84e754704383]
# module.kvm.data.template_file.user_data[5]: Read complete after 0s [id=4550334f89885a433a7e230e1c373f3cc1006f412277dbeeac9e84e754704383]
# module.kvm.data.template_file.user_data[3]: Read complete after 0s [id=4550334f89885a433a7e230e1c373f3cc1006f412277dbeeac9e84e754704383]
# module.kvm.data.template_file.user_data[0]: Read complete after 0s [id=4550334f89885a433a7e230e1c373f3cc1006f412277dbeeac9e84e754704383]
# 
# Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the
# following symbols:
#   + create
# 
# Terraform will perform the following actions:
# 
#   # module.kvm.libvirt_cloudinit_disk.cloudinit[0] will be created
#   + resource "libvirt_cloudinit_disk" "cloudinit" {
#       + id             = (known after apply)
#       + name           = "cloudinit-t-vm1.iso"
#       + network_config = <<-EOT
#             version: 2
#             ethernets:
#               all:
#                 match:
#                   name: e*
#                 dhcp4: true
#                 dhcp6: false
#         EOT
#       + pool           = "VMs"
#       + user_data      = <<-EOT
#             #cloud-config
#             # vim: syntax=yaml
#             ssh_pwauth: true
#             chpasswd:
#               list: |
#                 root:linux
#                 ubuntu:linux
#               expire: false
# 
#             disable_root: false
# 
#             users:
#               - name: root
#                 ssh_authorized_keys:
#                   - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDDerMYphqZbqxnAQ4fTzTFKq865w+1arOORCtzj8yX9gv29EQPBQlK5VoSlLk8TEax/0MYtrb4GhPvn30eialp59EtO4A6SiFVR0JUKBen3z4QixnQXsBjNLOI5qKlIYN62RDnzv2p4WbggNsLPLkFoqfZZaZjF7oXvQtrIJqXEY77roQZnUFQLhJox0G5HNJgUJVTkrAedpcR9UpB48d/ji+uXXeoZbxsGbJZmv/xENnbSqq4R5QLJJ0gTaP2gdRPBxifT1Hm0XzvQQtDuN/OWuNK4A2hVCkvYMzvp5Pa2XzKskWjjawITMUuHQraVEWzuIXc1N+xn7eTZV8X4OrZIDU17IQZn4GlYhwgRr+4rvVoM+y1WiIc+vvQvA1rIdYNB/zKVqNNPNxKRrjCUsMHPvZeDWLcyY4mexagk0v1R9UOXkp/taDiUR5XFh9nY/Va9AeWwXsNSHHxfhn9ol9Q/+PFYLWKTlJwCHyWGNpqs5URNGNCvTjMA+IeEt0AmYE= azureroot@t01-tf201
# 
#             runcmd:
#               - echo "yes" > /root/cloud-init.ok
#         EOT
#     }
# 
#   # module.kvm.libvirt_cloudinit_disk.cloudinit[1] will be created
#   + resource "libvirt_cloudinit_disk" "cloudinit" {
#       + id             = (known after apply)
#       + name           = "cloudinit-t-vm2.iso"
#       + network_config = <<-EOT
#             version: 2
#             ethernets:
#               all:
#                 match:
#                   name: e*
#                 dhcp4: true
#                 dhcp6: false
#         EOT
#       + pool           = "VMs"
#       + user_data      = <<-EOT
#             #cloud-config
#             # vim: syntax=yaml
#             ssh_pwauth: true
#             chpasswd:
#               list: |
#                 root:linux
#                 ubuntu:linux
#               expire: false
# 
#             disable_root: false
# 
#             users:
#               - name: root
#                 ssh_authorized_keys:
#                   - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDDerMYphqZbqxnAQ4fTzTFKq865w+1arOORCtzj8yX9gv29EQPBQlK5VoSlLk8TEax/0MYtrb4GhPvn30eialp59EtO4A6SiFVR0JUKBen3z4QixnQXsBjNLOI5qKlIYN62RDnzv2p4WbggNsLPLkFoqfZZaZjF7oXvQtrIJqXEY77roQZnUFQLhJox0G5HNJgUJVTkrAedpcR9UpB48d/ji+uXXeoZbxsGbJZmv/xENnbSqq4R5QLJJ0gTaP2gdRPBxifT1Hm0XzvQQtDuN/OWuNK4A2hVCkvYMzvp5Pa2XzKskWjjawITMUuHQraVEWzuIXc1N+xn7eTZV8X4OrZIDU17IQZn4GlYhwgRr+4rvVoM+y1WiIc+vvQvA1rIdYNB/zKVqNNPNxKRrjCUsMHPvZeDWLcyY4mexagk0v1R9UOXkp/taDiUR5XFh9nY/Va9AeWwXsNSHHxfhn9ol9Q/+PFYLWKTlJwCHyWGNpqs5URNGNCvTjMA+IeEt0AmYE= azureroot@t01-tf201
# 
#             runcmd:
#               - echo "yes" > /root/cloud-init.ok
#         EOT
#     }
# 
#   # module.kvm.libvirt_cloudinit_disk.cloudinit[2] will be created
#   + resource "libvirt_cloudinit_disk" "cloudinit" {
#       + id             = (known after apply)
#       + name           = "cloudinit-t-vm3.iso"
#       + network_config = <<-EOT
#             version: 2
#             ethernets:
#               all:
#                 match:
#                   name: e*
#                 dhcp4: true
#                 dhcp6: false
#         EOT
#       + pool           = "VMs"
#       + user_data      = <<-EOT
#             #cloud-config
#             # vim: syntax=yaml
#             ssh_pwauth: true
#             chpasswd:
#               list: |
#                 root:linux
#                 ubuntu:linux
#               expire: false
# 
#             disable_root: false
# 
#             users:
#               - name: root
#                 ssh_authorized_keys:
#                   - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDDerMYphqZbqxnAQ4fTzTFKq865w+1arOORCtzj8yX9gv29EQPBQlK5VoSlLk8TEax/0MYtrb4GhPvn30eialp59EtO4A6SiFVR0JUKBen3z4QixnQXsBjNLOI5qKlIYN62RDnzv2p4WbggNsLPLkFoqfZZaZjF7oXvQtrIJqXEY77roQZnUFQLhJox0G5HNJgUJVTkrAedpcR9UpB48d/ji+uXXeoZbxsGbJZmv/xENnbSqq4R5QLJJ0gTaP2gdRPBxifT1Hm0XzvQQtDuN/OWuNK4A2hVCkvYMzvp5Pa2XzKskWjjawITMUuHQraVEWzuIXc1N+xn7eTZV8X4OrZIDU17IQZn4GlYhwgRr+4rvVoM+y1WiIc+vvQvA1rIdYNB/zKVqNNPNxKRrjCUsMHPvZeDWLcyY4mexagk0v1R9UOXkp/taDiUR5XFh9nY/Va9AeWwXsNSHHxfhn9ol9Q/+PFYLWKTlJwCHyWGNpqs5URNGNCvTjMA+IeEt0AmYE= azureroot@t01-tf201
# 
#             runcmd:
#               - echo "yes" > /root/cloud-init.ok
#         EOT
#     }
# 
#   # module.kvm.libvirt_cloudinit_disk.cloudinit[3] will be created
#   + resource "libvirt_cloudinit_disk" "cloudinit" {
#       + id             = (known after apply)
#       + name           = "cloudinit-t-vm4.iso"
#       + network_config = <<-EOT
#             version: 2
#             ethernets:
#               all:
#                 match:
#                   name: e*
#                 dhcp4: true
#                 dhcp6: false
#         EOT
#       + pool           = "VMs"
#       + user_data      = <<-EOT
#             #cloud-config
#             # vim: syntax=yaml
#             ssh_pwauth: true
#             chpasswd:
#               list: |
#                 root:linux
#                 ubuntu:linux
#               expire: false
# 
#             disable_root: false
# 
#             users:
#               - name: root
#                 ssh_authorized_keys:
#                   - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDDerMYphqZbqxnAQ4fTzTFKq865w+1arOORCtzj8yX9gv29EQPBQlK5VoSlLk8TEax/0MYtrb4GhPvn30eialp59EtO4A6SiFVR0JUKBen3z4QixnQXsBjNLOI5qKlIYN62RDnzv2p4WbggNsLPLkFoqfZZaZjF7oXvQtrIJqXEY77roQZnUFQLhJox0G5HNJgUJVTkrAedpcR9UpB48d/ji+uXXeoZbxsGbJZmv/xENnbSqq4R5QLJJ0gTaP2gdRPBxifT1Hm0XzvQQtDuN/OWuNK4A2hVCkvYMzvp5Pa2XzKskWjjawITMUuHQraVEWzuIXc1N+xn7eTZV8X4OrZIDU17IQZn4GlYhwgRr+4rvVoM+y1WiIc+vvQvA1rIdYNB/zKVqNNPNxKRrjCUsMHPvZeDWLcyY4mexagk0v1R9UOXkp/taDiUR5XFh9nY/Va9AeWwXsNSHHxfhn9ol9Q/+PFYLWKTlJwCHyWGNpqs5URNGNCvTjMA+IeEt0AmYE= azureroot@t01-tf201
# 
#             runcmd:
#               - echo "yes" > /root/cloud-init.ok
#         EOT
#     }
# 
#   # module.kvm.libvirt_cloudinit_disk.cloudinit[4] will be created
#   + resource "libvirt_cloudinit_disk" "cloudinit" {
#       + id             = (known after apply)
#       + name           = "cloudinit-t-vm5.iso"
#       + network_config = <<-EOT
#             version: 2
#             ethernets:
#               all:
#                 match:
#                   name: e*
#                 dhcp4: true
#                 dhcp6: false
#         EOT
#       + pool           = "VMs"
#       + user_data      = <<-EOT
#             #cloud-config
#             # vim: syntax=yaml
#             ssh_pwauth: true
#             chpasswd:
#               list: |
#                 root:linux
#                 ubuntu:linux
#               expire: false
# 
#             disable_root: false
# 
#             users:
#               - name: root
#                 ssh_authorized_keys:
#                   - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDDerMYphqZbqxnAQ4fTzTFKq865w+1arOORCtzj8yX9gv29EQPBQlK5VoSlLk8TEax/0MYtrb4GhPvn30eialp59EtO4A6SiFVR0JUKBen3z4QixnQXsBjNLOI5qKlIYN62RDnzv2p4WbggNsLPLkFoqfZZaZjF7oXvQtrIJqXEY77roQZnUFQLhJox0G5HNJgUJVTkrAedpcR9UpB48d/ji+uXXeoZbxsGbJZmv/xENnbSqq4R5QLJJ0gTaP2gdRPBxifT1Hm0XzvQQtDuN/OWuNK4A2hVCkvYMzvp5Pa2XzKskWjjawITMUuHQraVEWzuIXc1N+xn7eTZV8X4OrZIDU17IQZn4GlYhwgRr+4rvVoM+y1WiIc+vvQvA1rIdYNB/zKVqNNPNxKRrjCUsMHPvZeDWLcyY4mexagk0v1R9UOXkp/taDiUR5XFh9nY/Va9AeWwXsNSHHxfhn9ol9Q/+PFYLWKTlJwCHyWGNpqs5URNGNCvTjMA+IeEt0AmYE= azureroot@t01-tf201
# 
#             runcmd:
#               - echo "yes" > /root/cloud-init.ok
#         EOT
#     }
# 
#   # module.kvm.libvirt_cloudinit_disk.cloudinit[5] will be created
#   + resource "libvirt_cloudinit_disk" "cloudinit" {
#       + id             = (known after apply)
#       + name           = "cloudinit-t-vm6.iso"
#       + network_config = <<-EOT
#             version: 2
#             ethernets:
#               all:
#                 match:
#                   name: e*
#                 dhcp4: true
#                 dhcp6: false
#         EOT
#       + pool           = "VMs"
#       + user_data      = <<-EOT
#             #cloud-config
#             # vim: syntax=yaml
#             ssh_pwauth: true
#             chpasswd:
#               list: |
#                 root:linux
#                 ubuntu:linux
#               expire: false
# 
#             disable_root: false
# 
#             users:
#               - name: root
#                 ssh_authorized_keys:
#                   - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDDerMYphqZbqxnAQ4fTzTFKq865w+1arOORCtzj8yX9gv29EQPBQlK5VoSlLk8TEax/0MYtrb4GhPvn30eialp59EtO4A6SiFVR0JUKBen3z4QixnQXsBjNLOI5qKlIYN62RDnzv2p4WbggNsLPLkFoqfZZaZjF7oXvQtrIJqXEY77roQZnUFQLhJox0G5HNJgUJVTkrAedpcR9UpB48d/ji+uXXeoZbxsGbJZmv/xENnbSqq4R5QLJJ0gTaP2gdRPBxifT1Hm0XzvQQtDuN/OWuNK4A2hVCkvYMzvp5Pa2XzKskWjjawITMUuHQraVEWzuIXc1N+xn7eTZV8X4OrZIDU17IQZn4GlYhwgRr+4rvVoM+y1WiIc+vvQvA1rIdYNB/zKVqNNPNxKRrjCUsMHPvZeDWLcyY4mexagk0v1R9UOXkp/taDiUR5XFh9nY/Va9AeWwXsNSHHxfhn9ol9Q/+PFYLWKTlJwCHyWGNpqs5URNGNCvTjMA+IeEt0AmYE= azureroot@t01-tf201
# 
#             runcmd:
#               - echo "yes" > /root/cloud-init.ok
#         EOT
#     }
# 
#   # module.kvm.libvirt_domain.vm[0] will be created
#   + resource "libvirt_domain" "vm" {
#       + arch        = (known after apply)
#       + autostart   = (known after apply)
#       + cloudinit   = (known after apply)
#       + emulator    = (known after apply)
#       + fw_cfg_name = "opt/com.coreos/config"
#       + id          = (known after apply)
#       + machine     = (known after apply)
#       + memory      = 640
#       + name        = "t-vm1"
#       + qemu_agent  = false
#       + running     = true
#       + type        = "kvm"
#       + vcpu        = 1
# 
#       + console {
#           + source_host    = "127.0.0.1"
#           + source_service = "0"
#           + target_port    = "0"
#           + target_type    = "serial"
#           + type           = "pty"
#         }
#       + console {
#           + source_host    = "127.0.0.1"
#           + source_service = "0"
#           + target_port    = "1"
#           + target_type    = "virtio"
#           + type           = "pty"
#         }
# 
#       + cpu {
#           + mode = "host-model"
#         }
# 
#       + disk {
#           + scsi      = true
#           + volume_id = (known after apply)
#         }
# 
#       + graphics {
#           + autoport       = true
#           + listen_address = "127.0.0.1"
#           + listen_type    = "address"
#           + type           = "spice"
#         }
# 
#       + network_interface {
#           + addresses      = (known after apply)
#           + hostname       = (known after apply)
#           + mac            = (known after apply)
#           + network_id     = (known after apply)
#           + network_name   = "default"
#           + wait_for_lease = true
#         }
#     }
# 
#   # module.kvm.libvirt_domain.vm[1] will be created
#   + resource "libvirt_domain" "vm" {
#       + arch        = (known after apply)
#       + autostart   = (known after apply)
#       + cloudinit   = (known after apply)
#       + emulator    = (known after apply)
#       + fw_cfg_name = "opt/com.coreos/config"
#       + id          = (known after apply)
#       + machine     = (known after apply)
#       + memory      = 512
#       + name        = "t-vm2"
#       + qemu_agent  = false
#       + running     = true
#       + type        = "kvm"
#       + vcpu        = 2
# 
#       + console {
#           + source_host    = "127.0.0.1"
#           + source_service = "0"
#           + target_port    = "0"
#           + target_type    = "serial"
#           + type           = "pty"
#         }
#       + console {
#           + source_host    = "127.0.0.1"
#           + source_service = "0"
#           + target_port    = "1"
#           + target_type    = "virtio"
#           + type           = "pty"
#         }
# 
#       + cpu {
#           + mode = "host-model"
#         }
# 
#       + disk {
#           + scsi      = true
#           + volume_id = (known after apply)
#         }
# 
#       + graphics {
#           + autoport       = true
#           + listen_address = "127.0.0.1"
#           + listen_type    = "address"
#           + type           = "spice"
#         }
# 
#       + network_interface {
#           + addresses      = (known after apply)
#           + hostname       = (known after apply)
#           + mac            = (known after apply)
#           + network_id     = (known after apply)
#           + network_name   = "default"
#           + wait_for_lease = true
#         }
#     }
# 
#   # module.kvm.libvirt_domain.vm[2] will be created
#   + resource "libvirt_domain" "vm" {
#       + arch        = (known after apply)
#       + autostart   = (known after apply)
#       + cloudinit   = (known after apply)
#       + emulator    = (known after apply)
#       + fw_cfg_name = "opt/com.coreos/config"
#       + id          = (known after apply)
#       + machine     = (known after apply)
#       + memory      = 512
#       + name        = "t-vm3"
#       + qemu_agent  = false
#       + running     = true
#       + type        = "kvm"
#       + vcpu        = 1
# 
#       + console {
#           + source_host    = "127.0.0.1"
#           + source_service = "0"
#           + target_port    = "0"
#           + target_type    = "serial"
#           + type           = "pty"
#         }
#       + console {
#           + source_host    = "127.0.0.1"
#           + source_service = "0"
#           + target_port    = "1"
#           + target_type    = "virtio"
#           + type           = "pty"
#         }
# 
#       + cpu {
#           + mode = "host-model"
#         }
# 
#       + disk {
#           + scsi      = true
#           + volume_id = (known after apply)
#         }
# 
#       + graphics {
#           + autoport       = true
#           + listen_address = "127.0.0.1"
#           + listen_type    = "address"
#           + type           = "spice"
#         }
# 
#       + network_interface {
#           + addresses      = (known after apply)
#           + hostname       = (known after apply)
#           + mac            = (known after apply)
#           + network_id     = (known after apply)
#           + network_name   = "default"
#           + wait_for_lease = true
#         }
#     }
# 
#   # module.kvm.libvirt_domain.vm[3] will be created
#   + resource "libvirt_domain" "vm" {
#       + arch        = (known after apply)
#       + autostart   = (known after apply)
#       + cloudinit   = (known after apply)
#       + emulator    = (known after apply)
#       + fw_cfg_name = "opt/com.coreos/config"
#       + id          = (known after apply)
#       + machine     = (known after apply)
#       + memory      = 512
#       + name        = "t-vm4"
#       + qemu_agent  = false
#       + running     = true
#       + type        = "kvm"
#       + vcpu        = 1
# 
#       + console {
#           + source_host    = "127.0.0.1"
#           + source_service = "0"
#           + target_port    = "0"
#           + target_type    = "serial"
#           + type           = "pty"
#         }
#       + console {
#           + source_host    = "127.0.0.1"
#           + source_service = "0"
#           + target_port    = "1"
#           + target_type    = "virtio"
#           + type           = "pty"
#         }
# 
#       + cpu {
#           + mode = "host-model"
#         }
# 
#       + disk {
#           + scsi      = true
#           + volume_id = (known after apply)
#         }
# 
#       + graphics {
#           + autoport       = true
#           + listen_address = "127.0.0.1"
#           + listen_type    = "address"
#           + type           = "spice"
#         }
# 
#       + network_interface {
#           + addresses      = (known after apply)
#           + hostname       = (known after apply)
#           + mac            = (known after apply)
#           + network_id     = (known after apply)
#           + network_name   = "default"
#           + wait_for_lease = true
#         }
#     }
# 
#   # module.kvm.libvirt_domain.vm[4] will be created
#   + resource "libvirt_domain" "vm" {
#       + arch        = (known after apply)
#       + autostart   = (known after apply)
#       + cloudinit   = (known after apply)
#       + emulator    = (known after apply)
#       + fw_cfg_name = "opt/com.coreos/config"
#       + id          = (known after apply)
#       + machine     = (known after apply)
#       + memory      = 512
#       + name        = "t-vm5"
#       + qemu_agent  = false
#       + running     = true
#       + type        = "kvm"
#       + vcpu        = 1
# 
#       + console {
#           + source_host    = "127.0.0.1"
#           + source_service = "0"
#           + target_port    = "0"
#           + target_type    = "serial"
#           + type           = "pty"
#         }
#       + console {
#           + source_host    = "127.0.0.1"
#           + source_service = "0"
#           + target_port    = "1"
#           + target_type    = "virtio"
#           + type           = "pty"
#         }
# 
#       + cpu {
#           + mode = "host-model"
#         }
# 
#       + disk {
#           + scsi      = true
#           + volume_id = (known after apply)
#         }
# 
#       + graphics {
#           + autoport       = true
#           + listen_address = "127.0.0.1"
#           + listen_type    = "address"
#           + type           = "spice"
#         }
# 
#       + network_interface {
#           + addresses      = (known after apply)
#           + hostname       = (known after apply)
#           + mac            = (known after apply)
#           + network_id     = (known after apply)
#           + network_name   = "default"
#           + wait_for_lease = true
#         }
#     }
# 
#   # module.kvm.libvirt_domain.vm[5] will be created
#   + resource "libvirt_domain" "vm" {
#       + arch        = (known after apply)
#       + autostart   = (known after apply)
#       + cloudinit   = (known after apply)
#       + emulator    = (known after apply)
#       + fw_cfg_name = "opt/com.coreos/config"
#       + id          = (known after apply)
#       + machine     = (known after apply)
#       + memory      = 512
#       + name        = "t-vm6"
#       + qemu_agent  = false
#       + running     = true
#       + type        = "kvm"
#       + vcpu        = 1
# 
#       + console {
#           + source_host    = "127.0.0.1"
#           + source_service = "0"
#           + target_port    = "0"
#           + target_type    = "serial"
#           + type           = "pty"
#         }
#       + console {
#           + source_host    = "127.0.0.1"
#           + source_service = "0"
#           + target_port    = "1"
#           + target_type    = "virtio"
#           + type           = "pty"
#         }
# 
#       + cpu {
#           + mode = "host-model"
#         }
# 
#       + disk {
#           + scsi      = true
#           + volume_id = (known after apply)
#         }
# 
#       + graphics {
#           + autoport       = true
#           + listen_address = "127.0.0.1"
#           + listen_type    = "address"
#           + type           = "spice"
#         }
# 
#       + network_interface {
#           + addresses      = (known after apply)
#           + hostname       = (known after apply)
#           + mac            = (known after apply)
#           + network_id     = (known after apply)
#           + network_name   = "default"
#           + wait_for_lease = true
#         }
#     }
# 
#   # module.kvm.libvirt_volume.volume[0] will be created
#   + resource "libvirt_volume" "volume" {
#       + format = "qcow2"
#       + id     = (known after apply)
#       + name   = "t-vm1.qcow2"
#       + pool   = "VMs"
#       + size   = (known after apply)
#       + source = "https://cloud-images.ubuntu.com/releases/focal/release/ubuntu-20.04-server-cloudimg-amd64.img"
#     }
# 
#   # module.kvm.libvirt_volume.volume[1] will be created
#   + resource "libvirt_volume" "volume" {
#       + format = "qcow2"
#       + id     = (known after apply)
#       + name   = "t-vm2.qcow2"
#       + pool   = "VMs"
#       + size   = (known after apply)
#       + source = "https://cloud-images.ubuntu.com/releases/focal/release/ubuntu-20.04-server-cloudimg-amd64.img"
#     }
# 
#   # module.kvm.libvirt_volume.volume[2] will be created
#   + resource "libvirt_volume" "volume" {
#       + format = "qcow2"
#       + id     = (known after apply)
#       + name   = "t-vm3.qcow2"
#       + pool   = "VMs"
#       + size   = (known after apply)
#       + source = "https://cloud-images.ubuntu.com/releases/focal/release/ubuntu-20.04-server-cloudimg-amd64.img"
#     }
# 
#   # module.kvm.libvirt_volume.volume[3] will be created
#   + resource "libvirt_volume" "volume" {
#       + format = "qcow2"
#       + id     = (known after apply)
#       + name   = "t-vm4.qcow2"
#       + pool   = "VMs"
#       + size   = (known after apply)
#       + source = "https://cloud-images.ubuntu.com/releases/focal/release/ubuntu-20.04-server-cloudimg-amd64.img"
#     }
# 
#   # module.kvm.libvirt_volume.volume[4] will be created
#   + resource "libvirt_volume" "volume" {
#       + format = "qcow2"
#       + id     = (known after apply)
#       + name   = "t-vm5.qcow2"
#       + pool   = "VMs"
#       + size   = (known after apply)
#       + source = "https://cloud-images.ubuntu.com/releases/focal/release/ubuntu-20.04-server-cloudimg-amd64.img"
#     }
# 
#   # module.kvm.libvirt_volume.volume[5] will be created
#   + resource "libvirt_volume" "volume" {
#       + format = "qcow2"
#       + id     = (known after apply)
#       + name   = "t-vm6.qcow2"
#       + pool   = "VMs"
#       + size   = (known after apply)
#       + source = "https://cloud-images.ubuntu.com/releases/focal/release/ubuntu-20.04-server-cloudimg-amd64.img"
#     }
# 
#   # module.kvm.null_resource.exec[0] will be created
#   + resource "null_resource" "exec" {
#       + id = (known after apply)
#     }
# 
#   # module.kvm.null_resource.exec[1] will be created
#   + resource "null_resource" "exec" {
#       + id = (known after apply)
#     }
# 
#   # module.kvm.null_resource.exec[2] will be created
#   + resource "null_resource" "exec" {
#       + id = (known after apply)
#     }
# 
#   # module.kvm.null_resource.exec[3] will be created
#   + resource "null_resource" "exec" {
#       + id = (known after apply)
#     }
# 
#   # module.kvm.null_resource.exec[4] will be created
#   + resource "null_resource" "exec" {
#       + id = (known after apply)
#     }
# 
#   # module.kvm.null_resource.exec[5] will be created
#   + resource "null_resource" "exec" {
#       + id = (known after apply)
#     }
# 
# Plan: 24 to add, 0 to change, 0 to destroy.
# 
# Changes to Outputs:
#   + hostnames = [
#       + "t-vm1",
#       + "t-vm2",
#       + "t-vm3",
#       + "t-vm4",
#       + "t-vm5",
#       + "t-vm6",
#     ]
#   + ips       = [
#       + (known after apply),
#       + (known after apply),
#       + (known after apply),
#       + (known after apply),
#       + (known after apply),
#       + (known after apply),
#     ]
# module.kvm.libvirt_volume.volume[1]: Creating...
# module.kvm.libvirt_volume.volume[2]: Creating...
# module.kvm.libvirt_volume.volume[3]: Creating...
# module.kvm.libvirt_volume.volume[4]: Creating...
# module.kvm.libvirt_volume.volume[0]: Creating...
# module.kvm.libvirt_volume.volume[5]: Creating...
# module.kvm.libvirt_volume.volume[2]: Still creating... [10s elapsed]
# module.kvm.libvirt_volume.volume[1]: Still creating... [10s elapsed]
# module.kvm.libvirt_volume.volume[4]: Still creating... [10s elapsed]
# module.kvm.libvirt_volume.volume[0]: Still creating... [10s elapsed]
# module.kvm.libvirt_volume.volume[5]: Still creating... [10s elapsed]
# module.kvm.libvirt_volume.volume[3]: Still creating... [10s elapsed]
# module.kvm.libvirt_volume.volume[2]: Still creating... [20s elapsed]
# module.kvm.libvirt_volume.volume[1]: Still creating... [20s elapsed]
# module.kvm.libvirt_volume.volume[3]: Still creating... [20s elapsed]
# module.kvm.libvirt_volume.volume[4]: Still creating... [20s elapsed]
# module.kvm.libvirt_volume.volume[0]: Still creating... [20s elapsed]
# module.kvm.libvirt_volume.volume[5]: Still creating... [20s elapsed]
# module.kvm.libvirt_volume.volume[1]: Creation complete after 25s [id=/data/vms/t-vm2.qcow2]
# module.kvm.libvirt_volume.volume[2]: Still creating... [30s elapsed]
# module.kvm.libvirt_volume.volume[5]: Still creating... [30s elapsed]
# module.kvm.libvirt_volume.volume[3]: Still creating... [30s elapsed]
# module.kvm.libvirt_volume.volume[4]: Still creating... [30s elapsed]
# module.kvm.libvirt_volume.volume[0]: Still creating... [30s elapsed]
# module.kvm.libvirt_volume.volume[2]: Still creating... [40s elapsed]
# module.kvm.libvirt_volume.volume[0]: Still creating... [40s elapsed]
# module.kvm.libvirt_volume.volume[4]: Still creating... [40s elapsed]
# module.kvm.libvirt_volume.volume[3]: Still creating... [40s elapsed]
# module.kvm.libvirt_volume.volume[5]: Still creating... [40s elapsed]
# module.kvm.libvirt_volume.volume[2]: Creation complete after 50s [id=/data/vms/t-vm3.qcow2]
# module.kvm.libvirt_volume.volume[5]: Still creating... [50s elapsed]
# module.kvm.libvirt_volume.volume[0]: Still creating... [50s elapsed]
# module.kvm.libvirt_volume.volume[3]: Still creating... [50s elapsed]
# module.kvm.libvirt_volume.volume[4]: Still creating... [50s elapsed]
# module.kvm.libvirt_volume.volume[0]: Still creating... [1m0s elapsed]
# module.kvm.libvirt_volume.volume[5]: Still creating... [1m0s elapsed]
# module.kvm.libvirt_volume.volume[3]: Still creating... [1m0s elapsed]
# module.kvm.libvirt_volume.volume[4]: Still creating... [1m0s elapsed]
# module.kvm.libvirt_volume.volume[3]: Still creating... [1m10s elapsed]
# module.kvm.libvirt_volume.volume[0]: Still creating... [1m10s elapsed]
# module.kvm.libvirt_volume.volume[5]: Still creating... [1m10s elapsed]
# module.kvm.libvirt_volume.volume[4]: Still creating... [1m10s elapsed]
# module.kvm.libvirt_volume.volume[3]: Creation complete after 1m16s [id=/data/vms/t-vm4.qcow2]
# module.kvm.libvirt_volume.volume[5]: Still creating... [1m20s elapsed]
# module.kvm.libvirt_volume.volume[0]: Still creating... [1m20s elapsed]
# module.kvm.libvirt_volume.volume[4]: Still creating... [1m20s elapsed]
# module.kvm.libvirt_volume.volume[4]: Still creating... [1m30s elapsed]
# module.kvm.libvirt_volume.volume[0]: Still creating... [1m30s elapsed]
# module.kvm.libvirt_volume.volume[5]: Still creating... [1m30s elapsed]
# module.kvm.libvirt_volume.volume[5]: Still creating... [1m40s elapsed]
# module.kvm.libvirt_volume.volume[0]: Still creating... [1m40s elapsed]
# module.kvm.libvirt_volume.volume[4]: Still creating... [1m40s elapsed]
# module.kvm.libvirt_volume.volume[0]: Creation complete after 1m41s [id=/data/vms/t-vm1.qcow2]
# module.kvm.libvirt_volume.volume[5]: Still creating... [1m50s elapsed]
# module.kvm.libvirt_volume.volume[4]: Still creating... [1m50s elapsed]
# module.kvm.libvirt_volume.volume[4]: Still creating... [2m0s elapsed]
# module.kvm.libvirt_volume.volume[5]: Still creating... [2m0s elapsed]
# module.kvm.libvirt_volume.volume[4]: Creation complete after 2m5s [id=/data/vms/t-vm5.qcow2]
# module.kvm.libvirt_volume.volume[5]: Still creating... [2m10s elapsed]
# module.kvm.libvirt_volume.volume[5]: Still creating... [2m20s elapsed]
# module.kvm.libvirt_volume.volume[5]: Still creating... [2m30s elapsed]
# module.kvm.libvirt_volume.volume[5]: Creation complete after 2m30s [id=/data/vms/t-vm6.qcow2]
# module.kvm.libvirt_cloudinit_disk.cloudinit[3]: Creating...
# module.kvm.libvirt_cloudinit_disk.cloudinit[0]: Creating...
# module.kvm.libvirt_cloudinit_disk.cloudinit[5]: Creating...
# module.kvm.libvirt_cloudinit_disk.cloudinit[1]: Creating...
# module.kvm.libvirt_cloudinit_disk.cloudinit[4]: Creating...
# module.kvm.libvirt_cloudinit_disk.cloudinit[2]: Creating...
# module.kvm.libvirt_cloudinit_disk.cloudinit[3]: Creation complete after 0s [id=/data/vms/cloudinit-t-vm4.iso;54953569-de75-446f-86a6-d2647d3c0aaf]
# module.kvm.libvirt_cloudinit_disk.cloudinit[0]: Creation complete after 0s [id=/data/vms/cloudinit-t-vm1.iso;5e03cfe2-6c4c-44ce-969c-202003131a3f]
# module.kvm.libvirt_cloudinit_disk.cloudinit[1]: Creation complete after 0s [id=/data/vms/cloudinit-t-vm2.iso;027a54fb-3bc8-4a76-82e5-18dd289120ff]
# module.kvm.libvirt_cloudinit_disk.cloudinit[5]: Creation complete after 0s [id=/data/vms/cloudinit-t-vm6.iso;f1247ebd-3d5d-4c47-8d0c-ae5f70c9c415]
# module.kvm.libvirt_cloudinit_disk.cloudinit[4]: Creation complete after 0s [id=/data/vms/cloudinit-t-vm5.iso;7d9ee3c7-7b1b-496c-84f7-ff913ff561db]
# module.kvm.libvirt_cloudinit_disk.cloudinit[2]: Creation complete after 0s [id=/data/vms/cloudinit-t-vm3.iso;78e6735f-ad11-4f47-9b49-84142c7d1541]
# module.kvm.libvirt_domain.vm[4]: Creating...
# module.kvm.libvirt_domain.vm[5]: Creating...
# module.kvm.libvirt_domain.vm[1]: Creating...
# module.kvm.libvirt_domain.vm[3]: Creating...
# module.kvm.libvirt_domain.vm[0]: Creating...
# module.kvm.libvirt_domain.vm[2]: Creating...
# module.kvm.libvirt_domain.vm[4]: Still creating... [10s elapsed]
# module.kvm.libvirt_domain.vm[5]: Still creating... [10s elapsed]
# module.kvm.libvirt_domain.vm[1]: Still creating... [10s elapsed]
# module.kvm.libvirt_domain.vm[2]: Still creating... [10s elapsed]
# module.kvm.libvirt_domain.vm[0]: Still creating... [10s elapsed]
# module.kvm.libvirt_domain.vm[3]: Still creating... [10s elapsed]
# module.kvm.libvirt_domain.vm[5]: Still creating... [20s elapsed]
# module.kvm.libvirt_domain.vm[4]: Still creating... [20s elapsed]
# module.kvm.libvirt_domain.vm[1]: Still creating... [20s elapsed]
# module.kvm.libvirt_domain.vm[3]: Still creating... [20s elapsed]
# module.kvm.libvirt_domain.vm[0]: Still creating... [20s elapsed]
# module.kvm.libvirt_domain.vm[2]: Still creating... [20s elapsed]
# module.kvm.libvirt_domain.vm[4]: Still creating... [30s elapsed]
# module.kvm.libvirt_domain.vm[5]: Still creating... [30s elapsed]
# module.kvm.libvirt_domain.vm[1]: Still creating... [30s elapsed]
# module.kvm.libvirt_domain.vm[0]: Still creating... [30s elapsed]
# module.kvm.libvirt_domain.vm[3]: Still creating... [30s elapsed]
# module.kvm.libvirt_domain.vm[2]: Still creating... [30s elapsed]
# module.kvm.libvirt_domain.vm[0]: Creation complete after 35s [id=19806879-b5ac-49ce-9251-c24efd433935]
# module.kvm.libvirt_domain.vm[5]: Still creating... [40s elapsed]
# module.kvm.libvirt_domain.vm[4]: Still creating... [40s elapsed]
# module.kvm.libvirt_domain.vm[1]: Still creating... [40s elapsed]
# module.kvm.libvirt_domain.vm[3]: Still creating... [40s elapsed]
# module.kvm.libvirt_domain.vm[2]: Still creating... [40s elapsed]
# module.kvm.libvirt_domain.vm[1]: Creation complete after 45s [id=db6b63db-0c8e-4414-a307-0f0c7e3c7dbb]
# module.kvm.libvirt_domain.vm[5]: Creation complete after 45s [id=c2a50c37-6f49-4633-9c3a-4e09c7d7f52f]
# module.kvm.libvirt_domain.vm[4]: Creation complete after 46s [id=582754f1-04ff-493e-ad2d-981a87a25fc4]
# module.kvm.libvirt_domain.vm[3]: Creation complete after 46s [id=abf34304-016f-43cd-a820-ed6639c5b852]
# module.kvm.libvirt_domain.vm[2]: Creation complete after 46s [id=3eeaadc7-e810-420a-a597-5b831bf4b326]
# module.kvm.null_resource.exec[1]: Creating...
# module.kvm.null_resource.exec[2]: Creating...
# module.kvm.null_resource.exec[0]: Creating...
# module.kvm.null_resource.exec[5]: Creating...
# module.kvm.null_resource.exec[4]: Creating...
# module.kvm.null_resource.exec[4]: Provisioning with 'remote-exec'...
# module.kvm.null_resource.exec[3]: Creating...
# module.kvm.null_resource.exec[4] (remote-exec): Connecting to remote host via SSH...
# module.kvm.null_resource.exec[4] (remote-exec):   Host: 192.168.1.148
# module.kvm.null_resource.exec[4] (remote-exec):   User: root
# module.kvm.null_resource.exec[4] (remote-exec):   Password: false
# module.kvm.null_resource.exec[4] (remote-exec):   Private key: true
# module.kvm.null_resource.exec[4] (remote-exec):   Certificate: false
# module.kvm.null_resource.exec[4] (remote-exec):   SSH Agent: false
# module.kvm.null_resource.exec[4] (remote-exec):   Checking Host Key: false
# module.kvm.null_resource.exec[4] (remote-exec):   Target Platform: unix
# module.kvm.null_resource.exec[2]: Provisioning with 'remote-exec'...
# module.kvm.null_resource.exec[2] (remote-exec): Connecting to remote host via SSH...
# module.kvm.null_resource.exec[2] (remote-exec):   Host: 192.168.1.144
# module.kvm.null_resource.exec[2] (remote-exec):   User: root
# module.kvm.null_resource.exec[2] (remote-exec):   Password: false
# module.kvm.null_resource.exec[2] (remote-exec):   Private key: true
# module.kvm.null_resource.exec[2] (remote-exec):   Certificate: false
# module.kvm.null_resource.exec[2] (remote-exec):   SSH Agent: false
# module.kvm.null_resource.exec[2] (remote-exec):   Checking Host Key: false
# module.kvm.null_resource.exec[2] (remote-exec):   Target Platform: unix
# module.kvm.null_resource.exec[0]: Provisioning with 'remote-exec'...
# module.kvm.null_resource.exec[1]: Provisioning with 'remote-exec'...
# module.kvm.null_resource.exec[0] (remote-exec): Connecting to remote host via SSH...
# module.kvm.null_resource.exec[0] (remote-exec):   Host: 192.168.1.182
# module.kvm.null_resource.exec[0] (remote-exec):   User: root
# module.kvm.null_resource.exec[0] (remote-exec):   Password: false
# module.kvm.null_resource.exec[0] (remote-exec):   Private key: true
# module.kvm.null_resource.exec[0] (remote-exec):   Certificate: false
# module.kvm.null_resource.exec[0] (remote-exec):   SSH Agent: false
# module.kvm.null_resource.exec[0] (remote-exec):   Checking Host Key: false
# module.kvm.null_resource.exec[0] (remote-exec):   Target Platform: unix
# module.kvm.null_resource.exec[1] (remote-exec): Connecting to remote host via SSH...
# module.kvm.null_resource.exec[1] (remote-exec):   Host: 192.168.1.114
# module.kvm.null_resource.exec[1] (remote-exec):   User: root
# module.kvm.null_resource.exec[1] (remote-exec):   Password: false
# module.kvm.null_resource.exec[1] (remote-exec):   Private key: true
# module.kvm.null_resource.exec[1] (remote-exec):   Certificate: false
# module.kvm.null_resource.exec[1] (remote-exec):   SSH Agent: false
# module.kvm.null_resource.exec[1] (remote-exec):   Checking Host Key: false
# module.kvm.null_resource.exec[1] (remote-exec):   Target Platform: unix
# module.kvm.null_resource.exec[3]: Provisioning with 'remote-exec'...
# module.kvm.null_resource.exec[5]: Provisioning with 'remote-exec'...
# module.kvm.null_resource.exec[3] (remote-exec): Connecting to remote host via SSH...
# module.kvm.null_resource.exec[3] (remote-exec):   Host: 192.168.1.122
# module.kvm.null_resource.exec[3] (remote-exec):   User: root
# module.kvm.null_resource.exec[3] (remote-exec):   Password: false
# module.kvm.null_resource.exec[3] (remote-exec):   Private key: true
# module.kvm.null_resource.exec[3] (remote-exec):   Certificate: false
# module.kvm.null_resource.exec[3] (remote-exec):   SSH Agent: false
# module.kvm.null_resource.exec[3] (remote-exec):   Checking Host Key: false
# module.kvm.null_resource.exec[3] (remote-exec):   Target Platform: unix
# module.kvm.null_resource.exec[5] (remote-exec): Connecting to remote host via SSH...
# module.kvm.null_resource.exec[5] (remote-exec):   Host: 192.168.1.123
# module.kvm.null_resource.exec[5] (remote-exec):   User: root
# module.kvm.null_resource.exec[5] (remote-exec):   Password: false
# module.kvm.null_resource.exec[5] (remote-exec):   Private key: true
# module.kvm.null_resource.exec[5] (remote-exec):   Certificate: false
# module.kvm.null_resource.exec[5] (remote-exec):   SSH Agent: false
# module.kvm.null_resource.exec[5] (remote-exec):   Checking Host Key: false
# module.kvm.null_resource.exec[5] (remote-exec):   Target Platform: unix
# module.kvm.null_resource.exec[4] (remote-exec): Connected!
# module.kvm.null_resource.exec[3] (remote-exec): Connected!
# module.kvm.null_resource.exec[1] (remote-exec): Connected!
# module.kvm.null_resource.exec[0] (remote-exec): Connected!
# module.kvm.null_resource.exec[2] (remote-exec): Connecting to remote host via SSH...
# module.kvm.null_resource.exec[2] (remote-exec):   Host: 192.168.1.144
# module.kvm.null_resource.exec[2] (remote-exec):   User: root
# module.kvm.null_resource.exec[2] (remote-exec):   Password: false
# module.kvm.null_resource.exec[2] (remote-exec):   Private key: true
# module.kvm.null_resource.exec[2] (remote-exec):   Certificate: false
# module.kvm.null_resource.exec[2] (remote-exec):   SSH Agent: false
# module.kvm.null_resource.exec[2] (remote-exec):   Checking Host Key: false
# module.kvm.null_resource.exec[2] (remote-exec):   Target Platform: unix
# module.kvm.null_resource.exec[5] (remote-exec): Connecting to remote host via SSH...
# module.kvm.null_resource.exec[5] (remote-exec):   Host: 192.168.1.123
# module.kvm.null_resource.exec[5] (remote-exec):   User: root
# module.kvm.null_resource.exec[5] (remote-exec):   Password: false
# module.kvm.null_resource.exec[5] (remote-exec):   Private key: true
# module.kvm.null_resource.exec[5] (remote-exec):   Certificate: false
# module.kvm.null_resource.exec[5] (remote-exec):   SSH Agent: false
# module.kvm.null_resource.exec[5] (remote-exec):   Checking Host Key: false
# module.kvm.null_resource.exec[5] (remote-exec):   Target Platform: unix
# module.kvm.null_resource.exec[2] (remote-exec): Connected!
# module.kvm.null_resource.exec[5] (remote-exec): Connected!
# module.kvm.null_resource.exec[4]: Creation complete after 4s [id=431878380693833904]
# module.kvm.null_resource.exec[1]: Creation complete after 4s [id=7321024465320230294]
# module.kvm.null_resource.exec[3]: Creation complete after 4s [id=1427879863080517002]
# module.kvm.null_resource.exec[0]: Creation complete after 4s [id=435275088429013525]
# module.kvm.null_resource.exec[5]: Creation complete after 6s [id=2412630406802730272]
# module.kvm.null_resource.exec[2]: Creation complete after 9s [id=3298440833351229994]
# 
# Apply complete! Resources: 24 added, 0 changed, 0 destroyed.
# 
# Outputs:
# 
# hostnames = [
#   "t-vm1",
#   "t-vm2",
#   "t-vm3",
#   "t-vm4",
#   "t-vm5",
#   "t-vm6",
# ]
# ips = [
#   tolist([
#     "192.168.1.182",
#   ]),
#   tolist([
#     "192.168.1.114",
#   ]),
#   tolist([
#     "192.168.1.144",
#   ]),
#   tolist([
#     "192.168.1.122",
#   ]),
#   tolist([
#     "192.168.1.148",
#   ]),
#   tolist([
#     "192.168.1.123",
#   ]),
# ]


# Execute o comando abaixo para verificar que a máquina foi criada:
# 
# $ virsh list
#  Id   Name     State
# ------------------------
#  1    docker   running
#  2    k8s      running
#  3    db       running
#  16   t-vm6    running
#  17   t-vm4    running
#  18   t-vm1    running
#  19   t-vm2    running
#  20   t-vm5    running
#  21   t-vm3    running


# Em seguida, obtenha os endereços IP gerados para as máquinas virtuais, conforme abaixo:
# 
# $ terraform output ips
# [
#   tolist([
#     "192.168.1.182",
#   ]),
#   tolist([
#     "192.168.1.114",
#   ]),
#   tolist([
#     "192.168.1.144",
#   ]),
#   tolist([
#     "192.168.1.122",
#   ]),
#   tolist([
#     "192.168.1.148",
#   ]),
#   tolist([
#     "192.168.1.123",
#   ]),
# ]


# Conecte-se por SSH em uma das máquinas virtuais, e verifique se os scripts
# foram executados com sucesso:
# 
# $ ssh root@192.168.1.123
# The authenticity of host '192.168.1.123 (192.168.1.123)' can't be established.
# ECDSA key fingerprint is SHA256:CiKY/G5cO19+8Vhi2jrBsyKYjkaqcKMmpLNBIAuruhI.
# Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
# Warning: Permanently added '192.168.1.123' (ECDSA) to the list of known hosts.
# Welcome to Ubuntu 20.04.6 LTS (GNU/Linux 5.4.0-167-generic x86_64)
# 
#  * Documentation:  https://help.ubuntu.com
#  * Management:     https://landscape.canonical.com
#  * Support:        https://ubuntu.com/advantage
# 
#   System information as of Sat Dec  2 22:53:16 UTC 2023
# 
#   System load:  0.08              Processes:             102
#   Usage of /:   74.1% of 1.96GB   Users logged in:       0
#   Memory usage: 39%               IPv4 address for ens3: 192.168.1.123
#   Swap usage:   0%
# 
# 
# Expanded Security Maintenance for Applications is not enabled.
# 
# 0 updates can be applied immediately.
# 
# Enable ESM Apps to receive additional future security updates.
# See https://ubuntu.com/esm or run: sudo pro status
# 
# New release '22.04.3 LTS' available.
# Run 'do-release-upgrade' to upgrade to it.
# 
# 
# Last login: Sat Dec  2 22:46:44 2023 from 192.168.1.1
# root@ubuntu:~# cat cloud-init.ok
# yes
# root@ubuntu:~# cat setup.txt
# 
# root@ubuntu:~# hostname
# ubuntu
# root@ubuntu:~# echo $HOSTNAME
# ubuntu
# root@ubuntu:~# logout
# Connection to 192.168.1.123 closed.


# Com base na saída acima identique o erro e discuta sobre possíveis correções
# com a turma. Refaça o laboratório com as sugestões abaixo.
# https://stackoverflow.com/questions/68747106/using-the-script-argument-with-remote-exec-terraform
#
#   provisioner "file" {
#     source      = "script.sh"
#     destination = "/tmp/script.sh"
#   }
# 
#   provisioner "remote-exec" {
#     inline = [
#       "chmod +x /tmp/script.sh",
#       "/tmp/script.sh",
#     ]
#   }


# Execute o comando "terraform destroy" para destruir o ambiente, conforme abaixo:
# 
# $ terraform apply -auto-approve -destroy 
# module.kvm.data.template_file.network_config: Reading...
# module.kvm.data.template_file.user_data[5]: Reading...
# module.kvm.data.template_file.user_data[3]: Reading...
# module.kvm.data.template_file.user_data[4]: Reading...
# module.kvm.data.template_file.network_config: Read complete after 0s [id=98585aaf6c6ab040bbb6943114277cec19c43ff9543db03ed0d772104e8cf42e]
# module.kvm.data.template_file.user_data[2]: Reading...
# module.kvm.data.template_file.user_data[1]: Reading...
# module.kvm.data.template_file.user_data[0]: Reading...
# module.kvm.data.template_file.user_data[3]: Read complete after 0s [id=4550334f89885a433a7e230e1c373f3cc1006f412277dbeeac9e84e754704383]
# module.kvm.data.template_file.user_data[5]: Read complete after 0s [id=4550334f89885a433a7e230e1c373f3cc1006f412277dbeeac9e84e754704383]
# module.kvm.data.template_file.user_data[4]: Read complete after 0s [id=4550334f89885a433a7e230e1c373f3cc1006f412277dbeeac9e84e754704383]
# module.kvm.data.template_file.user_data[2]: Read complete after 0s [id=4550334f89885a433a7e230e1c373f3cc1006f412277dbeeac9e84e754704383]
# module.kvm.data.template_file.user_data[0]: Read complete after 0s [id=4550334f89885a433a7e230e1c373f3cc1006f412277dbeeac9e84e754704383]
# module.kvm.data.template_file.user_data[1]: Read complete after 0s [id=4550334f89885a433a7e230e1c373f3cc1006f412277dbeeac9e84e754704383]
# module.kvm.libvirt_volume.volume[0]: Refreshing state... [id=/data/vms/t-vm1.qcow2]
# module.kvm.libvirt_volume.volume[1]: Refreshing state... [id=/data/vms/t-vm2.qcow2]
# module.kvm.libvirt_volume.volume[3]: Refreshing state... [id=/data/vms/t-vm4.qcow2]
# module.kvm.libvirt_volume.volume[4]: Refreshing state... [id=/data/vms/t-vm5.qcow2]
# module.kvm.libvirt_volume.volume[2]: Refreshing state... [id=/data/vms/t-vm3.qcow2]
# module.kvm.libvirt_volume.volume[5]: Refreshing state... [id=/data/vms/t-vm6.qcow2]
# module.kvm.libvirt_cloudinit_disk.cloudinit[0]: Refreshing state... [id=/data/vms/cloudinit-t-vm1.iso;bea45669-b243-40fb-8c85-d0740378e3aa]
# module.kvm.libvirt_cloudinit_disk.cloudinit[4]: Refreshing state... [id=/data/vms/cloudinit-t-vm5.iso;000daa01-1fc4-4739-9f82-e572cfe9d0b6]
# module.kvm.libvirt_cloudinit_disk.cloudinit[5]: Refreshing state... [id=/data/vms/cloudinit-t-vm6.iso;11472661-2432-4561-ab4d-3855bbadd473]
# module.kvm.libvirt_cloudinit_disk.cloudinit[1]: Refreshing state... [id=/data/vms/cloudinit-t-vm2.iso;4e51eb65-331c-4c61-bdb2-5e239cf005e3]
# module.kvm.libvirt_cloudinit_disk.cloudinit[3]: Refreshing state... [id=/data/vms/cloudinit-t-vm4.iso;4b357ada-2426-48b3-8cc4-8f071e0ff8ff]
# module.kvm.libvirt_cloudinit_disk.cloudinit[2]: Refreshing state... [id=/data/vms/cloudinit-t-vm3.iso;0b69d23a-2622-45b0-9333-954ab89c6a8d]
# module.kvm.libvirt_domain.vm[5]: Refreshing state... [id=0a44c010-5ae9-4d22-a43d-894e8514d5d7]
# module.kvm.libvirt_domain.vm[3]: Refreshing state... [id=91ef13c9-27e5-4175-8310-c9b1aab0a6b4]
# module.kvm.libvirt_domain.vm[2]: Refreshing state... [id=c4c4a547-e6c3-4a02-9121-694c61ca3535]
# module.kvm.libvirt_domain.vm[1]: Refreshing state... [id=654e6984-1ddb-44ed-83bd-8cdf9c59280e]
# module.kvm.libvirt_domain.vm[4]: Refreshing state... [id=3b94b87e-626d-4b7e-a9c3-3b0e461e72d8]
# module.kvm.libvirt_domain.vm[0]: Refreshing state... [id=ec5172a7-eaf0-4195-8ae4-f3ba46dea0ba]
# module.kvm.null_resource.exec[0]: Refreshing state... [id=1618270682695655676]
# module.kvm.null_resource.exec[5]: Refreshing state... [id=6865076248482073195]
# module.kvm.null_resource.exec[1]: Refreshing state... [id=7690212924572871237]
# module.kvm.null_resource.exec[2]: Refreshing state... [id=5729096863399112430]
# module.kvm.null_resource.exec[4]: Refreshing state... [id=413436818846657625]
# module.kvm.null_resource.exec[3]: Refreshing state... [id=3056188517699741611]
# 
# Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the
# following symbols:
#   - destroy
# 
# Terraform will perform the following actions:
# 
#   # module.kvm.libvirt_cloudinit_disk.cloudinit[0] will be destroyed
#   - resource "libvirt_cloudinit_disk" "cloudinit" {
#       - id             = "/data/vms/cloudinit-t-vm1.iso;bea45669-b243-40fb-8c85-d0740378e3aa" -> null
#       - name           = "cloudinit-t-vm1.iso" -> null
#       - network_config = <<-EOT
#             version: 2
#             ethernets:
#               all:
#                 match:
#                   name: e*
#                 dhcp4: true
#                 dhcp6: false
#         EOT -> null
#       - pool           = "VMs" -> null
#       - user_data      = <<-EOT
#             #cloud-config
#             # vim: syntax=yaml
#             ssh_pwauth: true
#             chpasswd:
#               list: |
#                 root:linux
#                 ubuntu:linux
#               expire: false
# 
#             disable_root: false
# 
#             users:
#               - name: root
#                 ssh_authorized_keys:
#                   - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDDerMYphqZbqxnAQ4fTzTFKq865w+1arOORCtzj8yX9gv29EQPBQlK5VoSlLk8TEax/0MYtrb4GhPvn30eialp59EtO4A6SiFVR0JUKBen3z4QixnQXsBjNLOI5qKlIYN62RDnzv2p4WbggNsLPLkFoqfZZaZjF7oXvQtrIJqXEY77roQZnUFQLhJox0G5HNJgUJVTkrAedpcR9UpB48d/ji+uXXeoZbxsGbJZmv/xENnbSqq4R5QLJJ0gTaP2gdRPBxifT1Hm0XzvQQtDuN/OWuNK4A2hVCkvYMzvp5Pa2XzKskWjjawITMUuHQraVEWzuIXc1N+xn7eTZV8X4OrZIDU17IQZn4GlYhwgRr+4rvVoM+y1WiIc+vvQvA1rIdYNB/zKVqNNPNxKRrjCUsMHPvZeDWLcyY4mexagk0v1R9UOXkp/taDiUR5XFh9nY/Va9AeWwXsNSHHxfhn9ol9Q/+PFYLWKTlJwCHyWGNpqs5URNGNCvTjMA+IeEt0AmYE= azureroot@t01-tf201
# 
#             runcmd:
#               - echo "yes" > /root/cloud-init.ok
#         EOT -> null
#     }
# 
#   # module.kvm.libvirt_cloudinit_disk.cloudinit[1] will be destroyed
#   - resource "libvirt_cloudinit_disk" "cloudinit" {
#       - id             = "/data/vms/cloudinit-t-vm2.iso;4e51eb65-331c-4c61-bdb2-5e239cf005e3" -> null
#       - name           = "cloudinit-t-vm2.iso" -> null
#       - network_config = <<-EOT
#             version: 2
#             ethernets:
#               all:
#                 match:
#                   name: e*
#                 dhcp4: true
#                 dhcp6: false
#         EOT -> null
#       - pool           = "VMs" -> null
#       - user_data      = <<-EOT
#             #cloud-config
#             # vim: syntax=yaml
#             ssh_pwauth: true
#             chpasswd:
#               list: |
#                 root:linux
#                 ubuntu:linux
#               expire: false
# 
#             disable_root: false
# 
#             users:
#               - name: root
#                 ssh_authorized_keys:
#                   - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDDerMYphqZbqxnAQ4fTzTFKq865w+1arOORCtzj8yX9gv29EQPBQlK5VoSlLk8TEax/0MYtrb4GhPvn30eialp59EtO4A6SiFVR0JUKBen3z4QixnQXsBjNLOI5qKlIYN62RDnzv2p4WbggNsLPLkFoqfZZaZjF7oXvQtrIJqXEY77roQZnUFQLhJox0G5HNJgUJVTkrAedpcR9UpB48d/ji+uXXeoZbxsGbJZmv/xENnbSqq4R5QLJJ0gTaP2gdRPBxifT1Hm0XzvQQtDuN/OWuNK4A2hVCkvYMzvp5Pa2XzKskWjjawITMUuHQraVEWzuIXc1N+xn7eTZV8X4OrZIDU17IQZn4GlYhwgRr+4rvVoM+y1WiIc+vvQvA1rIdYNB/zKVqNNPNxKRrjCUsMHPvZeDWLcyY4mexagk0v1R9UOXkp/taDiUR5XFh9nY/Va9AeWwXsNSHHxfhn9ol9Q/+PFYLWKTlJwCHyWGNpqs5URNGNCvTjMA+IeEt0AmYE= azureroot@t01-tf201
# 
#             runcmd:
#               - echo "yes" > /root/cloud-init.ok
#         EOT -> null
#     }
# 
#   # module.kvm.libvirt_cloudinit_disk.cloudinit[2] will be destroyed
#   - resource "libvirt_cloudinit_disk" "cloudinit" {
#       - id             = "/data/vms/cloudinit-t-vm3.iso;0b69d23a-2622-45b0-9333-954ab89c6a8d" -> null
#       - name           = "cloudinit-t-vm3.iso" -> null
#       - network_config = <<-EOT
#             version: 2
#             ethernets:
#               all:
#                 match:
#                   name: e*
#                 dhcp4: true
#                 dhcp6: false
#         EOT -> null
#       - pool           = "VMs" -> null
#       - user_data      = <<-EOT
#             #cloud-config
#             # vim: syntax=yaml
#             ssh_pwauth: true
#             chpasswd:
#               list: |
#                 root:linux
#                 ubuntu:linux
#               expire: false
# 
#             disable_root: false
# 
#             users:
#               - name: root
#                 ssh_authorized_keys:
#                   - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDDerMYphqZbqxnAQ4fTzTFKq865w+1arOORCtzj8yX9gv29EQPBQlK5VoSlLk8TEax/0MYtrb4GhPvn30eialp59EtO4A6SiFVR0JUKBen3z4QixnQXsBjNLOI5qKlIYN62RDnzv2p4WbggNsLPLkFoqfZZaZjF7oXvQtrIJqXEY77roQZnUFQLhJox0G5HNJgUJVTkrAedpcR9UpB48d/ji+uXXeoZbxsGbJZmv/xENnbSqq4R5QLJJ0gTaP2gdRPBxifT1Hm0XzvQQtDuN/OWuNK4A2hVCkvYMzvp5Pa2XzKskWjjawITMUuHQraVEWzuIXc1N+xn7eTZV8X4OrZIDU17IQZn4GlYhwgRr+4rvVoM+y1WiIc+vvQvA1rIdYNB/zKVqNNPNxKRrjCUsMHPvZeDWLcyY4mexagk0v1R9UOXkp/taDiUR5XFh9nY/Va9AeWwXsNSHHxfhn9ol9Q/+PFYLWKTlJwCHyWGNpqs5URNGNCvTjMA+IeEt0AmYE= azureroot@t01-tf201
# 
#             runcmd:
#               - echo "yes" > /root/cloud-init.ok
#         EOT -> null
#     }
# 
#   # module.kvm.libvirt_cloudinit_disk.cloudinit[3] will be destroyed
#   - resource "libvirt_cloudinit_disk" "cloudinit" {
#       - id             = "/data/vms/cloudinit-t-vm4.iso;4b357ada-2426-48b3-8cc4-8f071e0ff8ff" -> null
#       - name           = "cloudinit-t-vm4.iso" -> null
#       - network_config = <<-EOT
#             version: 2
#             ethernets:
#               all:
#                 match:
#                   name: e*
#                 dhcp4: true
#                 dhcp6: false
#         EOT -> null
#       - pool           = "VMs" -> null
#       - user_data      = <<-EOT
#             #cloud-config
#             # vim: syntax=yaml
#             ssh_pwauth: true
#             chpasswd:
#               list: |
#                 root:linux
#                 ubuntu:linux
#               expire: false
# 
#             disable_root: false
# 
#             users:
#               - name: root
#                 ssh_authorized_keys:
#                   - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDDerMYphqZbqxnAQ4fTzTFKq865w+1arOORCtzj8yX9gv29EQPBQlK5VoSlLk8TEax/0MYtrb4GhPvn30eialp59EtO4A6SiFVR0JUKBen3z4QixnQXsBjNLOI5qKlIYN62RDnzv2p4WbggNsLPLkFoqfZZaZjF7oXvQtrIJqXEY77roQZnUFQLhJox0G5HNJgUJVTkrAedpcR9UpB48d/ji+uXXeoZbxsGbJZmv/xENnbSqq4R5QLJJ0gTaP2gdRPBxifT1Hm0XzvQQtDuN/OWuNK4A2hVCkvYMzvp5Pa2XzKskWjjawITMUuHQraVEWzuIXc1N+xn7eTZV8X4OrZIDU17IQZn4GlYhwgRr+4rvVoM+y1WiIc+vvQvA1rIdYNB/zKVqNNPNxKRrjCUsMHPvZeDWLcyY4mexagk0v1R9UOXkp/taDiUR5XFh9nY/Va9AeWwXsNSHHxfhn9ol9Q/+PFYLWKTlJwCHyWGNpqs5URNGNCvTjMA+IeEt0AmYE= azureroot@t01-tf201
# 
#             runcmd:
#               - echo "yes" > /root/cloud-init.ok
#         EOT -> null
#     }
# 
#   # module.kvm.libvirt_cloudinit_disk.cloudinit[4] will be destroyed
#   - resource "libvirt_cloudinit_disk" "cloudinit" {
#       - id             = "/data/vms/cloudinit-t-vm5.iso;000daa01-1fc4-4739-9f82-e572cfe9d0b6" -> null
#       - name           = "cloudinit-t-vm5.iso" -> null
#       - network_config = <<-EOT
#             version: 2
#             ethernets:
#               all:
#                 match:
#                   name: e*
#                 dhcp4: true
#                 dhcp6: false
#         EOT -> null
#       - pool           = "VMs" -> null
#       - user_data      = <<-EOT
#             #cloud-config
#             # vim: syntax=yaml
#             ssh_pwauth: true
#             chpasswd:
#               list: |
#                 root:linux
#                 ubuntu:linux
#               expire: false
# 
#             disable_root: false
# 
#             users:
#               - name: root
#                 ssh_authorized_keys:
#                   - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDDerMYphqZbqxnAQ4fTzTFKq865w+1arOORCtzj8yX9gv29EQPBQlK5VoSlLk8TEax/0MYtrb4GhPvn30eialp59EtO4A6SiFVR0JUKBen3z4QixnQXsBjNLOI5qKlIYN62RDnzv2p4WbggNsLPLkFoqfZZaZjF7oXvQtrIJqXEY77roQZnUFQLhJox0G5HNJgUJVTkrAedpcR9UpB48d/ji+uXXeoZbxsGbJZmv/xENnbSqq4R5QLJJ0gTaP2gdRPBxifT1Hm0XzvQQtDuN/OWuNK4A2hVCkvYMzvp5Pa2XzKskWjjawITMUuHQraVEWzuIXc1N+xn7eTZV8X4OrZIDU17IQZn4GlYhwgRr+4rvVoM+y1WiIc+vvQvA1rIdYNB/zKVqNNPNxKRrjCUsMHPvZeDWLcyY4mexagk0v1R9UOXkp/taDiUR5XFh9nY/Va9AeWwXsNSHHxfhn9ol9Q/+PFYLWKTlJwCHyWGNpqs5URNGNCvTjMA+IeEt0AmYE= azureroot@t01-tf201
# 
#             runcmd:
#               - echo "yes" > /root/cloud-init.ok
#         EOT -> null
#     }
# 
#   # module.kvm.libvirt_cloudinit_disk.cloudinit[5] will be destroyed
#   - resource "libvirt_cloudinit_disk" "cloudinit" {
#       - id             = "/data/vms/cloudinit-t-vm6.iso;11472661-2432-4561-ab4d-3855bbadd473" -> null
#       - name           = "cloudinit-t-vm6.iso" -> null
#       - network_config = <<-EOT
#             version: 2
#             ethernets:
#               all:
#                 match:
#                   name: e*
#                 dhcp4: true
#                 dhcp6: false
#         EOT -> null
#       - pool           = "VMs" -> null
#       - user_data      = <<-EOT
#             #cloud-config
#             # vim: syntax=yaml
#             ssh_pwauth: true
#             chpasswd:
#               list: |
#                 root:linux
#                 ubuntu:linux
#               expire: false
# 
#             disable_root: false
# 
#             users:
#               - name: root
#                 ssh_authorized_keys:
#                   - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDDerMYphqZbqxnAQ4fTzTFKq865w+1arOORCtzj8yX9gv29EQPBQlK5VoSlLk8TEax/0MYtrb4GhPvn30eialp59EtO4A6SiFVR0JUKBen3z4QixnQXsBjNLOI5qKlIYN62RDnzv2p4WbggNsLPLkFoqfZZaZjF7oXvQtrIJqXEY77roQZnUFQLhJox0G5HNJgUJVTkrAedpcR9UpB48d/ji+uXXeoZbxsGbJZmv/xENnbSqq4R5QLJJ0gTaP2gdRPBxifT1Hm0XzvQQtDuN/OWuNK4A2hVCkvYMzvp5Pa2XzKskWjjawITMUuHQraVEWzuIXc1N+xn7eTZV8X4OrZIDU17IQZn4GlYhwgRr+4rvVoM+y1WiIc+vvQvA1rIdYNB/zKVqNNPNxKRrjCUsMHPvZeDWLcyY4mexagk0v1R9UOXkp/taDiUR5XFh9nY/Va9AeWwXsNSHHxfhn9ol9Q/+PFYLWKTlJwCHyWGNpqs5URNGNCvTjMA+IeEt0AmYE= azureroot@t01-tf201
# 
#             runcmd:
#               - echo "yes" > /root/cloud-init.ok
#         EOT -> null
#     }
# 
#   # module.kvm.libvirt_domain.vm[0] will be destroyed
#   - resource "libvirt_domain" "vm" {
#       - arch        = "x86_64" -> null
#       - autostart   = false -> null
#       - cloudinit   = "/data/vms/cloudinit-t-vm1.iso;bea45669-b243-40fb-8c85-d0740378e3aa" -> null
#       - cmdline     = [] -> null
#       - emulator    = "/usr/bin/qemu-system-x86_64" -> null
#       - fw_cfg_name = "opt/com.coreos/config" -> null
#       - id          = "ec5172a7-eaf0-4195-8ae4-f3ba46dea0ba" -> null
#       - machine     = "pc" -> null
#       - memory      = 640 -> null
#       - name        = "t-vm1" -> null
#       - qemu_agent  = false -> null
#       - running     = true -> null
#       - type        = "kvm" -> null
#       - vcpu        = 1 -> null
# 
#       - console {
#           - source_host    = "127.0.0.1" -> null
#           - source_service = "0" -> null
#           - target_port    = "0" -> null
#           - target_type    = "serial" -> null
#           - type           = "pty" -> null
#         }
#       - console {
#           - source_host    = "127.0.0.1" -> null
#           - source_service = "0" -> null
#           - target_port    = "1" -> null
#           - target_type    = "virtio" -> null
#           - type           = "pty" -> null
#         }
# 
#       - cpu {
#           - mode = "custom" -> null
#         }
# 
#       - disk {
#           - scsi      = true -> null
#           - volume_id = "/data/vms/t-vm1.qcow2" -> null
#           - wwn       = "05abcdabab2f2a3b" -> null
#         }
# 
#       - graphics {
#           - autoport       = true -> null
#           - listen_address = "127.0.0.1" -> null
#           - listen_type    = "address" -> null
#           - type           = "spice" -> null
#           - websocket      = 0 -> null
#         }
# 
#       - network_interface {
#           - addresses      = [
#               - "192.168.1.187",
#             ] -> null
#           - hostname       = "t-vm1" -> null
#           - mac            = "52:54:00:D6:92:D3" -> null
#           - network_id     = "c36decbb-311f-4e34-b1d3-dada42179db0" -> null
#           - network_name   = "default" -> null
#           - wait_for_lease = true -> null
#         }
#     }
# 
#   # module.kvm.libvirt_domain.vm[1] will be destroyed
#   - resource "libvirt_domain" "vm" {
#       - arch        = "x86_64" -> null
#       - autostart   = false -> null
#       - cloudinit   = "/data/vms/cloudinit-t-vm2.iso;4e51eb65-331c-4c61-bdb2-5e239cf005e3" -> null
#       - cmdline     = [] -> null
#       - emulator    = "/usr/bin/qemu-system-x86_64" -> null
#       - fw_cfg_name = "opt/com.coreos/config" -> null
#       - id          = "654e6984-1ddb-44ed-83bd-8cdf9c59280e" -> null
#       - machine     = "pc" -> null
#       - memory      = 512 -> null
#       - name        = "t-vm2" -> null
#       - qemu_agent  = false -> null
#       - running     = true -> null
#       - type        = "kvm" -> null
#       - vcpu        = 2 -> null
# 
#       - console {
#           - source_host    = "127.0.0.1" -> null
#           - source_service = "0" -> null
#           - target_port    = "0" -> null
#           - target_type    = "serial" -> null
#           - type           = "pty" -> null
#         }
#       - console {
#           - source_host    = "127.0.0.1" -> null
#           - source_service = "0" -> null
#           - target_port    = "1" -> null
#           - target_type    = "virtio" -> null
#           - type           = "pty" -> null
#         }
# 
#       - cpu {
#           - mode = "custom" -> null
#         }
# 
#       - disk {
#           - scsi      = true -> null
#           - volume_id = "/data/vms/t-vm2.qcow2" -> null
#           - wwn       = "05abcd554aaadd5c" -> null
#         }
# 
#       - graphics {
#           - autoport       = true -> null
#           - listen_address = "127.0.0.1" -> null
#           - listen_type    = "address" -> null
#           - type           = "spice" -> null
#           - websocket      = 0 -> null
#         }
# 
#       - network_interface {
#           - addresses      = [
#               - "192.168.1.116",
#             ] -> null
#           - hostname       = "t-vm2" -> null
#           - mac            = "52:54:00:22:61:BF" -> null
#           - network_id     = "c36decbb-311f-4e34-b1d3-dada42179db0" -> null
#           - network_name   = "default" -> null
#           - wait_for_lease = true -> null
#         }
#     }
# 
#   # module.kvm.libvirt_domain.vm[2] will be destroyed
#   - resource "libvirt_domain" "vm" {
#       - arch        = "x86_64" -> null
#       - autostart   = false -> null
#       - cloudinit   = "/data/vms/cloudinit-t-vm3.iso;0b69d23a-2622-45b0-9333-954ab89c6a8d" -> null
#       - cmdline     = [] -> null
#       - emulator    = "/usr/bin/qemu-system-x86_64" -> null
#       - fw_cfg_name = "opt/com.coreos/config" -> null
#       - id          = "c4c4a547-e6c3-4a02-9121-694c61ca3535" -> null
#       - machine     = "pc" -> null
#       - memory      = 512 -> null
#       - name        = "t-vm3" -> null
#       - qemu_agent  = false -> null
#       - running     = true -> null
#       - type        = "kvm" -> null
#       - vcpu        = 1 -> null
# 
#       - console {
#           - source_host    = "127.0.0.1" -> null
#           - source_service = "0" -> null
#           - target_port    = "0" -> null
#           - target_type    = "serial" -> null
#           - type           = "pty" -> null
#         }
#       - console {
#           - source_host    = "127.0.0.1" -> null
#           - source_service = "0" -> null
#           - target_port    = "1" -> null
#           - target_type    = "virtio" -> null
#           - type           = "pty" -> null
#         }
# 
#       - cpu {
#           - mode = "custom" -> null
#         }
# 
#       - disk {
#           - scsi      = true -> null
#           - volume_id = "/data/vms/t-vm3.qcow2" -> null
#           - wwn       = "05abcdd8b9275cd3" -> null
#         }
# 
#       - graphics {
#           - autoport       = true -> null
#           - listen_address = "127.0.0.1" -> null
#           - listen_type    = "address" -> null
#           - type           = "spice" -> null
#           - websocket      = 0 -> null
#         }
# 
#       - network_interface {
#           - addresses      = [
#               - "192.168.1.127",
#             ] -> null
#           - hostname       = "t-vm3" -> null
#           - mac            = "52:54:00:4E:25:17" -> null
#           - network_id     = "c36decbb-311f-4e34-b1d3-dada42179db0" -> null
#           - network_name   = "default" -> null
#           - wait_for_lease = true -> null
#         }
#     }
# 
#   # module.kvm.libvirt_domain.vm[3] will be destroyed
#   - resource "libvirt_domain" "vm" {
#       - arch        = "x86_64" -> null
#       - autostart   = false -> null
#       - cloudinit   = "/data/vms/cloudinit-t-vm4.iso;4b357ada-2426-48b3-8cc4-8f071e0ff8ff" -> null
#       - cmdline     = [] -> null
#       - emulator    = "/usr/bin/qemu-system-x86_64" -> null
#       - fw_cfg_name = "opt/com.coreos/config" -> null
#       - id          = "91ef13c9-27e5-4175-8310-c9b1aab0a6b4" -> null
#       - machine     = "pc" -> null
#       - memory      = 512 -> null
#       - name        = "t-vm4" -> null
#       - qemu_agent  = false -> null
#       - running     = true -> null
#       - type        = "kvm" -> null
#       - vcpu        = 1 -> null
# 
#       - console {
#           - source_host    = "127.0.0.1" -> null
#           - source_service = "0" -> null
#           - target_port    = "0" -> null
#           - target_type    = "serial" -> null
#           - type           = "pty" -> null
#         }
#       - console {
#           - source_host    = "127.0.0.1" -> null
#           - source_service = "0" -> null
#           - target_port    = "1" -> null
#           - target_type    = "virtio" -> null
#           - type           = "pty" -> null
#         }
# 
#       - cpu {
#           - mode = "custom" -> null
#         }
# 
#       - disk {
#           - scsi      = true -> null
#           - volume_id = "/data/vms/t-vm4.qcow2" -> null
#           - wwn       = "05abcd4de236697c" -> null
#         }
# 
#       - graphics {
#           - autoport       = true -> null
#           - listen_address = "127.0.0.1" -> null
#           - listen_type    = "address" -> null
#           - type           = "spice" -> null
#           - websocket      = 0 -> null
#         }
# 
#       - network_interface {
#           - addresses      = [
#               - "192.168.1.113",
#             ] -> null
#           - hostname       = "t-vm4" -> null
#           - mac            = "52:54:00:3E:C5:74" -> null
#           - network_id     = "c36decbb-311f-4e34-b1d3-dada42179db0" -> null
#           - network_name   = "default" -> null
#           - wait_for_lease = true -> null
#         }
#     }
# 
#   # module.kvm.libvirt_domain.vm[4] will be destroyed
#   - resource "libvirt_domain" "vm" {
#       - arch        = "x86_64" -> null
#       - autostart   = false -> null
#       - cloudinit   = "/data/vms/cloudinit-t-vm5.iso;000daa01-1fc4-4739-9f82-e572cfe9d0b6" -> null
#       - cmdline     = [] -> null
#       - emulator    = "/usr/bin/qemu-system-x86_64" -> null
#       - fw_cfg_name = "opt/com.coreos/config" -> null
#       - id          = "3b94b87e-626d-4b7e-a9c3-3b0e461e72d8" -> null
#       - machine     = "pc" -> null
#       - memory      = 512 -> null
#       - name        = "t-vm5" -> null
#       - qemu_agent  = false -> null
#       - running     = true -> null
#       - type        = "kvm" -> null
#       - vcpu        = 1 -> null
# 
#       - console {
#           - source_host    = "127.0.0.1" -> null
#           - source_service = "0" -> null
#           - target_port    = "0" -> null
#           - target_type    = "serial" -> null
#           - type           = "pty" -> null
#         }
#       - console {
#           - source_host    = "127.0.0.1" -> null
#           - source_service = "0" -> null
#           - target_port    = "1" -> null
#           - target_type    = "virtio" -> null
#           - type           = "pty" -> null
#         }
# 
#       - cpu {
#           - mode = "custom" -> null
#         }
# 
#       - disk {
#           - scsi      = true -> null
#           - volume_id = "/data/vms/t-vm5.qcow2" -> null
#           - wwn       = "05abcd70a2f14b00" -> null
#         }
# 
#       - graphics {
#           - autoport       = true -> null
#           - listen_address = "127.0.0.1" -> null
#           - listen_type    = "address" -> null
#           - type           = "spice" -> null
#           - websocket      = 0 -> null
#         }
# 
#       - network_interface {
#           - addresses      = [
#               - "192.168.1.190",
#             ] -> null
#           - hostname       = "t-vm5" -> null
#           - mac            = "52:54:00:DA:D6:73" -> null
#           - network_id     = "c36decbb-311f-4e34-b1d3-dada42179db0" -> null
#           - network_name   = "default" -> null
#           - wait_for_lease = true -> null
#         }
#     }
# 
#   # module.kvm.libvirt_domain.vm[5] will be destroyed
#   - resource "libvirt_domain" "vm" {
#       - arch        = "x86_64" -> null
#       - autostart   = false -> null
#       - cloudinit   = "/data/vms/cloudinit-t-vm6.iso;11472661-2432-4561-ab4d-3855bbadd473" -> null
#       - cmdline     = [] -> null
#       - emulator    = "/usr/bin/qemu-system-x86_64" -> null
#       - fw_cfg_name = "opt/com.coreos/config" -> null
#       - id          = "0a44c010-5ae9-4d22-a43d-894e8514d5d7" -> null
#       - machine     = "pc" -> null
#       - memory      = 512 -> null
#       - name        = "t-vm6" -> null
#       - qemu_agent  = false -> null
#       - running     = true -> null
#       - type        = "kvm" -> null
#       - vcpu        = 1 -> null
# 
#       - console {
#           - source_host    = "127.0.0.1" -> null
#           - source_service = "0" -> null
#           - target_port    = "0" -> null
#           - target_type    = "serial" -> null
#           - type           = "pty" -> null
#         }
#       - console {
#           - source_host    = "127.0.0.1" -> null
#           - source_service = "0" -> null
#           - target_port    = "1" -> null
#           - target_type    = "virtio" -> null
#           - type           = "pty" -> null
#         }
# 
#       - cpu {
#           - mode = "custom" -> null
#         }
# 
#       - disk {
#           - scsi      = true -> null
#           - volume_id = "/data/vms/t-vm6.qcow2" -> null
#           - wwn       = "05abcdb9011b1c4e" -> null
#         }
# 
#       - graphics {
#           - autoport       = true -> null
#           - listen_address = "127.0.0.1" -> null
#           - listen_type    = "address" -> null
#           - type           = "spice" -> null
#           - websocket      = 0 -> null
#         }
# 
#       - network_interface {
#           - addresses      = [
#               - "192.168.1.151",
#             ] -> null
#           - hostname       = "t-vm6" -> null
#           - mac            = "52:54:00:1E:51:96" -> null
#           - network_id     = "c36decbb-311f-4e34-b1d3-dada42179db0" -> null
#           - network_name   = "default" -> null
#           - wait_for_lease = true -> null
#         }
#     }
# 
#   # module.kvm.libvirt_volume.volume[0] will be destroyed
#   - resource "libvirt_volume" "volume" {
#       - format = "qcow2" -> null
#       - id     = "/data/vms/t-vm1.qcow2" -> null
#       - name   = "t-vm1.qcow2" -> null
#       - pool   = "VMs" -> null
#       - size   = 2361393152 -> null
#       - source = "https://cloud-images.ubuntu.com/releases/focal/release/ubuntu-20.04-server-cloudimg-amd64.img" -> null
#     }
# 
#   # module.kvm.libvirt_volume.volume[1] will be destroyed
#   - resource "libvirt_volume" "volume" {
#       - format = "qcow2" -> null
#       - id     = "/data/vms/t-vm2.qcow2" -> null
#       - name   = "t-vm2.qcow2" -> null
#       - pool   = "VMs" -> null
#       - size   = 2361393152 -> null
#       - source = "https://cloud-images.ubuntu.com/releases/focal/release/ubuntu-20.04-server-cloudimg-amd64.img" -> null
#     }
# 
#   # module.kvm.libvirt_volume.volume[2] will be destroyed
#   - resource "libvirt_volume" "volume" {
#       - format = "qcow2" -> null
#       - id     = "/data/vms/t-vm3.qcow2" -> null
#       - name   = "t-vm3.qcow2" -> null
#       - pool   = "VMs" -> null
#       - size   = 2361393152 -> null
#       - source = "https://cloud-images.ubuntu.com/releases/focal/release/ubuntu-20.04-server-cloudimg-amd64.img" -> null
#     }
# 
#   # module.kvm.libvirt_volume.volume[3] will be destroyed
#   - resource "libvirt_volume" "volume" {
#       - format = "qcow2" -> null
#       - id     = "/data/vms/t-vm4.qcow2" -> null
#       - name   = "t-vm4.qcow2" -> null
#       - pool   = "VMs" -> null
#       - size   = 2361393152 -> null
#       - source = "https://cloud-images.ubuntu.com/releases/focal/release/ubuntu-20.04-server-cloudimg-amd64.img" -> null
#     }
# 
#   # module.kvm.libvirt_volume.volume[4] will be destroyed
#   - resource "libvirt_volume" "volume" {
#       - format = "qcow2" -> null
#       - id     = "/data/vms/t-vm5.qcow2" -> null
#       - name   = "t-vm5.qcow2" -> null
#       - pool   = "VMs" -> null
#       - size   = 2361393152 -> null
#       - source = "https://cloud-images.ubuntu.com/releases/focal/release/ubuntu-20.04-server-cloudimg-amd64.img" -> null
#     }
# 
#   # module.kvm.libvirt_volume.volume[5] will be destroyed
#   - resource "libvirt_volume" "volume" {
#       - format = "qcow2" -> null
#       - id     = "/data/vms/t-vm6.qcow2" -> null
#       - name   = "t-vm6.qcow2" -> null
#       - pool   = "VMs" -> null
#       - size   = 2361393152 -> null
#       - source = "https://cloud-images.ubuntu.com/releases/focal/release/ubuntu-20.04-server-cloudimg-amd64.img" -> null
#     }
# 
#   # module.kvm.null_resource.exec[0] will be destroyed
#   - resource "null_resource" "exec" {
#       - id = "1618270682695655676" -> null
#     }
# 
#   # module.kvm.null_resource.exec[1] will be destroyed
#   - resource "null_resource" "exec" {
#       - id = "7690212924572871237" -> null
#     }
# 
#   # module.kvm.null_resource.exec[2] will be destroyed
#   - resource "null_resource" "exec" {
#       - id = "5729096863399112430" -> null
#     }
# 
#   # module.kvm.null_resource.exec[3] will be destroyed
#   - resource "null_resource" "exec" {
#       - id = "3056188517699741611" -> null
#     }
# 
#   # module.kvm.null_resource.exec[4] will be destroyed
#   - resource "null_resource" "exec" {
#       - id = "413436818846657625" -> null
#     }
# 
#   # module.kvm.null_resource.exec[5] will be destroyed
#   - resource "null_resource" "exec" {
#       - id = "6865076248482073195" -> null
#     }
# 
# Plan: 0 to add, 0 to change, 24 to destroy.
# 
# Changes to Outputs:
#   - hostnames = [
#       - "t-vm1",
#       - "t-vm2",
#       - "t-vm3",
#       - "t-vm4",
#       - "t-vm5",
#       - "t-vm6",
#     ] -> null
#   - ips       = [
#       - [
#           - "192.168.1.187",
#         ],
#       - [
#           - "192.168.1.116",
#         ],
#       - [
#           - "192.168.1.127",
#         ],
#       - [
#           - "192.168.1.113",
#         ],
#       - [
#           - "192.168.1.190",
#         ],
#       - [
#           - "192.168.1.151",
#         ],
#     ] -> null
# module.kvm.null_resource.exec[0]: Destroying... [id=1618270682695655676]
# module.kvm.null_resource.exec[5]: Destroying... [id=6865076248482073195]
# module.kvm.null_resource.exec[3]: Destroying... [id=3056188517699741611]
# module.kvm.null_resource.exec[2]: Destroying... [id=5729096863399112430]
# module.kvm.null_resource.exec[4]: Destroying... [id=413436818846657625]
# module.kvm.null_resource.exec[1]: Destroying... [id=7690212924572871237]
# module.kvm.null_resource.exec[1]: Destruction complete after 0s
# module.kvm.null_resource.exec[4]: Destruction complete after 0s
# module.kvm.null_resource.exec[2]: Destruction complete after 0s
# module.kvm.null_resource.exec[3]: Destruction complete after 0s
# module.kvm.null_resource.exec[0]: Destruction complete after 0s
# module.kvm.null_resource.exec[5]: Destruction complete after 0s
# module.kvm.libvirt_domain.vm[5]: Destroying... [id=0a44c010-5ae9-4d22-a43d-894e8514d5d7]
# module.kvm.libvirt_domain.vm[4]: Destroying... [id=3b94b87e-626d-4b7e-a9c3-3b0e461e72d8]
# module.kvm.libvirt_domain.vm[2]: Destroying... [id=c4c4a547-e6c3-4a02-9121-694c61ca3535]
# module.kvm.libvirt_domain.vm[0]: Destroying... [id=ec5172a7-eaf0-4195-8ae4-f3ba46dea0ba]
# module.kvm.libvirt_domain.vm[3]: Destroying... [id=91ef13c9-27e5-4175-8310-c9b1aab0a6b4]
# module.kvm.libvirt_domain.vm[1]: Destroying... [id=654e6984-1ddb-44ed-83bd-8cdf9c59280e]
# module.kvm.libvirt_domain.vm[2]: Destruction complete after 0s
# module.kvm.libvirt_domain.vm[1]: Destruction complete after 0s
# module.kvm.libvirt_domain.vm[4]: Destruction complete after 0s
# module.kvm.libvirt_domain.vm[0]: Destruction complete after 0s
# module.kvm.libvirt_domain.vm[5]: Destruction complete after 0s
# module.kvm.libvirt_domain.vm[3]: Destruction complete after 1s
# module.kvm.libvirt_cloudinit_disk.cloudinit[0]: Destroying... [id=/data/vms/cloudinit-t-vm1.iso;bea45669-b243-40fb-8c85-d0740378e3aa]
# module.kvm.libvirt_cloudinit_disk.cloudinit[1]: Destroying... [id=/data/vms/cloudinit-t-vm2.iso;4e51eb65-331c-4c61-bdb2-5e239cf005e3]
# module.kvm.libvirt_cloudinit_disk.cloudinit[5]: Destroying... [id=/data/vms/cloudinit-t-vm6.iso;11472661-2432-4561-ab4d-3855bbadd473]
# module.kvm.libvirt_cloudinit_disk.cloudinit[3]: Destroying... [id=/data/vms/cloudinit-t-vm4.iso;4b357ada-2426-48b3-8cc4-8f071e0ff8ff]
# module.kvm.libvirt_cloudinit_disk.cloudinit[4]: Destroying... [id=/data/vms/cloudinit-t-vm5.iso;000daa01-1fc4-4739-9f82-e572cfe9d0b6]
# module.kvm.libvirt_cloudinit_disk.cloudinit[2]: Destroying... [id=/data/vms/cloudinit-t-vm3.iso;0b69d23a-2622-45b0-9333-954ab89c6a8d]
# module.kvm.libvirt_cloudinit_disk.cloudinit[0]: Destruction complete after 0s
# module.kvm.libvirt_cloudinit_disk.cloudinit[1]: Destruction complete after 0s
# module.kvm.libvirt_cloudinit_disk.cloudinit[5]: Destruction complete after 0s
# module.kvm.libvirt_cloudinit_disk.cloudinit[2]: Destruction complete after 0s
# module.kvm.libvirt_cloudinit_disk.cloudinit[4]: Destruction complete after 0s
# module.kvm.libvirt_cloudinit_disk.cloudinit[3]: Destruction complete after 0s
# module.kvm.libvirt_volume.volume[3]: Destroying... [id=/data/vms/t-vm4.qcow2]
# module.kvm.libvirt_volume.volume[0]: Destroying... [id=/data/vms/t-vm1.qcow2]
# module.kvm.libvirt_volume.volume[1]: Destroying... [id=/data/vms/t-vm2.qcow2]
# module.kvm.libvirt_volume.volume[2]: Destroying... [id=/data/vms/t-vm3.qcow2]
# module.kvm.libvirt_volume.volume[4]: Destroying... [id=/data/vms/t-vm5.qcow2]
# module.kvm.libvirt_volume.volume[5]: Destroying... [id=/data/vms/t-vm6.qcow2]
# module.kvm.libvirt_volume.volume[0]: Destruction complete after 0s
# module.kvm.libvirt_volume.volume[3]: Destruction complete after 0s
# module.kvm.libvirt_volume.volume[1]: Destruction complete after 0s
# module.kvm.libvirt_volume.volume[4]: Destruction complete after 0s
# module.kvm.libvirt_volume.volume[2]: Destruction complete after 0s
# module.kvm.libvirt_volume.volume[5]: Destruction complete after 0s
# 
# Destroy complete! Resources: 24 destroyed.
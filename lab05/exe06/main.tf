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
 
terraform {
  experiments = [module_variable_optional_attrs]
}

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
# modules/:
# total 4
# drwxrwxr-x 2 azureroot azureroot 4096 Oct 17 15:33 kvm
# 
# modules/kvm:
# total 20
# -rw-rw-r-- 1 azureroot azureroot  812 Oct 17 15:19 cloud_init.cfg
# -rw-rw-r-- 1 azureroot azureroot 2449 Oct 17 15:33 main.tf
# -rw-rw-r-- 1 azureroot azureroot   88 Oct 16 22:32 network_config.cfg
# -rw-rw-r-- 1 azureroot azureroot  139 Oct 17 14:51 output.tf
# -rw-rw-r-- 1 azureroot azureroot  108 Oct 17 15:01 variables.tf


# Execute o comando abaixo para inicializar o diretório do terraform:
# 
# $ terraform init
# 
# Initializing modules...
# - kvm in modules/kvm
# 
# Initializing the backend...
# 
# Initializing provider plugins...
# - Finding dmacvicar/libvirt versions matching "~> 0.6.11"...
# - Finding latest version of hashicorp/null...
# - Finding latest version of hashicorp/template...
# - Installing dmacvicar/libvirt v0.6.11...
# - Installed dmacvicar/libvirt v0.6.11 (self-signed, key ID 96B1FE1A8D4E1EAB)
# - Installing hashicorp/null v3.1.0...
# - Installed hashicorp/null v3.1.0 (signed by HashiCorp)
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
# ╷
# │ Warning: Experimental feature "module_variable_optional_attrs" is active
# │ 
# │   on main.tf line 2, in terraform:
# │    2:   experiments = [module_variable_optional_attrs]
# │ 
# │ Experimental features are subject to breaking changes in future minor or patch releases, based on feedback.
# │ 
# │ If you have feedback on the design of this feature, please open a GitHub issue to discuss it.
# ╵
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
#             hostname: t-vm1
#             
#             ssh_pwauth: true
#             chpasswd:
#               list: |
#                 root:linux
#                 ubuntu:linux
#               expire: false
#             
#             disable_root: false
#             
#             ssh_authorized_keys:
#                 - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDb6VI1UvD8kHvCfjioiFgTseLSn5/MvvAUKFp/miqjM5YOHMIEWvgKNNBoz5REYp2GKSVFiXBKcrsYq8FpZePd7CMX2NZoJOraEMl/2IqHeo2Y+Y1F+VWUilHx98Co/0epgRG1UgVY7ZxC0SjX2rjxBV4LOulOVxDjyJc/RUatT/x7D9gIKo2DW5z6U2zO4hiTvoeY9tU2XubgDNu7bkoL75U49uToKsy/R4Paf1EOHCC/Hfdxyoyx6yibNA5KxqManBMY4dcWAnt3O03pBW7vJRAJ2M9p7VJsx7iSRKdktdf6yr54UFhCFkMMTiEuto8RVIObNs5DYo5dYKWsNewwcoYsotFTPrXXb7FiMTTsGjPEJ57TzNupemmupmfTUPEDo2J/GLVI9ah9nilK+RU4uyvaO4SU6JpSplHGUJbMXd2gpm5ahoPjZ3thjuSbRbek/7cIxvaPB4OV6YBsM4qPYGxYTaiOfprXspe9vJvQlHLYeTCv1VErtyzXlWzFqpc= azureroot@terraform-01
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
#             hostname: t-vm2
#             
#             ssh_pwauth: true
#             chpasswd:
#               list: |
#                 root:linux
#                 ubuntu:linux
#               expire: false
#             
#             disable_root: false
#             
#             ssh_authorized_keys:
#                 - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDb6VI1UvD8kHvCfjioiFgTseLSn5/MvvAUKFp/miqjM5YOHMIEWvgKNNBoz5REYp2GKSVFiXBKcrsYq8FpZePd7CMX2NZoJOraEMl/2IqHeo2Y+Y1F+VWUilHx98Co/0epgRG1UgVY7ZxC0SjX2rjxBV4LOulOVxDjyJc/RUatT/x7D9gIKo2DW5z6U2zO4hiTvoeY9tU2XubgDNu7bkoL75U49uToKsy/R4Paf1EOHCC/Hfdxyoyx6yibNA5KxqManBMY4dcWAnt3O03pBW7vJRAJ2M9p7VJsx7iSRKdktdf6yr54UFhCFkMMTiEuto8RVIObNs5DYo5dYKWsNewwcoYsotFTPrXXb7FiMTTsGjPEJ57TzNupemmupmfTUPEDo2J/GLVI9ah9nilK+RU4uyvaO4SU6JpSplHGUJbMXd2gpm5ahoPjZ3thjuSbRbek/7cIxvaPB4OV6YBsM4qPYGxYTaiOfprXspe9vJvQlHLYeTCv1VErtyzXlWzFqpc= azureroot@terraform-01
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
#             hostname: t-vm3
#             
#             ssh_pwauth: true
#             chpasswd:
#               list: |
#                 root:linux
#                 ubuntu:linux
#               expire: false
#             
#             disable_root: false
#             
#             ssh_authorized_keys:
#                 - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDb6VI1UvD8kHvCfjioiFgTseLSn5/MvvAUKFp/miqjM5YOHMIEWvgKNNBoz5REYp2GKSVFiXBKcrsYq8FpZePd7CMX2NZoJOraEMl/2IqHeo2Y+Y1F+VWUilHx98Co/0epgRG1UgVY7ZxC0SjX2rjxBV4LOulOVxDjyJc/RUatT/x7D9gIKo2DW5z6U2zO4hiTvoeY9tU2XubgDNu7bkoL75U49uToKsy/R4Paf1EOHCC/Hfdxyoyx6yibNA5KxqManBMY4dcWAnt3O03pBW7vJRAJ2M9p7VJsx7iSRKdktdf6yr54UFhCFkMMTiEuto8RVIObNs5DYo5dYKWsNewwcoYsotFTPrXXb7FiMTTsGjPEJ57TzNupemmupmfTUPEDo2J/GLVI9ah9nilK+RU4uyvaO4SU6JpSplHGUJbMXd2gpm5ahoPjZ3thjuSbRbek/7cIxvaPB4OV6YBsM4qPYGxYTaiOfprXspe9vJvQlHLYeTCv1VErtyzXlWzFqpc= azureroot@terraform-01
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
#             hostname: t-vm4
#             
#             ssh_pwauth: true
#             chpasswd:
#               list: |
#                 root:linux
#                 ubuntu:linux
#               expire: false
#             
#             disable_root: false
#             
#             ssh_authorized_keys:
#                 - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDb6VI1UvD8kHvCfjioiFgTseLSn5/MvvAUKFp/miqjM5YOHMIEWvgKNNBoz5REYp2GKSVFiXBKcrsYq8FpZePd7CMX2NZoJOraEMl/2IqHeo2Y+Y1F+VWUilHx98Co/0epgRG1UgVY7ZxC0SjX2rjxBV4LOulOVxDjyJc/RUatT/x7D9gIKo2DW5z6U2zO4hiTvoeY9tU2XubgDNu7bkoL75U49uToKsy/R4Paf1EOHCC/Hfdxyoyx6yibNA5KxqManBMY4dcWAnt3O03pBW7vJRAJ2M9p7VJsx7iSRKdktdf6yr54UFhCFkMMTiEuto8RVIObNs5DYo5dYKWsNewwcoYsotFTPrXXb7FiMTTsGjPEJ57TzNupemmupmfTUPEDo2J/GLVI9ah9nilK+RU4uyvaO4SU6JpSplHGUJbMXd2gpm5ahoPjZ3thjuSbRbek/7cIxvaPB4OV6YBsM4qPYGxYTaiOfprXspe9vJvQlHLYeTCv1VErtyzXlWzFqpc= azureroot@terraform-01
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
#             hostname: t-vm5
#             
#             ssh_pwauth: true
#             chpasswd:
#               list: |
#                 root:linux
#                 ubuntu:linux
#               expire: false
#             
#             disable_root: false
#             
#             ssh_authorized_keys:
#                 - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDb6VI1UvD8kHvCfjioiFgTseLSn5/MvvAUKFp/miqjM5YOHMIEWvgKNNBoz5REYp2GKSVFiXBKcrsYq8FpZePd7CMX2NZoJOraEMl/2IqHeo2Y+Y1F+VWUilHx98Co/0epgRG1UgVY7ZxC0SjX2rjxBV4LOulOVxDjyJc/RUatT/x7D9gIKo2DW5z6U2zO4hiTvoeY9tU2XubgDNu7bkoL75U49uToKsy/R4Paf1EOHCC/Hfdxyoyx6yibNA5KxqManBMY4dcWAnt3O03pBW7vJRAJ2M9p7VJsx7iSRKdktdf6yr54UFhCFkMMTiEuto8RVIObNs5DYo5dYKWsNewwcoYsotFTPrXXb7FiMTTsGjPEJ57TzNupemmupmfTUPEDo2J/GLVI9ah9nilK+RU4uyvaO4SU6JpSplHGUJbMXd2gpm5ahoPjZ3thjuSbRbek/7cIxvaPB4OV6YBsM4qPYGxYTaiOfprXspe9vJvQlHLYeTCv1VErtyzXlWzFqpc= azureroot@terraform-01
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
#             hostname: t-vm6
#             
#             ssh_pwauth: true
#             chpasswd:
#               list: |
#                 root:linux
#                 ubuntu:linux
#               expire: false
#             
#             disable_root: false
#             
#             ssh_authorized_keys:
#                 - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDb6VI1UvD8kHvCfjioiFgTseLSn5/MvvAUKFp/miqjM5YOHMIEWvgKNNBoz5REYp2GKSVFiXBKcrsYq8FpZePd7CMX2NZoJOraEMl/2IqHeo2Y+Y1F+VWUilHx98Co/0epgRG1UgVY7ZxC0SjX2rjxBV4LOulOVxDjyJc/RUatT/x7D9gIKo2DW5z6U2zO4hiTvoeY9tU2XubgDNu7bkoL75U49uToKsy/R4Paf1EOHCC/Hfdxyoyx6yibNA5KxqManBMY4dcWAnt3O03pBW7vJRAJ2M9p7VJsx7iSRKdktdf6yr54UFhCFkMMTiEuto8RVIObNs5DYo5dYKWsNewwcoYsotFTPrXXb7FiMTTsGjPEJ57TzNupemmupmfTUPEDo2J/GLVI9ah9nilK+RU4uyvaO4SU6JpSplHGUJbMXd2gpm5ahoPjZ3thjuSbRbek/7cIxvaPB4OV6YBsM4qPYGxYTaiOfprXspe9vJvQlHLYeTCv1VErtyzXlWzFqpc= azureroot@terraform-01
#             
#             runcmd:
#               - echo "yes" > /root/cloud-init.ok
#         EOT
#     }
# 
#   # module.kvm.libvirt_domain.vm[0] will be created
#   + resource "libvirt_domain" "vm" {
#       + arch        = (known after apply)
#       + cloudinit   = (known after apply)
#       + disk        = [
#           + {
#               + block_device = null
#               + file         = null
#               + scsi         = true
#               + url          = null
#               + volume_id    = (known after apply)
#               + wwn          = null
#             },
#         ]
#       + emulator    = (known after apply)
#       + fw_cfg_name = "opt/com.coreos/config"
#       + id          = (known after apply)
#       + machine     = (known after apply)
#       + memory      = 640
#       + name        = "t-vm1"
#       + qemu_agent  = true
#       + running     = true
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
#       + cloudinit   = (known after apply)
#       + disk        = [
#           + {
#               + block_device = null
#               + file         = null
#               + scsi         = true
#               + url          = null
#               + volume_id    = (known after apply)
#               + wwn          = null
#             },
#         ]
#       + emulator    = (known after apply)
#       + fw_cfg_name = "opt/com.coreos/config"
#       + id          = (known after apply)
#       + machine     = (known after apply)
#       + memory      = 512
#       + name        = "t-vm2"
#       + qemu_agent  = true
#       + running     = true
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
#       + cloudinit   = (known after apply)
#       + disk        = [
#           + {
#               + block_device = null
#               + file         = null
#               + scsi         = true
#               + url          = null
#               + volume_id    = (known after apply)
#               + wwn          = null
#             },
#         ]
#       + emulator    = (known after apply)
#       + fw_cfg_name = "opt/com.coreos/config"
#       + id          = (known after apply)
#       + machine     = (known after apply)
#       + memory      = 512
#       + name        = "t-vm3"
#       + qemu_agent  = true
#       + running     = true
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
#       + cloudinit   = (known after apply)
#       + disk        = [
#           + {
#               + block_device = null
#               + file         = null
#               + scsi         = true
#               + url          = null
#               + volume_id    = (known after apply)
#               + wwn          = null
#             },
#         ]
#       + emulator    = (known after apply)
#       + fw_cfg_name = "opt/com.coreos/config"
#       + id          = (known after apply)
#       + machine     = (known after apply)
#       + memory      = 512
#       + name        = "t-vm4"
#       + qemu_agent  = true
#       + running     = true
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
#       + cloudinit   = (known after apply)
#       + disk        = [
#           + {
#               + block_device = null
#               + file         = null
#               + scsi         = true
#               + url          = null
#               + volume_id    = (known after apply)
#               + wwn          = null
#             },
#         ]
#       + emulator    = (known after apply)
#       + fw_cfg_name = "opt/com.coreos/config"
#       + id          = (known after apply)
#       + machine     = (known after apply)
#       + memory      = 512
#       + name        = "t-vm5"
#       + qemu_agent  = true
#       + running     = true
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
#       + cloudinit   = (known after apply)
#       + disk        = [
#           + {
#               + block_device = null
#               + file         = null
#               + scsi         = true
#               + url          = null
#               + volume_id    = (known after apply)
#               + wwn          = null
#             },
#         ]
#       + emulator    = (known after apply)
#       + fw_cfg_name = "opt/com.coreos/config"
#       + id          = (known after apply)
#       + machine     = (known after apply)
#       + memory      = 512
#       + name        = "t-vm6"
#       + qemu_agent  = true
#       + running     = true
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
#       + format = (known after apply)
#       + id     = (known after apply)
#       + name   = "t-vm1.qcow2"
#       + pool   = "VMs"
#       + size   = (known after apply)
#       + source = "https://cloud-images.ubuntu.com/releases/focal/release/ubuntu-20.04-server-cloudimg-amd64.img"
#     }
# 
#   # module.kvm.libvirt_volume.volume[1] will be created
#   + resource "libvirt_volume" "volume" {
#       + format = (known after apply)
#       + id     = (known after apply)
#       + name   = "t-vm2.qcow2"
#       + pool   = "VMs"
#       + size   = (known after apply)
#       + source = "https://cloud-images.ubuntu.com/releases/focal/release/ubuntu-20.04-server-cloudimg-amd64.img"
#     }
# 
#   # module.kvm.libvirt_volume.volume[2] will be created
#   + resource "libvirt_volume" "volume" {
#       + format = (known after apply)
#       + id     = (known after apply)
#       + name   = "t-vm3.qcow2"
#       + pool   = "VMs"
#       + size   = (known after apply)
#       + source = "https://cloud-images.ubuntu.com/releases/focal/release/ubuntu-20.04-server-cloudimg-amd64.img"
#     }
# 
#   # module.kvm.libvirt_volume.volume[3] will be created
#   + resource "libvirt_volume" "volume" {
#       + format = (known after apply)
#       + id     = (known after apply)
#       + name   = "t-vm4.qcow2"
#       + pool   = "VMs"
#       + size   = (known after apply)
#       + source = "https://cloud-images.ubuntu.com/releases/focal/release/ubuntu-20.04-server-cloudimg-amd64.img"
#     }
# 
#   # module.kvm.libvirt_volume.volume[4] will be created
#   + resource "libvirt_volume" "volume" {
#       + format = (known after apply)
#       + id     = (known after apply)
#       + name   = "t-vm5.qcow2"
#       + pool   = "VMs"
#       + size   = (known after apply)
#       + source = "https://cloud-images.ubuntu.com/releases/focal/release/ubuntu-20.04-server-cloudimg-amd64.img"
#     }
# 
#   # module.kvm.libvirt_volume.volume[5] will be created
#   + resource "libvirt_volume" "volume" {
#       + format = (known after apply)
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
# module.kvm.libvirt_volume.volume[3]: Creating...
# module.kvm.libvirt_volume.volume[0]: Creating...
# module.kvm.libvirt_volume.volume[2]: Creating...
# module.kvm.libvirt_volume.volume[1]: Creating...
# module.kvm.libvirt_volume.volume[5]: Creating...
# module.kvm.libvirt_volume.volume[4]: Creating...
# module.kvm.libvirt_volume.volume[3]: Creation complete after 9s [id=/data/vms/t-vm4.qcow2]
# module.kvm.libvirt_volume.volume[1]: Still creating... [10s elapsed]
# module.kvm.libvirt_volume.volume[2]: Still creating... [10s elapsed]
# module.kvm.libvirt_volume.volume[0]: Still creating... [10s elapsed]
# module.kvm.libvirt_volume.volume[4]: Still creating... [10s elapsed]
# module.kvm.libvirt_volume.volume[5]: Still creating... [10s elapsed]
# module.kvm.libvirt_volume.volume[0]: Creation complete after 18s [id=/data/vms/t-vm1.qcow2]
# module.kvm.libvirt_volume.volume[1]: Still creating... [20s elapsed]
# module.kvm.libvirt_volume.volume[2]: Still creating... [20s elapsed]
# module.kvm.libvirt_volume.volume[5]: Still creating... [20s elapsed]
# module.kvm.libvirt_volume.volume[4]: Still creating... [20s elapsed]
# module.kvm.libvirt_volume.volume[2]: Creation complete after 27s [id=/data/vms/t-vm3.qcow2]
# module.kvm.libvirt_volume.volume[4]: Still creating... [30s elapsed]
# module.kvm.libvirt_volume.volume[5]: Still creating... [30s elapsed]
# module.kvm.libvirt_volume.volume[1]: Still creating... [30s elapsed]
# module.kvm.libvirt_volume.volume[5]: Creation complete after 36s [id=/data/vms/t-vm6.qcow2]
# module.kvm.libvirt_volume.volume[4]: Still creating... [40s elapsed]
# module.kvm.libvirt_volume.volume[1]: Still creating... [40s elapsed]
# module.kvm.libvirt_volume.volume[1]: Creation complete after 48s [id=/data/vms/t-vm2.qcow2]
# module.kvm.libvirt_volume.volume[4]: Still creating... [50s elapsed]
# module.kvm.libvirt_volume.volume[4]: Creation complete after 57s [id=/data/vms/t-vm5.qcow2]
# module.kvm.libvirt_cloudinit_disk.cloudinit[1]: Creating...
# module.kvm.libvirt_cloudinit_disk.cloudinit[2]: Creating...
# module.kvm.libvirt_cloudinit_disk.cloudinit[4]: Creating...
# module.kvm.libvirt_cloudinit_disk.cloudinit[5]: Creating...
# module.kvm.libvirt_cloudinit_disk.cloudinit[0]: Creating...
# module.kvm.libvirt_cloudinit_disk.cloudinit[3]: Creating...
# module.kvm.libvirt_cloudinit_disk.cloudinit[1]: Creation complete after 0s [id=/data/vms/cloudinit-t-vm2.iso;c1c3fed0-7891-4f21-a43e-4347311b534a]
# module.kvm.libvirt_cloudinit_disk.cloudinit[4]: Creation complete after 0s [id=/data/vms/cloudinit-t-vm5.iso;50a393e7-36a3-4af5-a23a-d8935bbcb1d3]
# module.kvm.libvirt_cloudinit_disk.cloudinit[0]: Creation complete after 0s [id=/data/vms/cloudinit-t-vm1.iso;9411b647-16af-4f3e-b0e2-604df6e0c225]
# module.kvm.libvirt_cloudinit_disk.cloudinit[2]: Creation complete after 0s [id=/data/vms/cloudinit-t-vm3.iso;079c4770-5ae1-4498-a94b-c3119e92cb59]
# module.kvm.libvirt_cloudinit_disk.cloudinit[5]: Creation complete after 0s [id=/data/vms/cloudinit-t-vm6.iso;4bd68e9c-9d50-46e5-b367-8cc64a4c8260]
# module.kvm.libvirt_cloudinit_disk.cloudinit[3]: Creation complete after 0s [id=/data/vms/cloudinit-t-vm4.iso;6e80948c-5a35-436c-ae98-fc3b0792940f]
# module.kvm.libvirt_domain.vm[3]: Creating...
# module.kvm.libvirt_domain.vm[1]: Creating...
# module.kvm.libvirt_domain.vm[0]: Creating...
# module.kvm.libvirt_domain.vm[2]: Creating...
# module.kvm.libvirt_domain.vm[5]: Creating...
# module.kvm.libvirt_domain.vm[4]: Creating...
# module.kvm.libvirt_domain.vm[3]: Still creating... [10s elapsed]
# module.kvm.libvirt_domain.vm[1]: Still creating... [10s elapsed]
# module.kvm.libvirt_domain.vm[2]: Still creating... [10s elapsed]
# module.kvm.libvirt_domain.vm[0]: Still creating... [10s elapsed]
# module.kvm.libvirt_domain.vm[4]: Still creating... [10s elapsed]
# module.kvm.libvirt_domain.vm[5]: Still creating... [10s elapsed]
# module.kvm.libvirt_domain.vm[3]: Still creating... [20s elapsed]
# module.kvm.libvirt_domain.vm[2]: Still creating... [20s elapsed]
# module.kvm.libvirt_domain.vm[1]: Still creating... [20s elapsed]
# module.kvm.libvirt_domain.vm[4]: Still creating... [20s elapsed]
# module.kvm.libvirt_domain.vm[0]: Still creating... [20s elapsed]
# module.kvm.libvirt_domain.vm[5]: Still creating... [20s elapsed]
# module.kvm.libvirt_domain.vm[3]: Still creating... [30s elapsed]
# module.kvm.libvirt_domain.vm[1]: Still creating... [30s elapsed]
# module.kvm.libvirt_domain.vm[2]: Still creating... [30s elapsed]
# module.kvm.libvirt_domain.vm[0]: Still creating... [30s elapsed]
# module.kvm.libvirt_domain.vm[4]: Still creating... [30s elapsed]
# module.kvm.libvirt_domain.vm[5]: Still creating... [30s elapsed]
# module.kvm.libvirt_domain.vm[3]: Still creating... [40s elapsed]
# module.kvm.libvirt_domain.vm[2]: Still creating... [40s elapsed]
# module.kvm.libvirt_domain.vm[1]: Still creating... [40s elapsed]
# module.kvm.libvirt_domain.vm[0]: Still creating... [40s elapsed]
# module.kvm.libvirt_domain.vm[4]: Still creating... [40s elapsed]
# module.kvm.libvirt_domain.vm[5]: Still creating... [40s elapsed]
# module.kvm.libvirt_domain.vm[3]: Still creating... [50s elapsed]
# module.kvm.libvirt_domain.vm[1]: Still creating... [50s elapsed]
# module.kvm.libvirt_domain.vm[2]: Still creating... [50s elapsed]
# module.kvm.libvirt_domain.vm[0]: Still creating... [50s elapsed]
# module.kvm.libvirt_domain.vm[5]: Still creating... [50s elapsed]
# module.kvm.libvirt_domain.vm[4]: Still creating... [50s elapsed]
# module.kvm.libvirt_domain.vm[0]: Creation complete after 57s [id=3a4413f6-96d6-4321-9a1a-7196d2375cd4]
# module.kvm.libvirt_domain.vm[3]: Creation complete after 57s [id=66cd0a91-2094-434e-8a49-463f84dec990]
# module.kvm.libvirt_domain.vm[2]: Creation complete after 57s [id=860b9e1d-903a-43b5-b7d8-bbe148c5531a]
# module.kvm.libvirt_domain.vm[1]: Still creating... [1m0s elapsed]
# module.kvm.libvirt_domain.vm[4]: Still creating... [1m0s elapsed]
# module.kvm.libvirt_domain.vm[5]: Still creating... [1m0s elapsed]
# module.kvm.libvirt_domain.vm[1]: Creation complete after 1m7s [id=f1ab82a8-a956-4c40-95df-fd3600d5fe56]
# module.kvm.libvirt_domain.vm[4]: Creation complete after 1m9s [id=845c28f8-3a36-46de-8a38-b1bb5f9c4b49]
# module.kvm.libvirt_domain.vm[5]: Still creating... [1m10s elapsed]
# module.kvm.libvirt_domain.vm[5]: Creation complete after 1m17s [id=0badc0cd-27e6-474a-9fca-cb5f2dc0253f]
# module.kvm.null_resource.exec[3]: Creating...
# module.kvm.null_resource.exec[4]: Creating...
# module.kvm.null_resource.exec[2]: Creating...
# module.kvm.null_resource.exec[5]: Creating...
# module.kvm.null_resource.exec[4]: Provisioning with 'remote-exec'...
# module.kvm.null_resource.exec[4] (remote-exec): Connecting to remote host via SSH...
# module.kvm.null_resource.exec[4] (remote-exec):   Host: 192.168.1.155
# module.kvm.null_resource.exec[4] (remote-exec):   User: root
# module.kvm.null_resource.exec[4] (remote-exec):   Password: false
# module.kvm.null_resource.exec[4] (remote-exec):   Private key: true
# module.kvm.null_resource.exec[4] (remote-exec):   Certificate: false
# module.kvm.null_resource.exec[4] (remote-exec):   SSH Agent: false
# module.kvm.null_resource.exec[4] (remote-exec):   Checking Host Key: false
# module.kvm.null_resource.exec[4] (remote-exec):   Target Platform: unix
# module.kvm.null_resource.exec[0]: Creating...
# module.kvm.null_resource.exec[1]: Creating...
# module.kvm.null_resource.exec[3]: Provisioning with 'remote-exec'...
# module.kvm.null_resource.exec[3] (remote-exec): Connecting to remote host via SSH...
# module.kvm.null_resource.exec[3] (remote-exec):   Host: 192.168.1.156
# module.kvm.null_resource.exec[3] (remote-exec):   User: root
# module.kvm.null_resource.exec[3] (remote-exec):   Password: false
# module.kvm.null_resource.exec[3] (remote-exec):   Private key: true
# module.kvm.null_resource.exec[3] (remote-exec):   Certificate: false
# module.kvm.null_resource.exec[3] (remote-exec):   SSH Agent: false
# module.kvm.null_resource.exec[3] (remote-exec):   Checking Host Key: false
# module.kvm.null_resource.exec[3] (remote-exec):   Target Platform: unix
# module.kvm.null_resource.exec[2]: Provisioning with 'remote-exec'...
# module.kvm.null_resource.exec[2] (remote-exec): Connecting to remote host via SSH...
# module.kvm.null_resource.exec[2] (remote-exec):   Host: 192.168.1.197
# module.kvm.null_resource.exec[2] (remote-exec):   User: root
# module.kvm.null_resource.exec[2] (remote-exec):   Password: false
# module.kvm.null_resource.exec[2] (remote-exec):   Private key: true
# module.kvm.null_resource.exec[2] (remote-exec):   Certificate: false
# module.kvm.null_resource.exec[2] (remote-exec):   SSH Agent: false
# module.kvm.null_resource.exec[2] (remote-exec):   Checking Host Key: false
# module.kvm.null_resource.exec[2] (remote-exec):   Target Platform: unix
# module.kvm.null_resource.exec[0]: Provisioning with 'remote-exec'...
# module.kvm.null_resource.exec[5]: Provisioning with 'remote-exec'...
# module.kvm.null_resource.exec[5] (remote-exec): Connecting to remote host via SSH...
# module.kvm.null_resource.exec[5] (remote-exec):   Host: 192.168.1.166
# module.kvm.null_resource.exec[5] (remote-exec):   User: root
# module.kvm.null_resource.exec[5] (remote-exec):   Password: false
# module.kvm.null_resource.exec[5] (remote-exec):   Private key: true
# module.kvm.null_resource.exec[5] (remote-exec):   Certificate: false
# module.kvm.null_resource.exec[5] (remote-exec):   SSH Agent: false
# module.kvm.null_resource.exec[5] (remote-exec):   Checking Host Key: false
# module.kvm.null_resource.exec[5] (remote-exec):   Target Platform: unix
# module.kvm.null_resource.exec[0] (remote-exec): Connecting to remote host via SSH...
# module.kvm.null_resource.exec[0] (remote-exec):   Host: 192.168.1.136
# module.kvm.null_resource.exec[0] (remote-exec):   User: root
# module.kvm.null_resource.exec[0] (remote-exec):   Password: false
# module.kvm.null_resource.exec[0] (remote-exec):   Private key: true
# module.kvm.null_resource.exec[0] (remote-exec):   Certificate: false
# module.kvm.null_resource.exec[0] (remote-exec):   SSH Agent: false
# module.kvm.null_resource.exec[0] (remote-exec):   Checking Host Key: false
# module.kvm.null_resource.exec[0] (remote-exec):   Target Platform: unix
# module.kvm.null_resource.exec[1]: Provisioning with 'remote-exec'...
# module.kvm.null_resource.exec[1] (remote-exec): Connecting to remote host via SSH...
# module.kvm.null_resource.exec[1] (remote-exec):   Host: 192.168.1.119
# module.kvm.null_resource.exec[1] (remote-exec):   User: root
# module.kvm.null_resource.exec[1] (remote-exec):   Password: false
# module.kvm.null_resource.exec[1] (remote-exec):   Private key: true
# module.kvm.null_resource.exec[1] (remote-exec):   Certificate: false
# module.kvm.null_resource.exec[1] (remote-exec):   SSH Agent: false
# module.kvm.null_resource.exec[1] (remote-exec):   Checking Host Key: false
# module.kvm.null_resource.exec[1] (remote-exec):   Target Platform: unix
# module.kvm.null_resource.exec[3] (remote-exec): Connected!
# module.kvm.null_resource.exec[0] (remote-exec): Connected!
# module.kvm.null_resource.exec[1] (remote-exec): Connected!
# module.kvm.null_resource.exec[2] (remote-exec): Connected!
# module.kvm.null_resource.exec[4] (remote-exec): Connecting to remote host via SSH...
# module.kvm.null_resource.exec[4] (remote-exec):   Host: 192.168.1.155
# module.kvm.null_resource.exec[4] (remote-exec):   User: root
# module.kvm.null_resource.exec[4] (remote-exec):   Password: false
# module.kvm.null_resource.exec[4] (remote-exec):   Private key: true
# module.kvm.null_resource.exec[4] (remote-exec):   Certificate: false
# module.kvm.null_resource.exec[4] (remote-exec):   SSH Agent: false
# module.kvm.null_resource.exec[4] (remote-exec):   Checking Host Key: false
# module.kvm.null_resource.exec[4] (remote-exec):   Target Platform: unix
# module.kvm.null_resource.exec[5] (remote-exec): Connecting to remote host via SSH...
# module.kvm.null_resource.exec[5] (remote-exec):   Host: 192.168.1.166
# module.kvm.null_resource.exec[5] (remote-exec):   User: root
# module.kvm.null_resource.exec[5] (remote-exec):   Password: false
# module.kvm.null_resource.exec[5] (remote-exec):   Private key: true
# module.kvm.null_resource.exec[5] (remote-exec):   Certificate: false
# module.kvm.null_resource.exec[5] (remote-exec):   SSH Agent: false
# module.kvm.null_resource.exec[5] (remote-exec):   Checking Host Key: false
# module.kvm.null_resource.exec[5] (remote-exec):   Target Platform: unix
# module.kvm.null_resource.exec[5] (remote-exec): Connected!
# module.kvm.null_resource.exec[4] (remote-exec): Connecting to remote host via SSH...
# module.kvm.null_resource.exec[4] (remote-exec):   Host: 192.168.1.155
# module.kvm.null_resource.exec[4] (remote-exec):   User: root
# module.kvm.null_resource.exec[4] (remote-exec):   Password: false
# module.kvm.null_resource.exec[4] (remote-exec):   Private key: true
# module.kvm.null_resource.exec[4] (remote-exec):   Certificate: false
# module.kvm.null_resource.exec[4] (remote-exec):   SSH Agent: false
# module.kvm.null_resource.exec[4] (remote-exec):   Checking Host Key: false
# module.kvm.null_resource.exec[4] (remote-exec):   Target Platform: unix
# module.kvm.null_resource.exec[4] (remote-exec): Connected!
# module.kvm.null_resource.exec[3]: Creation complete after 5s [id=1263181323458260690]
# module.kvm.null_resource.exec[0]: Creation complete after 5s [id=4235864886789548697]
# module.kvm.null_resource.exec[2]: Creation complete after 6s [id=5257278782447612748]
# module.kvm.null_resource.exec[5]: Creation complete after 8s [id=7042912741075778348]
# module.kvm.null_resource.exec[1]: Creation complete after 9s [id=9100744284965837456]
# module.kvm.null_resource.exec[4]: Creation complete after 10s [id=5633564240789934508]
# ╷
# │ Warning: Experimental feature "module_variable_optional_attrs" is active
# │ 
# │   on main.tf line 2, in terraform:
# │    2:   experiments = [module_variable_optional_attrs]
# │ 
# │ Experimental features are subject to breaking changes in future minor or patch releases, based on feedback.
# │ 
# │ If you have feedback on the design of this feature, please open a GitHub issue to discuss it.
# ╵
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
#     "192.168.1.136",
#   ]),
#   tolist([
#     "192.168.1.119",
#   ]),
#   tolist([
#     "192.168.1.197",
#   ]),
#   tolist([
#     "192.168.1.156",
#   ]),
#   tolist([
#     "192.168.1.155",
#   ]),
#   tolist([
#     "192.168.1.166",
#   ]),
# ]


# Execute o comando abaixo para verificar que a máquina foi criada:
# 
# $ virsh list
#  Id   Name        State
# ---------------------------
#  1    docker      running
#  2    minikube    running
#  3    databases   running
#  22   t-vm1       running
#  23   t-vm2       running
#  24   t-vm6       running
#  25   t-vm4       running
#  26   t-vm3       running
#  27   t-vm5       running


# Em seguida, obtenha os endereços IP gerados para as máquinas virtuais, conforme abaixo:
# 
# $ terraform output ips
# [
#   tolist([
#     "192.168.1.136",
#   ]),
#   tolist([
#     "192.168.1.119",
#   ]),
#   tolist([
#     "192.168.1.197",
#   ]),
#   tolist([
#     "192.168.1.156",
#   ]),
#   tolist([
#     "192.168.1.155",
#   ]),
#   tolist([
#     "192.168.1.166",
#   ]),
# ]


# Conecte-se por SSH em uma das máquinas virtuais, e verifique se os scripts
# foram executados com sucesso:
# 
# $ ssh root@192.168.1.136
# The authenticity of host '192.168.1.136 (192.168.1.136)' can't be established.
# ECDSA key fingerprint is SHA256:9YUXxrtvvGnuzqEZKiJ3xQn2ahTWglkMWfdJM7J4Kms.
# Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
# Warning: Permanently added '192.168.1.136' (ECDSA) to the list of known hosts.
# Welcome to Ubuntu 20.04.3 LTS (GNU/Linux 5.4.0-88-generic x86_64)
# 
#  * Documentation:  https://help.ubuntu.com
#  * Management:     https://landscape.canonical.com
#  * Support:        https://ubuntu.com/advantage
# 
#   System information as of Sun Oct 17 15:49:32 UTC 2021
# 
#   System load:  0.02              Processes:             104
#   Usage of /:   65.3% of 1.96GB   Users logged in:       0
#   Memory usage: 32%               IPv4 address for ens3: 192.168.1.136
#   Swap usage:   0%
# 
# 
# 1 update can be applied immediately.
# To see these additional updates run: apt list --upgradable
# 
# 
# Last login: Sun Oct 17 15:45:01 2021 from 192.168.1.1
# root@t-vm1:~# ls -l 
# total 12
# -rw-r--r-- 1 root root    4 Oct 17 15:45 cloud-init.ok
# -rw-r--r-- 1 root root    1 Oct 17 15:45 setup.txt
# drwxr-xr-x 3 root root 4096 Oct 17 15:44 snap
# root@t-vm1:~# cat cloud-init.ok 
# yes
# root@t-vm1:~# cat setup.txt 
# 
# root@t-vm1:~# hostname
# t-vm1
# root@t-vm1:~# echo $HOSTNAME
# t-vm1
# root@t-vm1:~# logout
# Connection to 192.168.1.136 closed.


# Com base na saída acima identique o erro e discuta sobre possíveis correções
# com a turma.


# Execute o comando "terraform destroy" para destruir o ambiente, conforme abaixo:
# 
# $ terraform apply -auto-approve -destroy 
# 
# module.kvm.libvirt_volume.volume[4]: Refreshing state... [id=/data/vms/t-vm5.qcow2]
# module.kvm.libvirt_volume.volume[5]: Refreshing state... [id=/data/vms/t-vm6.qcow2]
# module.kvm.libvirt_volume.volume[3]: Refreshing state... [id=/data/vms/t-vm4.qcow2]
# module.kvm.libvirt_volume.volume[1]: Refreshing state... [id=/data/vms/t-vm2.qcow2]
# module.kvm.libvirt_volume.volume[2]: Refreshing state... [id=/data/vms/t-vm3.qcow2]
# module.kvm.libvirt_volume.volume[0]: Refreshing state... [id=/data/vms/t-vm1.qcow2]
# module.kvm.libvirt_cloudinit_disk.cloudinit[4]: Refreshing state... [id=/data/vms/cloudinit-t-vm5.iso;50a393e7-36a3-4af5-a23a-d8935bbcb1d3]
# module.kvm.libvirt_cloudinit_disk.cloudinit[1]: Refreshing state... [id=/data/vms/cloudinit-t-vm2.iso;c1c3fed0-7891-4f21-a43e-4347311b534a]
# module.kvm.libvirt_cloudinit_disk.cloudinit[3]: Refreshing state... [id=/data/vms/cloudinit-t-vm4.iso;6e80948c-5a35-436c-ae98-fc3b0792940f]
# module.kvm.libvirt_cloudinit_disk.cloudinit[2]: Refreshing state... [id=/data/vms/cloudinit-t-vm3.iso;079c4770-5ae1-4498-a94b-c3119e92cb59]
# module.kvm.libvirt_cloudinit_disk.cloudinit[0]: Refreshing state... [id=/data/vms/cloudinit-t-vm1.iso;9411b647-16af-4f3e-b0e2-604df6e0c225]
# module.kvm.libvirt_cloudinit_disk.cloudinit[5]: Refreshing state... [id=/data/vms/cloudinit-t-vm6.iso;4bd68e9c-9d50-46e5-b367-8cc64a4c8260]
# module.kvm.libvirt_domain.vm[4]: Refreshing state... [id=845c28f8-3a36-46de-8a38-b1bb5f9c4b49]
# module.kvm.libvirt_domain.vm[5]: Refreshing state... [id=0badc0cd-27e6-474a-9fca-cb5f2dc0253f]
# module.kvm.libvirt_domain.vm[0]: Refreshing state... [id=3a4413f6-96d6-4321-9a1a-7196d2375cd4]
# module.kvm.libvirt_domain.vm[2]: Refreshing state... [id=860b9e1d-903a-43b5-b7d8-bbe148c5531a]
# module.kvm.libvirt_domain.vm[3]: Refreshing state... [id=66cd0a91-2094-434e-8a49-463f84dec990]
# module.kvm.libvirt_domain.vm[1]: Refreshing state... [id=f1ab82a8-a956-4c40-95df-fd3600d5fe56]
# module.kvm.null_resource.exec[4]: Refreshing state... [id=5633564240789934508]
# module.kvm.null_resource.exec[0]: Refreshing state... [id=4235864886789548697]
# module.kvm.null_resource.exec[5]: Refreshing state... [id=7042912741075778348]
# module.kvm.null_resource.exec[2]: Refreshing state... [id=5257278782447612748]
# module.kvm.null_resource.exec[1]: Refreshing state... [id=9100744284965837456]
# module.kvm.null_resource.exec[3]: Refreshing state... [id=1263181323458260690]
# 
# Note: Objects have changed outside of Terraform
# 
# Terraform detected the following changes made outside of Terraform since the last "terraform apply":
# 
#   # module.kvm.libvirt_domain.vm[0] has been changed
#   ~ resource "libvirt_domain" "vm" {
#       + cmdline     = []
#         id          = "3a4413f6-96d6-4321-9a1a-7196d2375cd4"
#         name        = "t-vm1"
#         # (10 unchanged attributes hidden)
# 
# 
# 
# 
#       ~ network_interface {
#           + hostname       = "t-vm1"
#             # (5 unchanged attributes hidden)
#         }
#         # (4 unchanged blocks hidden)
#     }
#   # module.kvm.libvirt_domain.vm[1] has been changed
#   ~ resource "libvirt_domain" "vm" {
#       + cmdline     = []
#         id          = "f1ab82a8-a956-4c40-95df-fd3600d5fe56"
#         name        = "t-vm2"
#         # (10 unchanged attributes hidden)
# 
# 
# 
# 
#       ~ network_interface {
#           + hostname       = "t-vm2"
#             # (5 unchanged attributes hidden)
#         }
#         # (4 unchanged blocks hidden)
#     }
#   # module.kvm.libvirt_domain.vm[2] has been changed
#   ~ resource "libvirt_domain" "vm" {
#       + cmdline     = []
#         id          = "860b9e1d-903a-43b5-b7d8-bbe148c5531a"
#         name        = "t-vm3"
#         # (10 unchanged attributes hidden)
# 
# 
# 
# 
#       ~ network_interface {
#           + hostname       = "t-vm3"
#             # (5 unchanged attributes hidden)
#         }
#         # (4 unchanged blocks hidden)
#     }
#   # module.kvm.libvirt_domain.vm[3] has been changed
#   ~ resource "libvirt_domain" "vm" {
#       + cmdline     = []
#         id          = "66cd0a91-2094-434e-8a49-463f84dec990"
#         name        = "t-vm4"
#         # (10 unchanged attributes hidden)
# 
# 
# 
# 
#       ~ network_interface {
#           + hostname       = "t-vm4"
#             # (5 unchanged attributes hidden)
#         }
#         # (4 unchanged blocks hidden)
#     }
#   # module.kvm.libvirt_domain.vm[4] has been changed
#   ~ resource "libvirt_domain" "vm" {
#       + cmdline     = []
#         id          = "845c28f8-3a36-46de-8a38-b1bb5f9c4b49"
#         name        = "t-vm5"
#         # (10 unchanged attributes hidden)
# 
# 
# 
# 
#       ~ network_interface {
#           + hostname       = "t-vm5"
#             # (5 unchanged attributes hidden)
#         }
#         # (4 unchanged blocks hidden)
#     }
#   # module.kvm.libvirt_domain.vm[5] has been changed
#   ~ resource "libvirt_domain" "vm" {
#       + cmdline     = []
#         id          = "0badc0cd-27e6-474a-9fca-cb5f2dc0253f"
#         name        = "t-vm6"
#         # (10 unchanged attributes hidden)
# 
# 
# 
# 
#       ~ network_interface {
#           + hostname       = "t-vm6"
#             # (5 unchanged attributes hidden)
#         }
#         # (4 unchanged blocks hidden)
#     }
# 
# Unless you have made equivalent changes to your configuration, or ignored the relevant attributes using ignore_changes, the following plan may include
# actions to undo or respond to these changes.
# 
# ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
# 
# Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
#   - destroy
# 
# Terraform will perform the following actions:
# 
#   # module.kvm.libvirt_cloudinit_disk.cloudinit[0] will be destroyed
#   - resource "libvirt_cloudinit_disk" "cloudinit" {
#       - id             = "/data/vms/cloudinit-t-vm1.iso;9411b647-16af-4f3e-b0e2-604df6e0c225" -> null
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
#             hostname: t-vm1
#             
#             ssh_pwauth: true
#             chpasswd:
#               list: |
#                 root:linux
#                 ubuntu:linux
#               expire: false
#             
#             disable_root: false
#             
#             ssh_authorized_keys:
#                 - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDb6VI1UvD8kHvCfjioiFgTseLSn5/MvvAUKFp/miqjM5YOHMIEWvgKNNBoz5REYp2GKSVFiXBKcrsYq8FpZePd7CMX2NZoJOraEMl/2IqHeo2Y+Y1F+VWUilHx98Co/0epgRG1UgVY7ZxC0SjX2rjxBV4LOulOVxDjyJc/RUatT/x7D9gIKo2DW5z6U2zO4hiTvoeY9tU2XubgDNu7bkoL75U49uToKsy/R4Paf1EOHCC/Hfdxyoyx6yibNA5KxqManBMY4dcWAnt3O03pBW7vJRAJ2M9p7VJsx7iSRKdktdf6yr54UFhCFkMMTiEuto8RVIObNs5DYo5dYKWsNewwcoYsotFTPrXXb7FiMTTsGjPEJ57TzNupemmupmfTUPEDo2J/GLVI9ah9nilK+RU4uyvaO4SU6JpSplHGUJbMXd2gpm5ahoPjZ3thjuSbRbek/7cIxvaPB4OV6YBsM4qPYGxYTaiOfprXspe9vJvQlHLYeTCv1VErtyzXlWzFqpc= azureroot@terraform-01
#             
#             runcmd:
#               - echo "yes" > /root/cloud-init.ok
#         EOT -> null
#     }
# 
#   # module.kvm.libvirt_cloudinit_disk.cloudinit[1] will be destroyed
#   - resource "libvirt_cloudinit_disk" "cloudinit" {
#       - id             = "/data/vms/cloudinit-t-vm2.iso;c1c3fed0-7891-4f21-a43e-4347311b534a" -> null
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
#             hostname: t-vm2
#             
#             ssh_pwauth: true
#             chpasswd:
#               list: |
#                 root:linux
#                 ubuntu:linux
#               expire: false
#             
#             disable_root: false
#             
#             ssh_authorized_keys:
#                 - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDb6VI1UvD8kHvCfjioiFgTseLSn5/MvvAUKFp/miqjM5YOHMIEWvgKNNBoz5REYp2GKSVFiXBKcrsYq8FpZePd7CMX2NZoJOraEMl/2IqHeo2Y+Y1F+VWUilHx98Co/0epgRG1UgVY7ZxC0SjX2rjxBV4LOulOVxDjyJc/RUatT/x7D9gIKo2DW5z6U2zO4hiTvoeY9tU2XubgDNu7bkoL75U49uToKsy/R4Paf1EOHCC/Hfdxyoyx6yibNA5KxqManBMY4dcWAnt3O03pBW7vJRAJ2M9p7VJsx7iSRKdktdf6yr54UFhCFkMMTiEuto8RVIObNs5DYo5dYKWsNewwcoYsotFTPrXXb7FiMTTsGjPEJ57TzNupemmupmfTUPEDo2J/GLVI9ah9nilK+RU4uyvaO4SU6JpSplHGUJbMXd2gpm5ahoPjZ3thjuSbRbek/7cIxvaPB4OV6YBsM4qPYGxYTaiOfprXspe9vJvQlHLYeTCv1VErtyzXlWzFqpc= azureroot@terraform-01
#             
#             runcmd:
#               - echo "yes" > /root/cloud-init.ok
#         EOT -> null
#     }
# 
#   # module.kvm.libvirt_cloudinit_disk.cloudinit[2] will be destroyed
#   - resource "libvirt_cloudinit_disk" "cloudinit" {
#       - id             = "/data/vms/cloudinit-t-vm3.iso;079c4770-5ae1-4498-a94b-c3119e92cb59" -> null
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
#             hostname: t-vm3
#             
#             ssh_pwauth: true
#             chpasswd:
#               list: |
#                 root:linux
#                 ubuntu:linux
#               expire: false
#             
#             disable_root: false
#             
#             ssh_authorized_keys:
#                 - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDb6VI1UvD8kHvCfjioiFgTseLSn5/MvvAUKFp/miqjM5YOHMIEWvgKNNBoz5REYp2GKSVFiXBKcrsYq8FpZePd7CMX2NZoJOraEMl/2IqHeo2Y+Y1F+VWUilHx98Co/0epgRG1UgVY7ZxC0SjX2rjxBV4LOulOVxDjyJc/RUatT/x7D9gIKo2DW5z6U2zO4hiTvoeY9tU2XubgDNu7bkoL75U49uToKsy/R4Paf1EOHCC/Hfdxyoyx6yibNA5KxqManBMY4dcWAnt3O03pBW7vJRAJ2M9p7VJsx7iSRKdktdf6yr54UFhCFkMMTiEuto8RVIObNs5DYo5dYKWsNewwcoYsotFTPrXXb7FiMTTsGjPEJ57TzNupemmupmfTUPEDo2J/GLVI9ah9nilK+RU4uyvaO4SU6JpSplHGUJbMXd2gpm5ahoPjZ3thjuSbRbek/7cIxvaPB4OV6YBsM4qPYGxYTaiOfprXspe9vJvQlHLYeTCv1VErtyzXlWzFqpc= azureroot@terraform-01
#             
#             runcmd:
#               - echo "yes" > /root/cloud-init.ok
#         EOT -> null
#     }
# 
#   # module.kvm.libvirt_cloudinit_disk.cloudinit[3] will be destroyed
#   - resource "libvirt_cloudinit_disk" "cloudinit" {
#       - id             = "/data/vms/cloudinit-t-vm4.iso;6e80948c-5a35-436c-ae98-fc3b0792940f" -> null
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
#             hostname: t-vm4
#             
#             ssh_pwauth: true
#             chpasswd:
#               list: |
#                 root:linux
#                 ubuntu:linux
#               expire: false
#             
#             disable_root: false
#             
#             ssh_authorized_keys:
#                 - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDb6VI1UvD8kHvCfjioiFgTseLSn5/MvvAUKFp/miqjM5YOHMIEWvgKNNBoz5REYp2GKSVFiXBKcrsYq8FpZePd7CMX2NZoJOraEMl/2IqHeo2Y+Y1F+VWUilHx98Co/0epgRG1UgVY7ZxC0SjX2rjxBV4LOulOVxDjyJc/RUatT/x7D9gIKo2DW5z6U2zO4hiTvoeY9tU2XubgDNu7bkoL75U49uToKsy/R4Paf1EOHCC/Hfdxyoyx6yibNA5KxqManBMY4dcWAnt3O03pBW7vJRAJ2M9p7VJsx7iSRKdktdf6yr54UFhCFkMMTiEuto8RVIObNs5DYo5dYKWsNewwcoYsotFTPrXXb7FiMTTsGjPEJ57TzNupemmupmfTUPEDo2J/GLVI9ah9nilK+RU4uyvaO4SU6JpSplHGUJbMXd2gpm5ahoPjZ3thjuSbRbek/7cIxvaPB4OV6YBsM4qPYGxYTaiOfprXspe9vJvQlHLYeTCv1VErtyzXlWzFqpc= azureroot@terraform-01
#             
#             runcmd:
#               - echo "yes" > /root/cloud-init.ok
#         EOT -> null
#     }
# 
#   # module.kvm.libvirt_cloudinit_disk.cloudinit[4] will be destroyed
#   - resource "libvirt_cloudinit_disk" "cloudinit" {
#       - id             = "/data/vms/cloudinit-t-vm5.iso;50a393e7-36a3-4af5-a23a-d8935bbcb1d3" -> null
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
#             hostname: t-vm5
#             
#             ssh_pwauth: true
#             chpasswd:
#               list: |
#                 root:linux
#                 ubuntu:linux
#               expire: false
#             
#             disable_root: false
#             
#             ssh_authorized_keys:
#                 - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDb6VI1UvD8kHvCfjioiFgTseLSn5/MvvAUKFp/miqjM5YOHMIEWvgKNNBoz5REYp2GKSVFiXBKcrsYq8FpZePd7CMX2NZoJOraEMl/2IqHeo2Y+Y1F+VWUilHx98Co/0epgRG1UgVY7ZxC0SjX2rjxBV4LOulOVxDjyJc/RUatT/x7D9gIKo2DW5z6U2zO4hiTvoeY9tU2XubgDNu7bkoL75U49uToKsy/R4Paf1EOHCC/Hfdxyoyx6yibNA5KxqManBMY4dcWAnt3O03pBW7vJRAJ2M9p7VJsx7iSRKdktdf6yr54UFhCFkMMTiEuto8RVIObNs5DYo5dYKWsNewwcoYsotFTPrXXb7FiMTTsGjPEJ57TzNupemmupmfTUPEDo2J/GLVI9ah9nilK+RU4uyvaO4SU6JpSplHGUJbMXd2gpm5ahoPjZ3thjuSbRbek/7cIxvaPB4OV6YBsM4qPYGxYTaiOfprXspe9vJvQlHLYeTCv1VErtyzXlWzFqpc= azureroot@terraform-01
#             
#             runcmd:
#               - echo "yes" > /root/cloud-init.ok
#         EOT -> null
#     }
# 
#   # module.kvm.libvirt_cloudinit_disk.cloudinit[5] will be destroyed
#   - resource "libvirt_cloudinit_disk" "cloudinit" {
#       - id             = "/data/vms/cloudinit-t-vm6.iso;4bd68e9c-9d50-46e5-b367-8cc64a4c8260" -> null
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
#             hostname: t-vm6
#             
#             ssh_pwauth: true
#             chpasswd:
#               list: |
#                 root:linux
#                 ubuntu:linux
#               expire: false
#             
#             disable_root: false
#             
#             ssh_authorized_keys:
#                 - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDb6VI1UvD8kHvCfjioiFgTseLSn5/MvvAUKFp/miqjM5YOHMIEWvgKNNBoz5REYp2GKSVFiXBKcrsYq8FpZePd7CMX2NZoJOraEMl/2IqHeo2Y+Y1F+VWUilHx98Co/0epgRG1UgVY7ZxC0SjX2rjxBV4LOulOVxDjyJc/RUatT/x7D9gIKo2DW5z6U2zO4hiTvoeY9tU2XubgDNu7bkoL75U49uToKsy/R4Paf1EOHCC/Hfdxyoyx6yibNA5KxqManBMY4dcWAnt3O03pBW7vJRAJ2M9p7VJsx7iSRKdktdf6yr54UFhCFkMMTiEuto8RVIObNs5DYo5dYKWsNewwcoYsotFTPrXXb7FiMTTsGjPEJ57TzNupemmupmfTUPEDo2J/GLVI9ah9nilK+RU4uyvaO4SU6JpSplHGUJbMXd2gpm5ahoPjZ3thjuSbRbek/7cIxvaPB4OV6YBsM4qPYGxYTaiOfprXspe9vJvQlHLYeTCv1VErtyzXlWzFqpc= azureroot@terraform-01
#             
#             runcmd:
#               - echo "yes" > /root/cloud-init.ok
#         EOT -> null
#     }
# 
#   # module.kvm.libvirt_domain.vm[0] will be destroyed
#   - resource "libvirt_domain" "vm" {
#       - arch        = "x86_64" -> null
#       - cloudinit   = "/data/vms/cloudinit-t-vm1.iso;9411b647-16af-4f3e-b0e2-604df6e0c225" -> null
#       - cmdline     = [] -> null
#       - disk        = [
#           - {
#               - block_device = ""
#               - file         = ""
#               - scsi         = true
#               - url          = ""
#               - volume_id    = "/data/vms/t-vm1.qcow2"
#               - wwn          = ""
#             },
#         ] -> null
#       - emulator    = "/usr/bin/qemu-system-x86_64" -> null
#       - fw_cfg_name = "opt/com.coreos/config" -> null
#       - id          = "3a4413f6-96d6-4321-9a1a-7196d2375cd4" -> null
#       - machine     = "ubuntu" -> null
#       - memory      = 640 -> null
#       - name        = "t-vm1" -> null
#       - qemu_agent  = true -> null
#       - running     = true -> null
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
#           - mode = "host-model" -> null
#         }
# 
#       - graphics {
#           - autoport       = true -> null
#           - listen_address = "127.0.0.1" -> null
#           - listen_type    = "address" -> null
#           - type           = "spice" -> null
#         }
# 
#       - network_interface {
#           - addresses      = [
#               - "192.168.1.136",
#             ] -> null
#           - hostname       = "t-vm1" -> null
#           - mac            = "52:54:00:8A:54:E8" -> null
#           - network_id     = "67274476-dea4-11eb-ade5-000d3a3ea45d" -> null
#           - network_name   = "default" -> null
#           - wait_for_lease = true -> null
#         }
#     }
# 
#   # module.kvm.libvirt_domain.vm[1] will be destroyed
#   - resource "libvirt_domain" "vm" {
#       - arch        = "x86_64" -> null
#       - cloudinit   = "/data/vms/cloudinit-t-vm2.iso;c1c3fed0-7891-4f21-a43e-4347311b534a" -> null
#       - cmdline     = [] -> null
#       - disk        = [
#           - {
#               - block_device = ""
#               - file         = ""
#               - scsi         = true
#               - url          = ""
#               - volume_id    = "/data/vms/t-vm2.qcow2"
#               - wwn          = ""
#             },
#         ] -> null
#       - emulator    = "/usr/bin/qemu-system-x86_64" -> null
#       - fw_cfg_name = "opt/com.coreos/config" -> null
#       - id          = "f1ab82a8-a956-4c40-95df-fd3600d5fe56" -> null
#       - machine     = "ubuntu" -> null
#       - memory      = 512 -> null
#       - name        = "t-vm2" -> null
#       - qemu_agent  = true -> null
#       - running     = true -> null
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
#           - mode = "host-model" -> null
#         }
# 
#       - graphics {
#           - autoport       = true -> null
#           - listen_address = "127.0.0.1" -> null
#           - listen_type    = "address" -> null
#           - type           = "spice" -> null
#         }
# 
#       - network_interface {
#           - addresses      = [
#               - "192.168.1.119",
#             ] -> null
#           - hostname       = "t-vm2" -> null
#           - mac            = "52:54:00:C6:7E:A0" -> null
#           - network_id     = "67274476-dea4-11eb-ade5-000d3a3ea45d" -> null
#           - network_name   = "default" -> null
#           - wait_for_lease = true -> null
#         }
#     }
# 
#   # module.kvm.libvirt_domain.vm[2] will be destroyed
#   - resource "libvirt_domain" "vm" {
#       - arch        = "x86_64" -> null
#       - cloudinit   = "/data/vms/cloudinit-t-vm3.iso;079c4770-5ae1-4498-a94b-c3119e92cb59" -> null
#       - cmdline     = [] -> null
#       - disk        = [
#           - {
#               - block_device = ""
#               - file         = ""
#               - scsi         = true
#               - url          = ""
#               - volume_id    = "/data/vms/t-vm3.qcow2"
#               - wwn          = ""
#             },
#         ] -> null
#       - emulator    = "/usr/bin/qemu-system-x86_64" -> null
#       - fw_cfg_name = "opt/com.coreos/config" -> null
#       - id          = "860b9e1d-903a-43b5-b7d8-bbe148c5531a" -> null
#       - machine     = "ubuntu" -> null
#       - memory      = 512 -> null
#       - name        = "t-vm3" -> null
#       - qemu_agent  = true -> null
#       - running     = true -> null
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
#           - mode = "host-model" -> null
#         }
# 
#       - graphics {
#           - autoport       = true -> null
#           - listen_address = "127.0.0.1" -> null
#           - listen_type    = "address" -> null
#           - type           = "spice" -> null
#         }
# 
#       - network_interface {
#           - addresses      = [
#               - "192.168.1.197",
#             ] -> null
#           - hostname       = "t-vm3" -> null
#           - mac            = "52:54:00:82:31:BC" -> null
#           - network_id     = "67274476-dea4-11eb-ade5-000d3a3ea45d" -> null
#           - network_name   = "default" -> null
#           - wait_for_lease = true -> null
#         }
#     }
# 
#   # module.kvm.libvirt_domain.vm[3] will be destroyed
#   - resource "libvirt_domain" "vm" {
#       - arch        = "x86_64" -> null
#       - cloudinit   = "/data/vms/cloudinit-t-vm4.iso;6e80948c-5a35-436c-ae98-fc3b0792940f" -> null
#       - cmdline     = [] -> null
#       - disk        = [
#           - {
#               - block_device = ""
#               - file         = ""
#               - scsi         = true
#               - url          = ""
#               - volume_id    = "/data/vms/t-vm4.qcow2"
#               - wwn          = ""
#             },
#         ] -> null
#       - emulator    = "/usr/bin/qemu-system-x86_64" -> null
#       - fw_cfg_name = "opt/com.coreos/config" -> null
#       - id          = "66cd0a91-2094-434e-8a49-463f84dec990" -> null
#       - machine     = "ubuntu" -> null
#       - memory      = 512 -> null
#       - name        = "t-vm4" -> null
#       - qemu_agent  = true -> null
#       - running     = true -> null
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
#           - mode = "host-model" -> null
#         }
# 
#       - graphics {
#           - autoport       = true -> null
#           - listen_address = "127.0.0.1" -> null
#           - listen_type    = "address" -> null
#           - type           = "spice" -> null
#         }
# 
#       - network_interface {
#           - addresses      = [
#               - "192.168.1.156",
#             ] -> null
#           - hostname       = "t-vm4" -> null
#           - mac            = "52:54:00:C2:A1:C4" -> null
#           - network_id     = "67274476-dea4-11eb-ade5-000d3a3ea45d" -> null
#           - network_name   = "default" -> null
#           - wait_for_lease = true -> null
#         }
#     }
# 
#   # module.kvm.libvirt_domain.vm[4] will be destroyed
#   - resource "libvirt_domain" "vm" {
#       - arch        = "x86_64" -> null
#       - cloudinit   = "/data/vms/cloudinit-t-vm5.iso;50a393e7-36a3-4af5-a23a-d8935bbcb1d3" -> null
#       - cmdline     = [] -> null
#       - disk        = [
#           - {
#               - block_device = ""
#               - file         = ""
#               - scsi         = true
#               - url          = ""
#               - volume_id    = "/data/vms/t-vm5.qcow2"
#               - wwn          = ""
#             },
#         ] -> null
#       - emulator    = "/usr/bin/qemu-system-x86_64" -> null
#       - fw_cfg_name = "opt/com.coreos/config" -> null
#       - id          = "845c28f8-3a36-46de-8a38-b1bb5f9c4b49" -> null
#       - machine     = "ubuntu" -> null
#       - memory      = 512 -> null
#       - name        = "t-vm5" -> null
#       - qemu_agent  = true -> null
#       - running     = true -> null
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
#           - mode = "host-model" -> null
#         }
# 
#       - graphics {
#           - autoport       = true -> null
#           - listen_address = "127.0.0.1" -> null
#           - listen_type    = "address" -> null
#           - type           = "spice" -> null
#         }
# 
#       - network_interface {
#           - addresses      = [
#               - "192.168.1.155",
#             ] -> null
#           - hostname       = "t-vm5" -> null
#           - mac            = "52:54:00:92:96:77" -> null
#           - network_id     = "67274476-dea4-11eb-ade5-000d3a3ea45d" -> null
#           - network_name   = "default" -> null
#           - wait_for_lease = true -> null
#         }
#     }
# 
#   # module.kvm.libvirt_domain.vm[5] will be destroyed
#   - resource "libvirt_domain" "vm" {
#       - arch        = "x86_64" -> null
#       - cloudinit   = "/data/vms/cloudinit-t-vm6.iso;4bd68e9c-9d50-46e5-b367-8cc64a4c8260" -> null
#       - cmdline     = [] -> null
#       - disk        = [
#           - {
#               - block_device = ""
#               - file         = ""
#               - scsi         = true
#               - url          = ""
#               - volume_id    = "/data/vms/t-vm6.qcow2"
#               - wwn          = ""
#             },
#         ] -> null
#       - emulator    = "/usr/bin/qemu-system-x86_64" -> null
#       - fw_cfg_name = "opt/com.coreos/config" -> null
#       - id          = "0badc0cd-27e6-474a-9fca-cb5f2dc0253f" -> null
#       - machine     = "ubuntu" -> null
#       - memory      = 512 -> null
#       - name        = "t-vm6" -> null
#       - qemu_agent  = true -> null
#       - running     = true -> null
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
#           - mode = "host-model" -> null
#         }
# 
#       - graphics {
#           - autoport       = true -> null
#           - listen_address = "127.0.0.1" -> null
#           - listen_type    = "address" -> null
#           - type           = "spice" -> null
#         }
# 
#       - network_interface {
#           - addresses      = [
#               - "192.168.1.166",
#             ] -> null
#           - hostname       = "t-vm6" -> null
#           - mac            = "52:54:00:CA:AD:2F" -> null
#           - network_id     = "67274476-dea4-11eb-ade5-000d3a3ea45d" -> null
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
#       - id = "4235864886789548697" -> null
#     }
# 
#   # module.kvm.null_resource.exec[1] will be destroyed
#   - resource "null_resource" "exec" {
#       - id = "9100744284965837456" -> null
#     }
# 
#   # module.kvm.null_resource.exec[2] will be destroyed
#   - resource "null_resource" "exec" {
#       - id = "5257278782447612748" -> null
#     }
# 
#   # module.kvm.null_resource.exec[3] will be destroyed
#   - resource "null_resource" "exec" {
#       - id = "1263181323458260690" -> null
#     }
# 
#   # module.kvm.null_resource.exec[4] will be destroyed
#   - resource "null_resource" "exec" {
#       - id = "5633564240789934508" -> null
#     }
# 
#   # module.kvm.null_resource.exec[5] will be destroyed
#   - resource "null_resource" "exec" {
#       - id = "7042912741075778348" -> null
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
#           - "192.168.1.136",
#         ],
#       - [
#           - "192.168.1.119",
#         ],
#       - [
#           - "192.168.1.197",
#         ],
#       - [
#           - "192.168.1.156",
#         ],
#       - [
#           - "192.168.1.155",
#         ],
#       - [
#           - "192.168.1.166",
#         ],
#     ] -> null
# module.kvm.null_resource.exec[4]: Destroying... [id=5633564240789934508]
# module.kvm.null_resource.exec[2]: Destroying... [id=5257278782447612748]
# module.kvm.null_resource.exec[3]: Destroying... [id=1263181323458260690]
# module.kvm.null_resource.exec[0]: Destroying... [id=4235864886789548697]
# module.kvm.null_resource.exec[5]: Destroying... [id=7042912741075778348]
# module.kvm.null_resource.exec[1]: Destroying... [id=9100744284965837456]
# module.kvm.null_resource.exec[0]: Destruction complete after 0s
# module.kvm.null_resource.exec[4]: Destruction complete after 0s
# module.kvm.null_resource.exec[1]: Destruction complete after 0s
# module.kvm.null_resource.exec[5]: Destruction complete after 0s
# module.kvm.null_resource.exec[3]: Destruction complete after 0s
# module.kvm.null_resource.exec[2]: Destruction complete after 0s
# module.kvm.libvirt_domain.vm[4]: Destroying... [id=845c28f8-3a36-46de-8a38-b1bb5f9c4b49]
# module.kvm.libvirt_domain.vm[3]: Destroying... [id=66cd0a91-2094-434e-8a49-463f84dec990]
# module.kvm.libvirt_domain.vm[1]: Destroying... [id=f1ab82a8-a956-4c40-95df-fd3600d5fe56]
# module.kvm.libvirt_domain.vm[5]: Destroying... [id=0badc0cd-27e6-474a-9fca-cb5f2dc0253f]
# module.kvm.libvirt_domain.vm[0]: Destroying... [id=3a4413f6-96d6-4321-9a1a-7196d2375cd4]
# module.kvm.libvirt_domain.vm[2]: Destroying... [id=860b9e1d-903a-43b5-b7d8-bbe148c5531a]
# module.kvm.libvirt_domain.vm[4]: Destruction complete after 0s
# module.kvm.libvirt_domain.vm[1]: Destruction complete after 1s
# module.kvm.libvirt_domain.vm[3]: Destruction complete after 1s
# module.kvm.libvirt_domain.vm[2]: Destruction complete after 1s
# module.kvm.libvirt_domain.vm[5]: Destruction complete after 1s
# module.kvm.libvirt_domain.vm[0]: Destruction complete after 1s
# module.kvm.libvirt_cloudinit_disk.cloudinit[3]: Destroying... [id=/data/vms/cloudinit-t-vm4.iso;6e80948c-5a35-436c-ae98-fc3b0792940f]
# module.kvm.libvirt_cloudinit_disk.cloudinit[5]: Destroying... [id=/data/vms/cloudinit-t-vm6.iso;4bd68e9c-9d50-46e5-b367-8cc64a4c8260]
# module.kvm.libvirt_cloudinit_disk.cloudinit[4]: Destroying... [id=/data/vms/cloudinit-t-vm5.iso;50a393e7-36a3-4af5-a23a-d8935bbcb1d3]
# module.kvm.libvirt_cloudinit_disk.cloudinit[2]: Destroying... [id=/data/vms/cloudinit-t-vm3.iso;079c4770-5ae1-4498-a94b-c3119e92cb59]
# module.kvm.libvirt_cloudinit_disk.cloudinit[1]: Destroying... [id=/data/vms/cloudinit-t-vm2.iso;c1c3fed0-7891-4f21-a43e-4347311b534a]
# module.kvm.libvirt_cloudinit_disk.cloudinit[0]: Destroying... [id=/data/vms/cloudinit-t-vm1.iso;9411b647-16af-4f3e-b0e2-604df6e0c225]
# module.kvm.libvirt_cloudinit_disk.cloudinit[0]: Destruction complete after 0s
# module.kvm.libvirt_cloudinit_disk.cloudinit[5]: Destruction complete after 0s
# module.kvm.libvirt_cloudinit_disk.cloudinit[3]: Destruction complete after 0s
# module.kvm.libvirt_cloudinit_disk.cloudinit[2]: Destruction complete after 0s
# module.kvm.libvirt_cloudinit_disk.cloudinit[1]: Destruction complete after 0s
# module.kvm.libvirt_cloudinit_disk.cloudinit[4]: Destruction complete after 0s
# module.kvm.libvirt_volume.volume[0]: Destroying... [id=/data/vms/t-vm1.qcow2]
# module.kvm.libvirt_volume.volume[1]: Destroying... [id=/data/vms/t-vm2.qcow2]
# module.kvm.libvirt_volume.volume[5]: Destroying... [id=/data/vms/t-vm6.qcow2]
# module.kvm.libvirt_volume.volume[3]: Destroying... [id=/data/vms/t-vm4.qcow2]
# module.kvm.libvirt_volume.volume[2]: Destroying... [id=/data/vms/t-vm3.qcow2]
# module.kvm.libvirt_volume.volume[4]: Destroying... [id=/data/vms/t-vm5.qcow2]
# module.kvm.libvirt_volume.volume[0]: Destruction complete after 0s
# module.kvm.libvirt_volume.volume[2]: Destruction complete after 0s
# module.kvm.libvirt_volume.volume[1]: Destruction complete after 0s
# module.kvm.libvirt_volume.volume[3]: Destruction complete after 0s
# module.kvm.libvirt_volume.volume[4]: Destruction complete after 0s
# module.kvm.libvirt_volume.volume[5]: Destruction complete after 0s
# ╷
# │ Warning: Experimental feature "module_variable_optional_attrs" is active
# │ 
# │   on main.tf line 2, in terraform:
# │    2:   experiments = [module_variable_optional_attrs]
# │ 
# │ Experimental features are subject to breaking changes in future minor or patch releases, based on feedback.
# │ 
# │ If you have feedback on the design of this feature, please open a GitHub issue to discuss it.
# ╵
# 
# Apply complete! Resources: 0 added, 0 changed, 24 destroyed.

# Lab05
# Atividade 5.4.
# 
# Crie uma automação para a criação de uma máquina virtual KVM utilizando libvirt.
# Crie um arquivo de clouinit para a configuração da máquina virtual e execução
# de comandos personalizados.


# Crie um arquivo chamado "~/terraform/lab05/exe04/main.tf", com o seguinte conteúdo:


terraform {
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
      version = "~> 0.7.6"
    }
  }
 required_version = ">= 1.6"
}

provider "libvirt" {
  uri = "qemu:///system"
}

resource "libvirt_volume" "volume" {
  name   = "t-ubuntu-test.qcow2"
  source = "https://cloud-images.ubuntu.com/releases/22.04/release/ubuntu-22.04-server-cloudimg-amd64.img"
  pool   = "VMs"
  format = "qcow2"
}

data "template_file" "user_data" {
  template = file("${path.module}/cloud_init.cfg")
}

data "template_file" "network_config" {
  template = file("${path.module}/network_config.cfg")
}

resource "libvirt_cloudinit_disk" "cloudinit" {
  name           = "cloudinit.iso"
  user_data      = data.template_file.user_data.rendered
  network_config = data.template_file.network_config.rendered
  pool           = libvirt_volume.volume.pool
}

resource "libvirt_domain" "vm" {
  name       = "t-ubuntu-test"
  memory     = "512"
  vcpu       = 1
  cloudinit  = libvirt_cloudinit_disk.cloudinit.id

  cpu {
    mode = "host-model"
  }

  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  console {
    type        = "pty"
    target_type = "virtio"
    target_port = "1"
  }

  network_interface {
    network_name   = "default"
    wait_for_lease = true
  }

  disk {
    volume_id = libvirt_volume.volume.id
    scsi      = true
  }

  graphics {
    type        = "spice"
    listen_type = "address"
  }
}


# Crie um arquivo chamado "~/terraform/lab05/exe04/output.tf", com o seguinte conteúdo:
# 
# output "ips" {
#   value = element(libvirt_domain.vm.network_interface[0].addresses, 0)
# }


# Crie um arquivo chamado "~/terraform/lab05/exe04/cloud_init.cfg", com o seguinte conteúdo:
# 
# #cloud-config
# # vim: syntax=yaml
# ssh_pwauth: true
# chpasswd:
#   list: |
#     root:linux
#     ubuntu:linux
#   expire: false
# 
# runcmd:
#   - echo "yes" > /root/cloud-init.ok


# Crie um arquivo chamado "~/terraform/lab05/exe04/network_config.cfg", com o seguinte conteúdo:
# 
# version: 2
# ethernets:
#   all:
#     match:
#       name: e*
#     dhcp4: true
#     dhcp6: false


# Execute o comando abaixo para inicializar o diretório do terraform:
# 
# $ terraform init
# 
# Initializing the backend...
# 
# Initializing provider plugins...
# - Finding dmacvicar/libvirt versions matching "~> 0.7.6"...
# - Finding latest version of hashicorp/template...
# - Installing dmacvicar/libvirt v0.7.6...
# - Installed dmacvicar/libvirt v0.7.6 (self-signed, key ID 0833E38C51E74D26)
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
# data.template_file.network_config: Reading...
# data.template_file.user_data: Reading...
# data.template_file.user_data: Read complete after 0s [id=d684cc9b7fe610f43285bfa28ff6ea0b6951d38700db4e3e89a49a5dc76b32b5]
# data.template_file.network_config: Read complete after 0s [id=98585aaf6c6ab040bbb6943114277cec19c43ff9543db03ed0d772104e8cf42e]
# 
# Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the
# following symbols:
#   + create
# 
# Terraform will perform the following actions:
# 
#   # libvirt_cloudinit_disk.cloudinit will be created
#   + resource "libvirt_cloudinit_disk" "cloudinit" {
#       + id             = (known after apply)
#       + name           = "cloudinit.iso"
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
#             runcmd:
#               - echo "yes" > /root/cloud-init.ok
#         EOT
#     }
# 
#   # libvirt_domain.vm will be created
#   + resource "libvirt_domain" "vm" {
#       + arch        = (known after apply)
#       + autostart   = (known after apply)
#       + cloudinit   = (known after apply)
#       + emulator    = (known after apply)
#       + fw_cfg_name = "opt/com.coreos/config"
#       + id          = (known after apply)
#       + machine     = (known after apply)
#       + memory      = 512
#       + name        = "t-ubuntu-test"
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
#   # libvirt_volume.volume will be created
#   + resource "libvirt_volume" "volume" {
#       + format = "qcow2"
#       + id     = (known after apply)
#       + name   = "t-ubuntu-test.qcow2"
#       + pool   = "VMs"
#       + size   = (known after apply)
#       + source = "https://cloud-images.ubuntu.com/releases/focal/release/ubuntu-20.04-server-cloudimg-amd64.img"
#     }
# 
# Plan: 3 to add, 0 to change, 0 to destroy.
# 
# Changes to Outputs:
#   + ips = [
#       + (known after apply),
#     ]
# libvirt_volume.volume: Creating...
# libvirt_volume.volume: Still creating... [10s elapsed]
# libvirt_volume.volume: Still creating... [20s elapsed]
# libvirt_volume.volume: Creation complete after 25s [id=/data/vms/t-ubuntu-test.qcow2]
# libvirt_cloudinit_disk.cloudinit: Creating...
# libvirt_cloudinit_disk.cloudinit: Creation complete after 1s [id=/data/vms/cloudinit.iso;5038ab32-7c38-4b07-a211-296618da0675]
# libvirt_domain.vm: Creating...
# libvirt_domain.vm: Still creating... [10s elapsed]
# libvirt_domain.vm: Still creating... [20s elapsed]
# libvirt_domain.vm: Creation complete after 24s [id=da3d6ad8-9c85-430f-800f-77f14f00e505]
# 
# Apply complete! Resources: 3 added, 0 changed, 0 destroyed.
# 
# Outputs:
# 
# ips = tolist([
#   tolist([
#     "192.168.1.104",
#   ]),
# ])


# Execute o comando abaixo para verificar que a máquina foi criada:
# 
# $ virsh list
#  Id   Name            State
# -------------------------------
#  2    docker          running
#  3    k8s             running
#  4    db              running
#  6    t-ubuntu-test   running


# Em seguida, obtenha o endereço IP gerado pela máquina virtual, conforme abaixo:
#
# $ terraform output ips
# tolist([
#   tolist([
#     "192.168.1.104",
#   ]),
# ])
#
# Observe que na sua máquina o endereço IP gerado pode ser diferente.


# Conecte-se por SSH na máquina virtual, utilizando o endereço IP reportado na saída acima.
# Lembre-se que a senha do usuário ubuntu é "linux".
# 
# $ ssh ubuntu@192.168.1.104
# The authenticity of host '192.168.1.104 (192.168.1.104)' can't be established.
# ECDSA key fingerprint is SHA256:biZBz/8Ob7G585g8i94rCx1TTGa5I621Os1qL7tcElY.
# Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
# Warning: Permanently added '192.168.1.104' (ECDSA) to the list of known hosts.
# ubuntu@192.168.1.104's password:
# Welcome to Ubuntu 20.04.6 LTS (GNU/Linux 5.4.0-167-generic x86_64)
# 
#  * Documentation:  https://help.ubuntu.com
#  * Management:     https://landscape.canonical.com
#  * Support:        https://ubuntu.com/advantage
# 
#   System information as of Sat Dec  2 20:19:01 UTC 2023
# 
#   System load:  0.03              Processes:             107
#   Usage of /:   72.7% of 1.96GB   Users logged in:       0
#   Memory usage: 39%               IPv4 address for ens3: 192.168.1.104
#   Swap usage:   0%
# 
# Expanded Security Maintenance for Applications is not enabled.
# 
# 0 updates can be applied immediately.
# 
# Enable ESM Apps to receive additional future security updates.
# See https://ubuntu.com/esm or run: sudo pro status
# 
# 
# 
# The programs included with the Ubuntu system are free software;
# the exact distribution terms for each program are described in the
# individual files in /usr/share/doc/*/copyright.
# 
# Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
# applicable law.
# 
# To run a command as administrator (user "root"), use "sudo <command>".
# See "man sudo_root" for details.
# 
# ubuntu@ubuntu:~$ logout
# Connection to 192.168.1.104 closed.


# Verifique que o arquivo da máquina virtual foi criado localmente, utilizando o comando abaixo:
#  
# $ ls -lh /data/vms/t-ubuntu-test.qcow2 
# -rw-r--r-- 1 qemu qemu 679M Dec  2 17:20 /data/vms/t-ubuntu-test.qcow2


# Execute o comando "terraform destroy" para destruir o ambiente, conforme abaixo:
# 
# azureroot@t01-tf201:~/terraform/lab05/exe04> terraform destroy
# data.template_file.network_config: Reading...
# data.template_file.user_data: Reading...
# data.template_file.network_config: Read complete after 0s [id=98585aaf6c6ab040bbb6943114277cec19c43ff9543db03ed0d772104e8cf42e]
# data.template_file.user_data: Read complete after 0s [id=d684cc9b7fe610f43285bfa28ff6ea0b6951d38700db4e3e89a49a5dc76b32b5]
# libvirt_volume.volume: Refreshing state... [id=/data/vms/t-ubuntu-test.qcow2]
# libvirt_cloudinit_disk.cloudinit: Refreshing state... [id=/data/vms/cloudinit.iso;5038ab32-7c38-4b07-a211-296618da0675]
# libvirt_domain.vm: Refreshing state... [id=da3d6ad8-9c85-430f-800f-77f14f00e505]
# 
# Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the
# following symbols:
#   - destroy
# 
# Terraform will perform the following actions:
# 
#   # libvirt_cloudinit_disk.cloudinit will be destroyed
#   - resource "libvirt_cloudinit_disk" "cloudinit" {
#       - id             = "/data/vms/cloudinit.iso;5038ab32-7c38-4b07-a211-296618da0675" -> null
#       - name           = "cloudinit.iso" -> null
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
#             runcmd:
#               - echo "yes" > /root/cloud-init.ok
#         EOT -> null
#     }
# 
#   # libvirt_domain.vm will be destroyed
#   - resource "libvirt_domain" "vm" {
#       - arch        = "x86_64" -> null
#       - autostart   = false -> null
#       - cloudinit   = "/data/vms/cloudinit.iso;5038ab32-7c38-4b07-a211-296618da0675" -> null
#       - cmdline     = [] -> null
#       - emulator    = "/usr/bin/qemu-system-x86_64" -> null
#       - fw_cfg_name = "opt/com.coreos/config" -> null
#       - id          = "da3d6ad8-9c85-430f-800f-77f14f00e505" -> null
#       - machine     = "pc" -> null
#       - memory      = 512 -> null
#       - name        = "t-ubuntu-test" -> null
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
#           - volume_id = "/data/vms/t-ubuntu-test.qcow2" -> null
#           - wwn       = "05abcd9dcd73c503" -> null
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
#               - "192.168.1.104",
#             ] -> null
#           - hostname       = "t-ubuntu-test" -> null
#           - mac            = "52:54:00:EE:94:8B" -> null
#           - network_id     = "c36decbb-311f-4e34-b1d3-dada42179db0" -> null
#           - network_name   = "default" -> null
#           - wait_for_lease = true -> null
#         }
#     }
# 
#   # libvirt_volume.volume will be destroyed
#   - resource "libvirt_volume" "volume" {
#       - format = "qcow2" -> null
#       - id     = "/data/vms/t-ubuntu-test.qcow2" -> null
#       - name   = "t-ubuntu-test.qcow2" -> null
#       - pool   = "VMs" -> null
#       - size   = 2361393152 -> null
#       - source = "https://cloud-images.ubuntu.com/releases/focal/release/ubuntu-20.04-server-cloudimg-amd64.img" -> null
#     }
# 
# Plan: 0 to add, 0 to change, 3 to destroy.
# 
# Changes to Outputs:
#   - ips = [
#       - [
#           - "192.168.1.104",
#         ],
#     ] -> null
# 
# Do you really want to destroy all resources?
#   Terraform will destroy all your managed infrastructure, as shown above.
#   There is no undo. Only 'yes' will be accepted to confirm.
# 
#   Enter a value: yes
# 
# libvirt_domain.vm: Destroying... [id=da3d6ad8-9c85-430f-800f-77f14f00e505]
# libvirt_domain.vm: Destruction complete after 1s
# libvirt_cloudinit_disk.cloudinit: Destroying... [id=/data/vms/cloudinit.iso;5038ab32-7c38-4b07-a211-296618da0675]
# libvirt_cloudinit_disk.cloudinit: Destruction complete after 0s
# libvirt_volume.volume: Destroying... [id=/data/vms/t-ubuntu-test.qcow2]
# libvirt_volume.volume: Destruction complete after 0s
# 
# Destroy complete! Resources: 3 destroyed.
# Lab05
# Atividade 5.5.
# 
# Crie uma automação para a criação de uma máquina virtual KVM utilizando libvirt.
# Crie um arquivo de clouinit para a configuração da máquina virtual e execução de
# comandos personalizados. Ao final, conecte por SSH utilizando terraform e
# execute mais alguns comandos de configuração.


# Crie um arquivo chamado "~/terraform/lab05/exe05/main.tf", com o seguinte conteúdo:


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

  provisioner "remote-exec" {
    inline = [
      "echo yes > ~/test.txt",
    ]

    connection {
      type        = "ssh"
      user        = "root"
      private_key = file("/home/azureroot/.ssh/id_rsa")
      host        = element(libvirt_domain.vm.network_interface[0].addresses, 0)
    }
  }
}


# Crie um arquivo chamado "~/terraform/lab05/exe05/output.tf", com o seguinte conteúdo:
# 
# output "ips" {
#   value = element(libvirt_domain.vm.network_interface[0].addresses, 0)
# }


# Execute o comando abaixo para gerar um par de chaves SSH para utilizar na conexão com
# a máquina virtual, mas não defina nenhuma senha para as chaves:
# (Caso o arquivo ~/.ssh/id_rsa.pub já existir, este comando não precisa ser executado novamente.)
# 
# $ ssh-keygen 
# 
# Generating public/private rsa key pair.
# Enter file in which to save the key (/home/azureroot/.ssh/id_rsa): 
# Enter passphrase (empty for no passphrase): 
# Enter same passphrase again: 
# Your identification has been saved in /home/azureroot/.ssh/id_rsa
# Your public key has been saved in /home/azureroot/.ssh/id_rsa.pub
# The key fingerprint is:
# SHA256:VHtKtxfT23tzVSM4iLFaFYyJpEo/3+RQwUk10Ze0QNU azureroot@t01-tf201
# The key's randomart image is:
# +---[RSA 3072]----+
# |    ..++***oooo  |
# |    .. =*ooooo.E |
# | . .   =..oo+oo.o|
# |. o   +. . +...o=|
# | . o o .S . . ..o|
# |    o =      .  o|
# |     . o       oo|
# |                +|
# |                 |
# +----[SHA256]-----+


# Crie um arquivo chamado "~/terraform/lab05/exe05/cloud_init.cfg", com o seguinte conteúdo:
# (Substitua o conteúdo do parâmetro ssh_authorized_keys pelo conteúdo do arquivo ~/.ssh/id_rsa.pub gerado acima)
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
# disable_root: false
# 
# users:
#   - name: root
#     ssh_authorized_keys:
#       - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDb6VI1UvD8kHvCfjioiFgTseLSn5/MvvAUKFp/miqjM5YOHMIEWvgKNNBoz5REYp2GKSVFiXBKcrsYq8FpZePd7CMX2NZoJOraEMl/2IqHeo2Y+Y1F+VWUilHx98Co/0epgRG1UgVY7ZxC0SjX2rjxBV4LOulOVxDjyJc/RUatT/x7D9gIKo2DW5z6U2zO4hiTvoeY9tU2XubgDNu7bkoL75U49uToKsy/R4Paf1EOHCC/Hfdxyoyx6yibNA5KxqManBMY4dcWAnt3O03pBW7vJRAJ2M9p7VJsx7iSRKdktdf6yr54UFhCFkMMTiEuto8RVIObNs5DYo5dYKWsNewwcoYsotFTPrXXb7FiMTTsGjPEJ57TzNupemmupmfTUPEDo2J/GLVI9ah9nilK+RU4uyvaO4SU6JpSplHGUJbMXd2gpm5ahoPjZ3thjuSbRbek/7cIxvaPB4OV6YBsM4qPYGxYTaiOfprXspe9vJvQlHLYeTCv1VErtyzXlWzFqpc= azureroot@terraform-01
# 
# runcmd:
#   - echo "yes" > /root/cloud-init.ok


# Crie um arquivo chamado "~/terraform/lab05/exe05/network_config.cfg", com o seguinte conteúdo:
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
# - Reusing previous version of dmacvicar/libvirt from the dependency lock file
# - Reusing previous version of hashicorp/template from the dependency lock file
# - Using previously-installed dmacvicar/libvirt v0.7.6
# - Using previously-installed hashicorp/template v2.2.0
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
# data.template_file.network_config: Read complete after 0s [id=98585aaf6c6ab040bbb6943114277cec19c43ff9543db03ed0d772104e8cf42e]
# data.template_file.user_data: Read complete after 0s [id=4550334f89885a433a7e230e1c373f3cc1006f412277dbeeac9e84e754704383]
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
#       + format = (known after apply)
#       + id     = (known after apply)
#       + name   = "t-ubuntu-test.qcow2"
#       + pool   = "VMs"
#       + size   = (known after apply)
#       + source = "https://cloud-images.ubuntu.com/releases/22.04/release/ubuntu-22.04-server-cloudimg-amd64.img"
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
# libvirt_cloudinit_disk.cloudinit: Creation complete after 0s [id=/data/vms/cloudinit.iso;51a9bba0-5c4f-4a97-8d93-bda11cbfc6b8]
# libvirt_domain.vm: Creating...
# libvirt_domain.vm: Still creating... [10s elapsed]
# libvirt_domain.vm: Still creating... [20s elapsed]
# libvirt_domain.vm: Still creating... [30s elapsed]
# libvirt_domain.vm: Provisioning with 'remote-exec'...
# libvirt_domain.vm (remote-exec): Connecting to remote host via SSH...
# libvirt_domain.vm (remote-exec):   Host: 192.168.1.107
# libvirt_domain.vm (remote-exec):   User: root
# libvirt_domain.vm (remote-exec):   Password: false
# libvirt_domain.vm (remote-exec):   Private key: true
# libvirt_domain.vm (remote-exec):   Certificate: false
# libvirt_domain.vm (remote-exec):   SSH Agent: false
# libvirt_domain.vm (remote-exec):   Checking Host Key: false
# libvirt_domain.vm (remote-exec):   Target Platform: unix
# libvirt_domain.vm (remote-exec): Connected!
# libvirt_domain.vm: Creation complete after 37s [id=7f53dfcd-7aba-4dff-8a3c-2feac61b528b]
# 
# Apply complete! Resources: 3 added, 0 changed, 0 destroyed.
# 
# Outputs:
# 
# ips = tolist([
#   tolist([
#     "192.168.1.107",
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
#  12   t-ubuntu-test   running


# Em seguida, obtenha o endereço IP gerado pela máquina virtual, conforme abaixo:
# $ terraform output ips
# tolist([
#   tolist([
#     "192.168.1.107",
#   ]),
# ])


# Conecte-se por SSH na máquina virtual, utilizando o endereço IP reportado na saída acima:
# 
# $ ssh root@192.168.1.107
# The authenticity of host '192.168.1.107 (192.168.1.107)' can't be established.
# ECDSA key fingerprint is SHA256:0NKGs/i5c3GbgkyhBRaJPrxvFEaKfYcv1qN3XLfC+JM.
# Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
# Warning: Permanently added '192.168.1.107' (ECDSA) to the list of known hosts.
# Welcome to Ubuntu 22.04.3 LTS (GNU/Linux 5.15.0-89-generic x86_64)
# 
#  * Documentation:  https://help.ubuntu.com
#  * Management:     https://landscape.canonical.com
#  * Support:        https://ubuntu.com/advantage
# 
#   System information as of Sat Dec  2 21:49:15 UTC 2023
# 
#   System load:  0.00146484375     Processes:             92
#   Usage of /:   73.0% of 1.96GB   Users logged in:       0
#   Memory usage: 38%               IPv4 address for ens3: 192.168.1.107
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
# 
# Last login: Sat Dec  2 21:43:47 2023 from 192.168.1.1
# root@ubuntu:~#
# logout
# Connection to 192.168.1.107 closed.


# Verifique que os comandos informados tanto no arquivo de cloudinit quanto o script definido na conexão SSH foram executados com sucesso.


# Execute o comando "terraform destroy" para destruir o ambiente, conforme abaixo:
# 
# $ terraform apply -auto-approve -destroy
# data.template_file.network_config: Reading...
# data.template_file.user_data: Reading...
# data.template_file.network_config: Read complete after 0s [id=98585aaf6c6ab040bbb6943114277cec19c43ff9543db03ed0d772104e8cf42e]
# data.template_file.user_data: Read complete after 0s [id=4550334f89885a433a7e230e1c373f3cc1006f412277dbeeac9e84e754704383]
# libvirt_volume.volume: Refreshing state... [id=/data/vms/t-ubuntu-test.qcow2]
# libvirt_cloudinit_disk.cloudinit: Refreshing state... [id=/data/vms/cloudinit.iso;51a9bba0-5c4f-4a97-8d93-bda11cbfc6b8]
# libvirt_domain.vm: Refreshing state... [id=7f53dfcd-7aba-4dff-8a3c-2feac61b528b]
# 
# Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the
# following symbols:
#   - destroy
# 
# Terraform will perform the following actions:
# 
#   # libvirt_cloudinit_disk.cloudinit will be destroyed
#   - resource "libvirt_cloudinit_disk" "cloudinit" {
#       - id             = "/data/vms/cloudinit.iso;51a9bba0-5c4f-4a97-8d93-bda11cbfc6b8" -> null
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
#   # libvirt_domain.vm will be destroyed
#   - resource "libvirt_domain" "vm" {
#       - arch        = "x86_64" -> null
#       - autostart   = false -> null
#       - cloudinit   = "/data/vms/cloudinit.iso;51a9bba0-5c4f-4a97-8d93-bda11cbfc6b8" -> null
#       - cmdline     = [] -> null
#       - emulator    = "/usr/bin/qemu-system-x86_64" -> null
#       - fw_cfg_name = "opt/com.coreos/config" -> null
#       - id          = "7f53dfcd-7aba-4dff-8a3c-2feac61b528b" -> null
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
#           - wwn       = "05abcdfd83e05267" -> null
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
#               - "192.168.1.107",
#             ] -> null
#           - hostname       = "t-ubuntu-test" -> null
#           - mac            = "52:54:00:BE:52:BE" -> null
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
#       - source = "https://cloud-images.ubuntu.com/releases/22.04/release/ubuntu-22.04-server-cloudimg-amd64.img" -> null
#     }
# 
# Plan: 0 to add, 0 to change, 3 to destroy.
# 
# Changes to Outputs:
#   - ips = [
#       - [
#           - "192.168.1.107",
#         ],
#     ] -> null
# libvirt_domain.vm: Destroying... [id=7f53dfcd-7aba-4dff-8a3c-2feac61b528b]
# libvirt_domain.vm: Destruction complete after 1s
# libvirt_cloudinit_disk.cloudinit: Destroying... [id=/data/vms/cloudinit.iso;51a9bba0-5c4f-4a97-8d93-bda11cbfc6b8]
# libvirt_cloudinit_disk.cloudinit: Destruction complete after 0s
# libvirt_volume.volume: Destroying... [id=/data/vms/t-ubuntu-test.qcow2]
# libvirt_volume.volume: Destruction complete after 0s
# 
# Apply complete! Resources: 0 added, 0 changed, 3 destroyed.
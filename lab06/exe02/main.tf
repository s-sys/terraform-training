# Lab06
# Atividade 6.2.
# 
# Crie uma automação para a criação de máquinas virtuais em ambiente Libvirt com KVM. A automação deverá permitir a criação de 1 máquina para o ambiente de "dev" e "qa" e 3 máquinas pra o ambiente de "prod". Os nomes das máquinas devem ser prefixadas com o tipo de ambiente. Utilize o recurso de workspaces do terraform para criar e disponibilizar as máquinas para os 3 ambientes.

# Crie um arquivo chamado "~/terraform/lab06/exe02/main.tf", com o seguinte conteúdo:
 
terraform {
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
      version = "~> 0.6.11"
    }
  }
  required_version = ">= 0.13"
  experiments      = [module_variable_optional_attrs]
}

provider "libvirt" {
  uri = "qemu:///system"
}

locals {
  env       = terraform.workspace == "default" ? "prod" : terraform.workspace
  instances = (
              terraform.workspace == "default"
              ? [for i in var.vms : (substr(i.name, 0, 5) == "prod-" ? i.name : "prod-${i.name}")]
                : (terraform.workspace == "dev"
                ? [for i in var.vms : (substr(i.name, 0, 4) == "dev-" ? i.name : "dev-${i.name}")]
                  : (terraform.workspace == "qa"
                  ? [for i in var.vms : (substr(i.name, 0, 3) == "qa-" ? i.name : "qa-${i.name}")]
                   : null
                     )
                  )
              )
  num_vms   = length(local.instances)
}

resource "libvirt_volume" "volume" {
  count  = local.num_vms 
  name   = "${local.instances[count.index]}.qcow2"
  source = "https://cloud-images.ubuntu.com/releases/focal/release/ubuntu-20.04-server-cloudimg-amd64.img"
  pool   = "VMs"
}

data "template_file" "user_data" {
  count    = length(local.instances)
  template = file("${path.module}/cloud_init.cfg")

  vars = {
    hostname = local.instances[count.index] 
  }
}

data "template_file" "network_config" {
  template = file("${path.module}/network_config.cfg")
}

resource "libvirt_cloudinit_disk" "cloudinit" {
  count          = local.num_vms
  name           = "cloudinit-${local.instances[count.index]}.iso"
  user_data      = data.template_file.user_data[count.index].rendered
  network_config = data.template_file.network_config.rendered
  pool           = libvirt_volume.volume[count.index].pool
}

resource "libvirt_domain" "vm" {
  count      = local.num_vms
  name       = local.instances[count.index]
  memory     = var.vms[count.index].memory == null ? 640 : var.vms[count.index].memory
  vcpu       = var.vms[count.index].vcpu   == null ? 2   : var.vms[count.index].vcpu
  qemu_agent = true
  cloudinit  = libvirt_cloudinit_disk.cloudinit[count.index].id

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
    volume_id = libvirt_volume.volume[count.index].id
    scsi      = true
  }

  graphics {
    type        = "spice"
    listen_type = "address"
  }
}


# Crie um arquivo chamado "~/terraform/lab06/exe02/output.tf", com o seguinte conteúdo:
# 
# output "ips" {
#   value = libvirt_domain.vm[*].network_interface[0].addresses[0]
# }


# Crie um arquivo chamado "~/terraform/lab06/exe02/cloud_init.cfg", com o seguinte conteúdo:
# 
#cloud-config
# vim: syntax=yaml
# ssh_pwauth: true
# chpasswd:
#   list: |
#     root:linux
#     ubuntu:linux
#   expire: false
# 
# disable_root: false
# 
# ssh_authorized_keys:
#     - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDb6VI1UvD8kHvCfjioiFgTseLSn5/MvvAUKFp/miqjM5YOHMIEWvgKNNBoz5REYp2GKSVFiXBKcrsYq8FpZePd7CMX2NZoJOraEMl/2IqHeo2Y+Y1F+VWUilHx98Co/0epgRG1UgVY7ZxC0SjX2rjxBV4LOulOVxDjyJc/RUatT/x7D9gIKo2DW5z6U2zO4hiTvoeY9tU2XubgDNu7bkoL75U49uToKsy/R4Paf1EOHCC/Hfdxyoyx6yibNA5KxqManBMY4dcWAnt3O03pBW7vJRAJ2M9p7VJsx7iSRKdktdf6yr54UFhCFkMMTiEuto8RVIObNs5DYo5dYKWsNewwcoYsotFTPrXXb7FiMTTsGjPEJ57TzNupemmupmfTUPEDo2J/GLVI9ah9nilK+RU4uyvaO4SU6JpSplHGUJbMXd2gpm5ahoPjZ3thjuSbRbek/7cIxvaPB4OV6YBsM4qPYGxYTaiOfprXspe9vJvQlHLYeTCv1VErtyzXlWzFqpc= azureroot@terraform-01


# Obtenha o conteúdo do arquivo "~/.ssh/id_rsa.pub" e faça a alteração do arquivo "cloud_init.cfg" acima.


# Crie um arquivo chamado "~/terraform/lab06/exe02/network_config.cfg", com o seguinte conteúdo:
# 
# version: 2
# ethernets:
#   all:
#     match:
#       name: e*
#     dhcp4: true
#     dhcp6: false


# Crie um arquivo chamado "~/terraform/lab06/exe02/terraform-dev.tfvars", com o seguinte conteúdo:
#
# vms = [
#   {
#    name   = "vm1"
#    vcpu   = 1
#   },
# ]


# Crie um arquivo chamado "~/terraform/lab06/exe02/terraform-qa.tfvars", com o seguinte conteúdo:
#
# vms = [
#   {
#    name   = "vm1"
#    memory = 512
#   },
# ]


# Crie um arquivo chamado "~/terraform/lab06/exe02/terraform-prod.tfvars", com o seguinte conteúdo:
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
# ]


# Execute os comandos abaixo para criar e listar os workspaces:
# 
# $ terraform workspace new dev
# 
# Created and switched to workspace "dev"!
# 
# You're now on a new, empty workspace. Workspaces isolate their state,
# so if you run "terraform plan" Terraform will not see any existing state
# for this configuration.


# $ terraform workspace new qa
# 
# Created and switched to workspace "qa"!
# 
# You're now on a new, empty workspace. Workspaces isolate their state,
# so if you run "terraform plan" Terraform will not see any existing state
# for this configuration.


# $ terraform workspace list
#   default
#   dev
# * qa


# Execute o comando abaixo para inicializar o diretório do terraform:
# 
# $ terraform init


# Em seguida execute o comando abaixo em todos os ambientes para aplicar a configuração do terraform:
# 
# $ terraform workspace select default
# Switched to workspace "default".
# 
# $ terraform apply -auto-approve -var-file terraform-prod.tfvars
#


# $ terraform workspace select dev
# Switched to workspace "dev".
# 
# $ terraform apply -auto-approve -var-file terraform-dev.tfvars
# 


# $ terraform workspace select qa
# Switched to workspace "qa".
# 
# $ terraform apply -auto-approve -var-file terraform-qa.tfvars
# 


# Execute o comando abaixo para verificar que as máquinas foram criadas:
# 
# $ virsh list
# 
#  Id   Name        State
# ---------------------------
#  1    docker      running
#  3    databases   running
#  71   minikube    running
#  72   prod-vm3    running
#  73   prod-vm1    running
#  74   prod-vm2    running
#  75   qa-vm1      running
#  76   dev-vm1     running


# Verifique no diretório "terraform.tfstate.d" que os arquivos de estado foram criados para cada workspace:
# 
# $ ls -lR terraform.tfstate.d/
# terraform.tfstate.d/:
# total 8
# drwxr-xr-x 2 azureroot azureroot 4096 Oct 18 03:03 dev
# drwxr-xr-x 2 azureroot azureroot 4096 Oct 18 03:02 qa
# 
# terraform.tfstate.d/dev:
# total 12
# -rw-rw-r-- 1 azureroot azureroot 8835 Oct 18 03:03 terraform.tfstate
# 
# terraform.tfstate.d/qa:
# total 12
# -rw-rw-r-- 1 azureroot azureroot 8827 Oct 18 03:02 terraform.tfstate
# 
# O arquivo de estado para o workspace "default" continua no mesmo local em "terraform.tfstate".


# Execute o comando "terraform destroy" para cada um dos workspaces para destruir os ambientes, conforme abaixo:
# 
# $ terraform workspace select default
# Switched to workspace "default".
# 
# $ terraform apply -auto-approve -destroy -var-file terraform-prod.tfvars
# 


# $ terraform workspace select dev
# Switched to workspace "dev".
# 
# $ terraform apply -auto-approve -destroy -var-file terraform-dev.tfvars
# 


# $ terraform workspace select qa
# Switched to workspace "qa".
# 
# $ terraform apply -auto-approve -destroy -var-file terraform-qa.tfvars
# 

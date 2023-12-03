# Lab06
# Atividade 6.3.
# 
# Crie uma automação para a criação de máquinas virtuais em ambiente Libvirt com KVM.
# A automação deve manter os estados armazenados no Terraform Cloud. Crie uma conta
# no portal do Terraform e visualize os estados na plataforma web.

# Crie um arquivo chamado "~/terraform/lab06/exe03/main.tf", com o seguinte conteúdo:
 
terraform {
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
      version = "~> 0.7.6"
    }
  }

  backend "remote" {
    organization = "SUA-ORG-AQUI"

    workspaces {
      name = "SEU-WORKSPACE-AQUI"
    }
  }

  required_version = ">= 1.6"
}

provider "libvirt" {
  uri = "qemu:///system"
}

locals {
  instances = [for i in var.vms : (substr(i.name, 0, 5) == "prod-" ? i.name : "prod-${i.name}")]
  num_vms   = length(local.instances)
}

resource "libvirt_volume" "volume" {
  count  = local.num_vms 
  name   = "${local.instances[count.index]}.qcow2"
  source = "https://cloud-images.ubuntu.com/releases/22.04/release/ubuntu-22.04-server-cloudimg-amd64.img"
  pool   = "VMs"
  format = "qcow2"
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


# Crie um arquivo chamado "~/terraform/lab06/exe03/output.tf", com o seguinte conteúdo:
# 
# output "ips" {
#   value = libvirt_domain.vm[*].network_interface[0].addresses[0]
# }


# Crie um arquivo chamado "~/terraform/lab06/exe03/cloud_init.cfg", com o seguinte conteúdo:
# 
# #cloud-config
# # vim: syntax=yaml
# hostname: ${hostname}
# 
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


# Obtenha o conteúdo do arquivo "~/.ssh/id_rsa.pub" e faça a alteração do arquivo "cloud_init.cfg" acima.
#


# Crie um arquivo chamado "~/terraform/lab06/exe03/network_config.cfg",
# com o seguinte conteúdo:
# 
# version: 2
# ethernets:
#   all:
#     match:
#       name: e*
#     dhcp4: true
#     dhcp6: false


# Crie um arquivo chamado "~/terraform/lab06/exe03/terraform.auto.tfvars",
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
# ]


# Acesso o site https://portal.cloud.hashicorp.com/sign-in e faça o registro de um
# novo usuário, caso não tenha uma conta de acesso.
# 
# Após logar no portal, selecione a opção "Services" e o item "Terraform" e clique
# no link "Sign in to Terraform Cloud". Crie seu usuário caso não tenha um usuário
# já criado.
# 
# Clique na opção "Create an organization".
# No campo "Organization name" digite um nome de organização e clique em
# "Create organization".
# 
# Selecione a organização criada e clique no canto superior direito na opção
# "New workspace".
# Selecione a opção "CLI-driven workflow" na opção "Choose Type".
# Na aba "Configure settings" digite o nome do workspace no campo "Workspace Name".
# Pode ser um nome como "terraform-training" e digite uma descrição. Ao final,
# clique na opção "Create workspace".
# 
# Na aba de "Overview" verifique o código de exemplo para a definição do backend,
# e faça os ajustes adequados no seu arquivo "main.tf".
# 
# Clique na opção "Settings" e selecione "General".
# 
# Selecione a opção "Execution Mode" como "Local".


# Execute o comando abaixo para fazer login no backend local:
# 
# $ terraform login
# 
# Será aberto o navegador para que você digite suas credenciais.
# 
# Caso desejo gerar o token manualmente acesso o endereço
# https://app.terraform.io/app/settings/tokens?source=terraform-login e clique na opção
# "Create an API token".


# Execute o comando abaixo para inicializar o diretório do terraform:
# 
# $ terraform init


# Em seguida execute o comando abaixo para aplicar a configuração do terraform:
# 
# $ terraform apply -auto-approve
#


# Execute o comando abaixo para verificar que as máquinas foram criadas:
# 
# $ virsh list
# 
#  Id   Name       State
# --------------------------
#  1    docker     running
#  2    k8s        running
#  3    db         running
#  57   prod-vm2   running
#  58   prod-vm3   running
#  59   prod-vm1   running


# Conecte-se no portal do Terraform e selecione o workspace que você criou.
# Verifique que os dados de estado do seu código estão salvos no portal.
# 
# Através deste recurso, qualquer outro usuário com acesso ao mesmo código
# terá a visão dos estados, pois os mesmos são mantidos no Terraform Cloud.


# Execute o comando "terraform destroy" para destruir o ambiente, conforme abaixo:
# 
# $ terraform apply -auto-approve -destroy
# 
# Lab03
# Atividade 3.4.
# 
# Utilize o terraform para automatizar a criação de um container docker e faça uma análise do ambiente gerado.


# Crie um arquivo chamado "~/terraform/lab03/exe04/main.tf", com o seguinte conteúdo:

terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.15.0"
    }
  }
}

provider "docker" {
  host = "tcp://192.168.1.11:2375"
}

resource "docker_image" "ubuntu" {
  name         = "ubuntu:focal"
  keep_locally = false
}

resource "docker_container" "ubuntu" {
  image   = docker_image.ubuntu.name
  name    = "ubuntu"
  command = ["tail", "-f", "/dev/null"]
}


# Execute o comando abaixo para inicializar o diretório do terraform e verifique a saída do comando:
#
# $ terraform init
# 
# Na sequência execute o comando abaixo para validar o plano de execução do terraform:
# 
# $ terraform plan
# 
# Em seguida execute o comando abaixo para aplicar a configuração do terraform:
# 
# $ terraform apply
# 
# Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
#   + create
# 
# Terraform will perform the following actions:
# 
#   # docker_container.ubuntu will be created
#   + resource "docker_container" "ubuntu" {
#       + attach           = false
#       + bridge           = (known after apply)
#       + command          = [
#           + "tail",
#           + "-f",
#           + "/dev/null",
#         ]
#       + container_logs   = (known after apply)
#       + entrypoint       = (known after apply)
#       + env              = (known after apply)
#       + exit_code        = (known after apply)
#       + gateway          = (known after apply)
#       + hostname         = (known after apply)
#       + id               = (known after apply)
#       + image            = "ubuntu:focal"
#       + init             = (known after apply)
#       + ip_address       = (known after apply)
#       + ip_prefix_length = (known after apply)
#       + ipc_mode         = (known after apply)
#       + log_driver       = "json-file"
#       + logs             = false
#       + must_run         = true
#       + name             = "ubuntu"
#       + network_data     = (known after apply)
#       + read_only        = false
#       + remove_volumes   = true
#       + restart          = "no"
#       + rm               = false
#       + security_opts    = (known after apply)
#       + shm_size         = (known after apply)
#       + start            = true
#       + stdin_open       = false
#       + tty              = false
# 
#       + healthcheck {
#           + interval     = (known after apply)
#           + retries      = (known after apply)
#           + start_period = (known after apply)
#           + test         = (known after apply)
#           + timeout      = (known after apply)
#         }
# 
#       + labels {
#           + label = (known after apply)
#           + value = (known after apply)
#         }
#     }
# 
#   # docker_image.ubuntu will be created
#   + resource "docker_image" "ubuntu" {
#       + id           = (known after apply)
#       + keep_locally = false
#       + latest       = (known after apply)
#       + name         = "ubuntu:focal"
#       + output       = (known after apply)
#       + repo_digest  = (known after apply)
#     }
# 
# Plan: 2 to add, 0 to change, 0 to destroy.
# 
# Do you want to perform these actions?
#   Terraform will perform the actions described above.
#   Only 'yes' will be accepted to approve.
# 
#   Enter a value: yes
# 
# docker_image.ubuntu: Creating...
# docker_image.ubuntu: Creation complete after 1s [id=sha256:597ce1600cf4ac5f449b66e75e840657bb53864434d6bd82f00b172544c32ee2ubuntu:focal]
# docker_container.ubuntu: Creating...
# docker_container.ubuntu: Creation complete after 1s [id=b773258baa2ddffc60f4ea943a30b2cee856286c10b198a3a0e3feb8a097855c]
# 
# Apply complete! Resources: 2 added, 0 changed, 0 destroyed.


# Verifique se o container foi criado, executando o comando abaixo:
# 
# $ docker ps
# CONTAINER ID   IMAGE          COMMAND               CREATED         STATUS         PORTS     NAMES
# b773258baa2d   ubuntu:focal   "tail -f /dev/null"   9 minutes ago   Up 9 minutes             ubuntu


# Conecte-se ao container para verificar sua funcionalidade, conforme abaixo:
# 
# $ docker exec -it ubuntu /bin/bash
# root@b773258baa2d:/# cat /etc/os-release 
# NAME="Ubuntu"
# VERSION="20.04.3 LTS (Focal Fossa)"
# ID=ubuntu
# ID_LIKE=debian
# PRETTY_NAME="Ubuntu 20.04.3 LTS"
# VERSION_ID="20.04"
# HOME_URL="https://www.ubuntu.com/"
# SUPPORT_URL="https://help.ubuntu.com/"
# BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
# PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
# VERSION_CODENAME=focal
# UBUNTU_CODENAME=focal


# Execute o comando "terraform destroy" para destruir o ambiente, conforme abaixo:
# 
# $ terraform destroy


# Verifque que o container foi destruído, executando o comando abaixo:
# 
# $ docker ps
# CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES

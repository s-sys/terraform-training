# Lab03
# Atividade 3.4.
# 
# Utilize o terraform para automatizar a criação de um container docker e faça
# uma análise do ambiente gerado.


# Crie um arquivo chamado "~/terraform/lab03/exe04/main.tf",
# com o seguinte conteúdo:

terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {
  host = "tcp://192.168.1.11:2375"
}

resource "docker_image" "ubuntu" {
  name         = "ubuntu:jammy"
  keep_locally = false
}

resource "docker_container" "ubuntu" {
  image   = docker_image.ubuntu.name
  name    = "ubuntu"
  command = ["tail", "-f", "/dev/null"]
}


# Execute o comando abaixo para inicializar o diretório do terraform e verifique
# a saída do comando:
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
# Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following
# symbols:
#   + create
# 
# Terraform will perform the following actions:
# 
#   # docker_container.ubuntu will be created
#   + resource "docker_container" "ubuntu" {
#       + attach                                      = false
#       + bridge                                      = (known after apply)
#       + command                                     = [
#           + "tail",
#           + "-f",
#           + "/dev/null",
#         ]
#       + container_logs                              = (known after apply)
#       + container_read_refresh_timeout_milliseconds = 15000
#       + entrypoint                                  = (known after apply)
#       + env                                         = (known after apply)
#       + exit_code                                   = (known after apply)
#       + hostname                                    = (known after apply)
#       + id                                          = (known after apply)
#       + image                                       = "ubuntu:jammy"
#       + init                                        = (known after apply)
#       + ipc_mode                                    = (known after apply)
#       + log_driver                                  = (known after apply)
#       + logs                                        = false
#       + must_run                                    = true
#       + name                                        = "ubuntu"
#       + network_data                                = (known after apply)
#       + read_only                                   = false
#       + remove_volumes                              = true
#       + restart                                     = "no"
#       + rm                                          = false
#       + runtime                                     = (known after apply)
#       + security_opts                               = (known after apply)
#       + shm_size                                    = (known after apply)
#       + start                                       = true
#       + stdin_open                                  = false
#       + stop_signal                                 = (known after apply)
#       + stop_timeout                                = (known after apply)
#       + tty                                         = false
#       + wait                                        = false
#       + wait_timeout                                = 60
#     }
# 
#   # docker_image.ubuntu will be created
#   + resource "docker_image" "ubuntu" {
#       + id           = (known after apply)
#       + image_id     = (known after apply)
#       + keep_locally = false
#       + name         = "ubuntu:jammy"
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
# docker_image.ubuntu: Creation complete after 3s [id=sha256:e4c58958181a5925816faa528ce959e487632f4cfd192f8132f71b32df2744b4ubuntu:jammy]
# docker_container.ubuntu: Creating...
# docker_container.ubuntu: Creation complete after 2s [id=e17e34282e2246c307163998ed351d097e4ac41df556767ecac038ec37f5ab99]
# 
# Apply complete! Resources: 2 added, 0 changed, 0 destroyed.


# Verifique se o container foi criado, executando o comando abaixo:
# 
# $ docker ps
# CONTAINER ID   IMAGE          COMMAND               CREATED          STATUS          PORTS     NAMES
# e17e34282e22   ubuntu:jammy   "tail -f /dev/null"   44 seconds ago   Up 42 seconds             ubuntu


# Conecte-se ao container para verificar sua funcionalidade, conforme abaixo:
# 
# $ docker exec -it ubuntu /bin/bash
# root@b773258baa2d:/# cat /etc/os-release 
# PRETTY_NAME="Ubuntu 22.04.3 LTS"
# NAME="Ubuntu"
# VERSION_ID="22.04"
# VERSION="22.04.3 LTS (Jammy Jellyfish)"
# VERSION_CODENAME=jammy
# ID=ubuntu
# ID_LIKE=debian
# HOME_URL="https://www.ubuntu.com/"
# SUPPORT_URL="https://help.ubuntu.com/"
# BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
# PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
# UBUNTU_CODENAME=jammy


# Feche o terminal utilizando o comando:
# exit


# Execute o comando "terraform destroy" para destruir o ambiente, conforme abaixo:
# 
# $ terraform destroy


# Verifque que o container foi destruído, executando o comando abaixo:
# 
# $ docker ps
# CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES

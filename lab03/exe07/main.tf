# Lab03
# Atividade 3.7.
# 
# Utilize o terraform para automatizar o deploy de 3 servidores web nginx e faça
# operações de remoção e importação de recursos no terraform.

# Crie um arquivo chamado "~/terraform/lab03/exe07/main.tf", com o seguinte conteúdo:


terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

variable "ext_port" {
  type = list(number)
}

provider "docker" {
  host = "tcp://192.168.1.11:2375"
}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "nginx" {
  count = 3
  image = docker_image.nginx.name
  name  = "web-${count.index}"
  ports {
    internal = 80
    external = var.ext_port[count.index]
  }
}


# Crie o arquivo "~/terraform/lab03/exe07/terraform.tfvars" com o seguinte
# conteúdo:
# 
# ext_port = [8000, 8001, 8002]


# Execute o comando abaixo para inicializar o diretório do terraform e verifique
# a saída do comando:
#
# $ terraform init
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
#   # docker_container.nginx[0] will be created
#   + resource "docker_container" "nginx" {
#       + attach                                      = false
#       + bridge                                      = (known after apply)
#       + command                                     = (known after apply)
#       + container_logs                              = (known after apply)
#       + container_read_refresh_timeout_milliseconds = 15000
#       + entrypoint                                  = (known after apply)
#       + env                                         = (known after apply)
#       + exit_code                                   = (known after apply)
#       + hostname                                    = (known after apply)
#       + id                                          = (known after apply)
#       + image                                       = "nginx:latest"
#       + init                                        = (known after apply)
#       + ipc_mode                                    = (known after apply)
#       + log_driver                                  = (known after apply)
#       + logs                                        = false
#       + must_run                                    = true
#       + name                                        = "web-0"
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
# 
#       + ports {
#           + external = 8000
#           + internal = 80
#           + ip       = "0.0.0.0"
#           + protocol = "tcp"
#         }
#     }
# 
#   # docker_container.nginx[1] will be created
#   + resource "docker_container" "nginx" {
#       + attach                                      = false
#       + bridge                                      = (known after apply)
#       + command                                     = (known after apply)
#       + container_logs                              = (known after apply)
#       + container_read_refresh_timeout_milliseconds = 15000
#       + entrypoint                                  = (known after apply)
#       + env                                         = (known after apply)
#       + exit_code                                   = (known after apply)
#       + hostname                                    = (known after apply)
#       + id                                          = (known after apply)
#       + image                                       = "nginx:latest"
#       + init                                        = (known after apply)
#       + ipc_mode                                    = (known after apply)
#       + log_driver                                  = (known after apply)
#       + logs                                        = false
#       + must_run                                    = true
#       + name                                        = "web-1"
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
# 
#       + ports {
#           + external = 8001
#           + internal = 80
#           + ip       = "0.0.0.0"
#           + protocol = "tcp"
#         }
#     }
# 
#   # docker_container.nginx[2] will be created
#   + resource "docker_container" "nginx" {
#       + attach                                      = false
#       + bridge                                      = (known after apply)
#       + command                                     = (known after apply)
#       + container_logs                              = (known after apply)
#       + container_read_refresh_timeout_milliseconds = 15000
#       + entrypoint                                  = (known after apply)
#       + env                                         = (known after apply)
#       + exit_code                                   = (known after apply)
#       + hostname                                    = (known after apply)
#       + id                                          = (known after apply)
#       + image                                       = "nginx:latest"
#       + init                                        = (known after apply)
#       + ipc_mode                                    = (known after apply)
#       + log_driver                                  = (known after apply)
#       + logs                                        = false
#       + must_run                                    = true
#       + name                                        = "web-2"
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
# 
#       + ports {
#           + external = 8002
#           + internal = 80
#           + ip       = "0.0.0.0"
#           + protocol = "tcp"
#         }
#     }
# 
#   # docker_image.nginx will be created
#   + resource "docker_image" "nginx" {
#       + id           = (known after apply)
#       + image_id     = (known after apply)
#       + keep_locally = false
#       + name         = "nginx:latest"
#       + repo_digest  = (known after apply)
#     }
# 
# Plan: 4 to add, 0 to change, 0 to destroy.
# 
# Do you want to perform these actions?
#   Terraform will perform the actions described above.
#   Only 'yes' will be accepted to approve.
# 
#   Enter a value: yes
# 
# docker_image.nginx: Creating...
# docker_image.nginx: Creation complete after 5s [id=sha256:593aee2afb642798b83a85306d2625fd7f089c0a1242c7e75a237846d80aa2a0nginx:latest]
# docker_container.nginx[1]: Creating...
# docker_container.nginx[2]: Creating...
# docker_container.nginx[0]: Creating...
# docker_container.nginx[0]: Creation complete after 4s [id=2e2ff12a327c433339d01f7118289089914e6c2ee9121af0317af4650ea3df22]
# docker_container.nginx[2]: Creation complete after 4s [id=ee52d6bbb8d90117843a7db2e3ff8c16b42f73090921432d0671e2213fa27796]
# docker_container.nginx[1]: Creation complete after 4s [id=3ec47d29e47e7150eabf6a97e85259c871ea70d6d630bbca49b0e5617bb9300c]
# 
# Apply complete! Resources: 4 added, 0 changed, 0 destroyed.


# Verifique se os containers foram criados, executando o comando abaixo:
# 
# $ docker ps 
# CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS          PORTS                  NAMES
# 2e2ff12a327c   nginx:latest   "/docker-entrypoint.…"   28 seconds ago   Up 23 seconds   0.0.0.0:8000->80/tcp   web-0
# ee52d6bbb8d9   nginx:latest   "/docker-entrypoint.…"   28 seconds ago   Up 23 seconds   0.0.0.0:8002->80/tcp   web-2
# 3ec47d29e47e   nginx:latest   "/docker-entrypoint.…"   28 seconds ago   Up 23 seconds   0.0.0.0:8001->80/tcp   web-1


# Verifique os states criados, conforme o comando abaixo:
# 
# $ terraform state list
# docker_container.nginx[0]
# docker_container.nginx[1]
# docker_container.nginx[2]
# docker_image.nginx


# Verifique as informações de um dos states, conforme comando abaixo:
# 
# $ terraform state show docker_container.nginx[1] 
# # docker_container.nginx[1]:
# resource "docker_container" "nginx" {
#     attach                                      = false
#     command                                     = [
#         "nginx",
#         "-g",
#         "daemon off;",
#     ]
#     container_read_refresh_timeout_milliseconds = 15000
#     cpu_shares                                  = 0
#     entrypoint                                  = [
#         "/docker-entrypoint.sh",
#     ]
#     env                                         = []
#     hostname                                    = "3ec47d29e47e"
#     id                                          = "3ec47d29e47e7150eabf6a97e85259c871ea70d6d630bbca49b0e5617bb9300c"
#     image                                       = "sha256:593aee2afb642798b83a85306d2625fd7f089c0a1242c7e75a237846d80aa2a0"
#     init                                        = false
#     ipc_mode                                    = "private"
#     log_driver                                  = "json-file"
#     logs                                        = false
#     max_retry_count                             = 0
#     memory                                      = 0
#     memory_swap                                 = 0
#     must_run                                    = true
#     name                                        = "web-1"
#     network_data                                = [
#         {
#             gateway                   = "172.17.0.1"
#             global_ipv6_address       = ""
#             global_ipv6_prefix_length = 0
#             ip_address                = "172.17.0.4"
#             ip_prefix_length          = 16
#             ipv6_gateway              = ""
#             mac_address               = "02:42:ac:11:00:04"
#             network_name              = "bridge"
#         },
#     ]
#     network_mode                                = "default"
#     privileged                                  = false
#     publish_all_ports                           = false
#     read_only                                   = false
#     remove_volumes                              = true
#     restart                                     = "no"
#     rm                                          = false
#     runtime                                     = "runc"
#     security_opts                               = []
#     shm_size                                    = 64
#     start                                       = true
#     stdin_open                                  = false
#     stop_signal                                 = "SIGQUIT"
#     stop_timeout                                = 0
#     tty                                         = false
#     wait                                        = false
#     wait_timeout                                = 60
# 
#     ports {
#         external = 8001
#         internal = 80
#         ip       = "0.0.0.0"
#         protocol = "tcp"
#     }
# }


# Remova o state docker_container.nginx[1] do gerenciamento pelo terraform, utilizando o comando abaixo:
# 
# $ terraform state rm docker_container.nginx[1]
# Removed docker_container.nginx[1]
# Successfully removed 1 resource instance(s).


# Verifique os states existentes, conforme o comando abaixo:
# 
# $ terraform state list
# docker_container.nginx[0]
# docker_container.nginx[2]
# docker_image.nginx


# Para importar o recurso novamente para o terraform, precisamos obter as informações
# de identificação do objeto. Utilize os comandos abaixo para obter o ID do container
# docker e utilize o comando "terraform import" para importar o recurso:
# 
# $ docker inspect web-1
# [
#     {
#         "Id": "3ec47d29e47e7150eabf6a97e85259c871ea70d6d630bbca49b0e5617bb9300c",
#         "Created": "2023-10-25T13:37:10.109031518Z",
#         "Path": "/docker-entrypoint.sh",
#         "Args": [
#             "nginx",
#             "-g",
#             "daemon off;"
#         ],
#         "State": {
#             "Status": "running",
#             "Running": true,
#             "Paused": false,
#             "Restarting": false,
#             "OOMKilled": false,
#             "Dead": false,
#             "Pid": 4004,
#             "ExitCode": 0,
#             "Error": "",
#             "StartedAt": "2023-10-25T13:37:14.24677451Z",
#             "FinishedAt": "0001-01-01T00:00:00Z"
#         },
# ...
#  
# De posse do ID acima, execute o comando "terraform import", conforme comando abaixo:
# 
# $ terraform import docker_container.nginx[1] 3ec47d29e47e7150eabf6a97e85259c871ea70d6d630bbca49b0e5617bb9300c
# docker_container.nginx[1]: Importing from ID "3ec47d29e47e7150eabf6a97e85259c871ea70d6d630bbca49b0e5617bb9300c"...
# docker_container.nginx[1]: Import prepared!
#   Prepared docker_container for import
# docker_container.nginx[1]: Refreshing state... [id=3ec47d29e47e7150eabf6a97e85259c871ea70d6d630bbca49b0e5617bb9300c]
# 
# Import successful!
# 
# The resources that were imported are shown above. These resources are now in
# your Terraform state and will henceforth be managed by Terraform.


# Verifique os states existentes, conforme o comando abaixo:
# 
# $ terraform state list
# docker_container.nginx[0]
# docker_container.nginx[1]
# docker_container.nginx[2]
# docker_image.nginx


# Execute o comando "terraform destroy" para destruir o ambiente, conforme abaixo:
# 
# $ terraform destroy

# Lab03
# Atividade 3.7.
# 
# Utilize o terraform para automatizar o deploy de 3 servidores web nginx e faça operações de remoção e importação de recursos no terraform.

# Crie um arquivo chamado "~/terraform/lab03/exe07/main.tf", com o seguinte conteúdo:

terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.15.0"
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


# Crie o arquivo "~/terraform/lab03/exe07/terraform.tfvars" com o seguinte conteúdo:
# 
# ext_port = [8000, 8001, 8002]


# Execute o comando abaixo para inicializar o diretório do terraform e verifique a saída do comando:
#
# $ terraform init
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
#   # docker_container.nginx[0] will be created
#   + resource "docker_container" "nginx" {
#       + attach           = false
#       + bridge           = (known after apply)
#       + command          = (known after apply)
#       + container_logs   = (known after apply)
#       + entrypoint       = (known after apply)
#       + env              = (known after apply)
#       + exit_code        = (known after apply)
#       + gateway          = (known after apply)
#       + hostname         = (known after apply)
#       + id               = (known after apply)
#       + image            = "nginx:latest"
#       + init             = (known after apply)
#       + ip_address       = (known after apply)
#       + ip_prefix_length = (known after apply)
#       + ipc_mode         = (known after apply)
#       + log_driver       = "json-file"
#       + logs             = false
#       + must_run         = true
#       + name             = "web-0"
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
#       + attach           = false
#       + bridge           = (known after apply)
#       + command          = (known after apply)
#       + container_logs   = (known after apply)
#       + entrypoint       = (known after apply)
#       + env              = (known after apply)
#       + exit_code        = (known after apply)
#       + gateway          = (known after apply)
#       + hostname         = (known after apply)
#       + id               = (known after apply)
#       + image            = "nginx:latest"
#       + init             = (known after apply)
#       + ip_address       = (known after apply)
#       + ip_prefix_length = (known after apply)
#       + ipc_mode         = (known after apply)
#       + log_driver       = "json-file"
#       + logs             = false
#       + must_run         = true
#       + name             = "web-1"
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
#       + attach           = false
#       + bridge           = (known after apply)
#       + command          = (known after apply)
#       + container_logs   = (known after apply)
#       + entrypoint       = (known after apply)
#       + env              = (known after apply)
#       + exit_code        = (known after apply)
#       + gateway          = (known after apply)
#       + hostname         = (known after apply)
#       + id               = (known after apply)
#       + image            = "nginx:latest"
#       + init             = (known after apply)
#       + ip_address       = (known after apply)
#       + ip_prefix_length = (known after apply)
#       + ipc_mode         = (known after apply)
#       + log_driver       = "json-file"
#       + logs             = false
#       + must_run         = true
#       + name             = "web-2"
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
#       + keep_locally = false
#       + latest       = (known after apply)
#       + name         = "nginx:latest"
#       + output       = (known after apply)
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
# docker_image.nginx: Creation complete after 6s [id=sha256:f8f4ffc8092c956ddd6a3a64814f36882798065799b8aedeebedf2855af3395bnginx:latest]
# docker_container.nginx[2]: Creating...
# docker_container.nginx[0]: Creating...
# docker_container.nginx[1]: Creating...
# docker_container.nginx[0]: Creation complete after 4s [id=38602f4ab3e46262ba99dad4bee848e63cba090612f2fe56422d554832af56eb]
# docker_container.nginx[2]: Creation complete after 5s [id=591bf0cf8ff52bac11f19347ceed96970b71304e03e03fe159978cf80b882501]
# docker_container.nginx[1]: Creation complete after 5s [id=96d90f817950165c2f5e4b25ed80d3a042abfc2d7278d9f2e05972c0c8b6bc65]
# 
# Apply complete! Resources: 4 added, 0 changed, 0 destroyed.


# Verifique se os containers foram criados, executando o comando abaixo:
# 
# $ docker ps 
# CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS          PORTS                  NAMES
# 8e66a4db0ab9   nginx:latest   "/docker-entrypoint.…"   17 minutes ago   Up 17 minutes   0.0.0.0:8002->80/tcp   web-2
# 0536e3e017d7   nginx:latest   "/docker-entrypoint.…"   17 minutes ago   Up 17 minutes   0.0.0.0:8001->80/tcp   web-1
# 809009b8999a   nginx:latest   "/docker-entrypoint.…"   17 minutes ago   Up 17 minutes   0.0.0.0:8000->80/tcp   web-0


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
# docker_container.nginx[1]:
# resource "docker_container" "nginx" {
#     command           = [
#         "nginx",
#         "-g",
#         "daemon off;",
#     ]
#     cpu_shares        = 0
#     dns               = []
#     dns_opts          = []
#     dns_search        = []
#     entrypoint        = [
#         "/docker-entrypoint.sh",
#     ]
#     gateway           = "172.17.0.1"
#     group_add         = []
#     hostname          = "0536e3e017d7"
#     id                = "0536e3e017d7799ad8d381351d222ee0b5df67bdc2365c0d199eccced1136cc5"
#     image             = "sha256:87a94228f133e2da99cb16d653cd1373c5b4e8689956386c1c12b60a20421a02"
#     init              = false
#     ip_address        = "172.17.0.2"
#     ip_prefix_length  = 16
#     ipc_mode          = "private"
#     links             = []
#     log_driver        = "json-file"
#     log_opts          = {}
#     max_retry_count   = 0
#     memory            = 0
#     memory_swap       = 0
#     name              = "web-1"
#     network_data      = [
#         {
#             gateway                   = "172.17.0.1"
#             global_ipv6_address       = ""
#             global_ipv6_prefix_length = 0
#             ip_address                = "172.17.0.2"
#             ip_prefix_length          = 16
#             ipv6_gateway              = ""
#             network_name              = "bridge"
#         },
#     ]
#     network_mode      = "default"
#     privileged        = false
#     publish_all_ports = false
#     read_only         = false
#     restart           = "no"
#     rm                = false
#     security_opts     = []
#     shm_size          = 64
#     stdin_open        = false
#     storage_opts      = {}
#     sysctls           = {}
#     tmpfs             = {}
#     tty               = false
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


# Para importar o recurso novamente para o terraform, precisamos obter as informações de identificação do objeto. Utilize os comandos abaixo para obter o ID do container docker e utilize o comando "terraform import" para importar o recurso:
# 
# $ docker inspect web-1
# [
#     {
#         "Id": "0536e3e017d7799ad8d381351d222ee0b5df67bdc2365c0d199eccced1136cc5",
#         "Created": "2021-10-12T03:04:27.811903695Z",
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
#             "Pid": 12941,
#             "ExitCode": 0,
#             "Error": "",
#             "StartedAt": "2021-10-12T03:04:31.40862224Z",
#             "FinishedAt": "0001-01-01T00:00:00Z"
#         },
# ...
#  
# De posse do ID acima, execute o comando "terraform import", conforme comando abaixo:
# 
# $ terraform import docker_container.nginx[1] 0536e3e017d7799ad8d381351d222ee0b5df67bdc2365c0d199eccced1136cc5
# docker_container.nginx[1]: Importing from ID "0536e3e017d7799ad8d381351d222ee0b5df67bdc2365c0d199eccced1136cc5"...
# docker_container.nginx[1]: Import prepared!
#   Prepared docker_container for import
# docker_container.nginx[1]: Refreshing state... [id=0536e3e017d7799ad8d381351d222ee0b5df67bdc2365c0d199eccced1136cc5]
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

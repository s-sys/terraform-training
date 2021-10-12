# Lab03
# Atividade 3.6.
# 
# Utilize o terraform para automatizar o deploy de 3 servidores web nginx com a porta local 80 sendo mapeada para as portas 8000, 8001 e 8002 respectivamente. Após isso, verifique os states criados e realize ações de taint em um dos servidores web.


# Crie um arquivo chamado "~/terraform/lab03/exe06/main.tf", com o seguinte conteúdo:

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


# Crie o arquivo "~/terraform/lab03/exe06/terraform.tfvars" com o seguinte conteúdo:
# 
# ext_port = [8000, 8001, 8002]


# Execute o comando abaixo para inicializar o diretório do terraform e verifique a saída do comando:
#
# $ terraform init
#
# Execute o "terraform graph" para analisar o relacionamento entre os objetos do state, conforme comando abaixo:
#
# $ terraform graph | dot -Tsvg > graph.svg
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
# CONTAINER ID   IMAGE          COMMAND                  CREATED              STATUS              PORTS                  NAMES
# 38602f4ab3e4   nginx:latest   "/docker-entrypoint.…"   About a minute ago   Up About a minute   0.0.0.0:8000->80/tcp   web-0
# 96d90f817950   nginx:latest   "/docker-entrypoint.…"   About a minute ago   Up About a minute   0.0.0.0:8001->80/tcp   web-1
# 591bf0cf8ff5   nginx:latest   "/docker-entrypoint.…"   About a minute ago   Up About a minute   0.0.0.0:8002->80/tcp   web-2


# Verifique o retorno de comunicação com cada um dos servidores para validar que o nginx está operacional, conforme comandos abaixo:
# 
# $ curl 192.168.1.11:8000
# <!DOCTYPE html>
# <html>
# <head>
# <title>Welcome to nginx!</title>
# <style>
# html { color-scheme: light dark; }
# body { width: 35em; margin: 0 auto;
# font-family: Tahoma, Verdana, Arial, sans-serif; }
# </style>
# </head>
# <body>
# <h1>Welcome to nginx!</h1>
# <p>If you see this page, the nginx web server is successfully installed and
# working. Further configuration is required.</p>
# 
# <p>For online documentation and support please refer to
# <a href="http://nginx.org/">nginx.org</a>.<br/>
# Commercial support is available at
# <a href="http://nginx.com/">nginx.com</a>.</p>
# 
# <p><em>Thank you for using nginx.</em></p>
# </body>
# </html>
# 
# $ curl 192.168.1.11:8001
# <!DOCTYPE html>
# <html>
# <head>
# <title>Welcome to nginx!</title>
# <style>
# html { color-scheme: light dark; }
# body { width: 35em; margin: 0 auto;
# font-family: Tahoma, Verdana, Arial, sans-serif; }
# </style>
# </head>
# <body>
# <h1>Welcome to nginx!</h1>
# <p>If you see this page, the nginx web server is successfully installed and
# working. Further configuration is required.</p>
# 
# <p>For online documentation and support please refer to
# <a href="http://nginx.org/">nginx.org</a>.<br/>
# Commercial support is available at
# <a href="http://nginx.com/">nginx.com</a>.</p>
# 
# <p><em>Thank you for using nginx.</em></p>
# </body>
# </html>
# 
# $ curl 192.168.1.11:8002
# <!DOCTYPE html>
# <html>
# <head>
# <title>Welcome to nginx!</title>
# <style>
# html { color-scheme: light dark; }
# body { width: 35em; margin: 0 auto;
# font-family: Tahoma, Verdana, Arial, sans-serif; }
# </style>
# </head>
# <body>
# <h1>Welcome to nginx!</h1>
# <p>If you see this page, the nginx web server is successfully installed and
# working. Further configuration is required.</p>
# 
# <p>For online documentation and support please refer to
# <a href="http://nginx.org/">nginx.org</a>.<br/>
# Commercial support is available at
# <a href="http://nginx.com/">nginx.com</a>.</p>
# 
# <p><em>Thank you for using nginx.</em></p>
# </body>
# </html>


# Verifique as informações sobre os states utilizando o comando "terraform show", conforme abaixo:
# 
# $ terraform show
# # docker_container.nginx[0]:
# resource "docker_container" "nginx" {
#     attach            = false
#     command           = [
#         "nginx",
#         "-g",
#         "daemon off;",
#     ]
#     cpu_shares        = 0
#     entrypoint        = [
#         "/docker-entrypoint.sh",
#     ]
#     env               = []
#     gateway           = "172.17.0.1"
#     hostname          = "3c819038175e"
#     id                = "3c819038175ee6a4cbd6f69509dc49755411a73225ff3d6b67d725d983c6ed91"
#     image             = "sha256:f8f4ffc8092c956ddd6a3a64814f36882798065799b8aedeebedf2855af3395b"
#     init              = false
#     ip_address        = "172.17.0.4"
#     ip_prefix_length  = 16
#     ipc_mode          = "private"
#     log_driver        = "json-file"
#     logs              = false
#     max_retry_count   = 0
#     memory            = 0
#     memory_swap       = 0
#     must_run          = true
#     name              = "web-0"
#     network_data      = [
#         {
#             gateway                   = "172.17.0.1"
#             global_ipv6_address       = ""
#             global_ipv6_prefix_length = 0
#             ip_address                = "172.17.0.4"
#             ip_prefix_length          = 16
#             ipv6_gateway              = ""
#             network_name              = "bridge"
#         },
#     ]
#     network_mode      = "default"
#     privileged        = false
#     publish_all_ports = false
#     read_only         = false
#     remove_volumes    = true
#     restart           = "no"
#     rm                = false
#     security_opts     = []
#     shm_size          = 64
#     start             = true
#     stdin_open        = false
#     tty               = false
# 
#     ports {
#         external = 8000
#         internal = 80
#         ip       = "0.0.0.0"
#         protocol = "tcp"
#     }
# }
# 
# # docker_container.nginx[1]:
# resource "docker_container" "nginx" {
#     attach            = false
#     command           = [
#         "nginx",
#         "-g",
#         "daemon off;",
#     ]
#     cpu_shares        = 0
#     entrypoint        = [
#         "/docker-entrypoint.sh",
#     ]
#     env               = []
#     gateway           = "172.17.0.1"
#     hostname          = "adb5e9459ee8"
#     id                = "adb5e9459ee852a32a42b98b7858f0000423970f16cb2f2fb185ddb89bf4c7eb"
#     image             = "sha256:f8f4ffc8092c956ddd6a3a64814f36882798065799b8aedeebedf2855af3395b"
#     init              = false
#     ip_address        = "172.17.0.2"
#     ip_prefix_length  = 16
#     ipc_mode          = "private"
#     log_driver        = "json-file"
#     logs              = false
#     max_retry_count   = 0
#     memory            = 0
#     memory_swap       = 0
#     must_run          = true
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
#     remove_volumes    = true
#     restart           = "no"
#     rm                = false
#     security_opts     = []
#     shm_size          = 64
#     start             = true
#     stdin_open        = false
#     tty               = false
# 
#     ports {
#         external = 8001
#         internal = 80
#         ip       = "0.0.0.0"
#         protocol = "tcp"
#     }
# }
# 
# # docker_container.nginx[2]:
# resource "docker_container" "nginx" {
#     attach            = false
#     command           = [
#         "nginx",
#         "-g",
#         "daemon off;",
#     ]
#     cpu_shares        = 0
#     entrypoint        = [
#         "/docker-entrypoint.sh",
#     ]
#     env               = []
#     gateway           = "172.17.0.1"
#     hostname          = "f8076c803df0"
#     id                = "f8076c803df09fd98fa4e5cc30e2bc7859fa3d48ad9351f4da3835575a619e54"
#     image             = "sha256:f8f4ffc8092c956ddd6a3a64814f36882798065799b8aedeebedf2855af3395b"
#     init              = false
#     ip_address        = "172.17.0.3"
#     ip_prefix_length  = 16
#     ipc_mode          = "private"
#     log_driver        = "json-file"
#     logs              = false
#     max_retry_count   = 0
#     memory            = 0
#     memory_swap       = 0
#     must_run          = true
#     name              = "web-2"
#     network_data      = [
#         {
#             gateway                   = "172.17.0.1"
#             global_ipv6_address       = ""
#             global_ipv6_prefix_length = 0
#             ip_address                = "172.17.0.3"
#             ip_prefix_length          = 16
#             ipv6_gateway              = ""
#             network_name              = "bridge"
#         },
#     ]
#     network_mode      = "default"
#     privileged        = false
#     publish_all_ports = false
#     read_only         = false
#     remove_volumes    = true
#     restart           = "no"
#     rm                = false
#     security_opts     = []
#     shm_size          = 64
#     start             = true
#     stdin_open        = false
#     tty               = false
# 
#     ports {
#         external = 8002
#         internal = 80
#         ip       = "0.0.0.0"
#         protocol = "tcp"
#     }
# }
# 
# # docker_image.nginx:
# resource "docker_image" "nginx" {
#     id           = "sha256:f8f4ffc8092c956ddd6a3a64814f36882798065799b8aedeebedf2855af3395bnginx:latest"
#     keep_locally = false
#     latest       = "sha256:f8f4ffc8092c956ddd6a3a64814f36882798065799b8aedeebedf2855af3395b"
#     name         = "nginx:latest"
#     repo_digest  = "nginx@sha256:06e4235e95299b1d6d595c5ef4c41a9b12641f6683136c18394b858967cd1506"
# }


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
#     attach            = false
#     command           = [
#         "nginx",
#         "-g",
#         "daemon off;",
#     ]
#     cpu_shares        = 0
#     entrypoint        = [
#         "/docker-entrypoint.sh",
#     ]
#     env               = []
#     gateway           = "172.17.0.1"
#     hostname          = "96d90f817950"
#     id                = "96d90f817950165c2f5e4b25ed80d3a042abfc2d7278d9f2e05972c0c8b6bc65"
#     image             = "sha256:f8f4ffc8092c956ddd6a3a64814f36882798065799b8aedeebedf2855af3395b"
#     init              = false
#     ip_address        = "172.17.0.3"
#     ip_prefix_length  = 16
#     ipc_mode          = "private"
#     log_driver        = "json-file"
#     logs              = false
#     max_retry_count   = 0
#     memory            = 0
#     memory_swap       = 0
#     must_run          = true
#     name              = "web-1"
#     network_data      = [
#         {
#             gateway                   = "172.17.0.1"
#             global_ipv6_address       = ""
#             global_ipv6_prefix_length = 0
#             ip_address                = "172.17.0.3"
#             ip_prefix_length          = 16
#             ipv6_gateway              = ""
#             network_name              = "bridge"
#         },
#     ]
#     network_mode      = "default"
#     privileged        = false
#     publish_all_ports = false
#     read_only         = false
#     remove_volumes    = true
#     restart           = "no"
#     rm                = false
#     security_opts     = []
#     shm_size          = 64
#     start             = true
#     stdin_open        = false
#     tty               = false
# 
#     ports {
#         external = 8001
#         internal = 80
#         ip       = "0.0.0.0"
#         protocol = "tcp"
#     }
# }


# Marque o state como tainted (com defeito), para que seja recriado pelo terraform, utilizando o comando abaixo:
# 
# $ terraform taint docker_container.nginx[1]
# Resource instance docker_container.nginx[1] has been marked as tainted.


# Em seguida execute o comando "terraform apply" e verifique as ações que serão realizadas, conforme a seguir:
# 
# $ terraform apply
# ...
# Plan: 3 to add, 0 to change, 3 to destroy.
# ...


# Agora remova um state do terraform, conforme a seguir, para tornar o recurso não mais gerenciado pelo terraform:
# 
# $ terraform state rm docker_container.nginx[2]
# Removed docker_container.nginx[2]
# Successfully removed 1 resource instance(s).


# Execute o comando "terraform destroy" para destruir o ambiente, conforme abaixo:
# 
# $ terraform destroy
# ...
# Do you really want to destroy all resources?
#   Terraform will destroy all your managed infrastructure, as shown above.
#   There is no undo. Only 'yes' will be accepted to confirm.
# 
#   Enter a value: yes
# 
# docker_container.nginx[0]: Destroying... [id=e181973f690c2dfb8d50153b4e3f194bc3e20c2bd6e070631d61a4ea6e9b9ce0]
# docker_container.nginx[1]: Destroying... [id=68590210554be452ae873b387ecf7f5e96420791e7c449aa07fa3f6bf3f67cac]
# docker_container.nginx[1]: Destruction complete after 1s
# docker_container.nginx[0]: Destruction complete after 2s
# docker_image.nginx: Destroying... [id=sha256:87a94228f133e2da99cb16d653cd1373c5b4e8689956386c1c12b60a20421a02nginx:latest]
# ╷
# │ Error: Unable to remove Docker image: Error response from daemon: conflict: unable to remove repository reference "nginx:latest" (must force) - container d2cfb0504727 is using its referenced image 87a94228f133
# │ 
# │ 
# ╵


# Observe que foi apresentado um erro na remoção da imagem. Este erro foi ocasionado por existir um container (d2cfb0504727) que está fazendo uso da imagem, e por isso, a imagem docker não pode ser removida. Este container não é mais gerenciado pelo terraform. Para corrigir o problema execute a sequência de comandos abaixo:
# 
# $ docker stop web-2
# 
# $ docker rm web-2
# 
# E repita o processo executando o comando "terraform destroy" para remover os itens restantes.

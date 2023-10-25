# Lab03
# Atividade 3.6.
# 
# Utilize o terraform para automatizar o deploy de 3 servidores web nginx com a
# porta local 80 sendo mapeada para as portas 8000, 8001 e 8002 respectivamente.
# Após isso, verifique os states criados e realize ações de taint em um dos
# servidores web.


# Crie um arquivo chamado "~/terraform/lab03/exe06/main.tf", com o seguinte conteúdo:


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


# Crie o arquivo "~/terraform/lab03/exe06/terraform.tfvars" com o seguinte conteúdo:
# 
# ext_port = [8000, 8001, 8002]


# Execute o comando abaixo para inicializar o diretório do terraform e verifique
# a saída do comando:
#
# $ terraform init
#
# Execute o "terraform graph" para analisar o relacionamento entre os objetos do state,
# conforme comando abaixo:
#
# $ terraform graph | dot -Tsvg > graph.svg
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
# docker_container.nginx[2]: Creating...
# docker_container.nginx[0]: Creating...
# docker_container.nginx[1]: Creating...
# docker_container.nginx[0]: Creation complete after 4s [id=11fd5ee0ebffb29e066d2f6bb04430152ffcae208abec78e1396c6a03a66d1e8]
# docker_container.nginx[2]: Creation complete after 4s [id=6257ba7d16865b9438f81450e32b59f3f4bf9c6eff299d551dd92726a500a36c]
# docker_container.nginx[1]: Creation complete after 4s [id=1147226c3981297fb3f9cb20e0249d1784a3b4d478ed015d1be3715d35dbc402]
# 
# Apply complete! Resources: 4 added, 0 changed, 0 destroyed.


# Verifique se os containers foram criados, executando o comando abaixo:
# 
# $ docker ps
# CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS          PORTS                  NAMES
# 11fd5ee0ebff   nginx:latest   "/docker-entrypoint.…"   35 seconds ago   Up 30 seconds   0.0.0.0:8000->80/tcp   web-0
# 6257ba7d1686   nginx:latest   "/docker-entrypoint.…"   35 seconds ago   Up 30 seconds   0.0.0.0:8002->80/tcp   web-2
# 1147226c3981   nginx:latest   "/docker-entrypoint.…"   35 seconds ago   Up 30 seconds   0.0.0.0:8001->80/tcp   web-1


# Verifique o retorno de comunicação com cada um dos servidores para validar que o
# nginx está operacional, conforme comandos abaixo:
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


# Verifique as informações sobre os states utilizando o comando "terraform show",
# conforme abaixo:
# 
# $ terraform show
# # docker_container.nginx[0]:
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
#     hostname                                    = "11fd5ee0ebff"
#     id                                          = "11fd5ee0ebffb29e066d2f6bb04430152ffcae208abec78e1396c6a03a66d1e8"
#     image                                       = "sha256:593aee2afb642798b83a85306d2625fd7f089c0a1242c7e75a237846d80aa2a0"
#     init                                        = false
#     ipc_mode                                    = "private"
#     log_driver                                  = "json-file"
#     logs                                        = false
#     max_retry_count                             = 0
#     memory                                      = 0
#     memory_swap                                 = 0
#     must_run                                    = true
#     name                                        = "web-0"
#     network_data                                = [
#         {
#             gateway                   = "172.17.0.1"
#             global_ipv6_address       = ""
#             global_ipv6_prefix_length = 0
#             ip_address                = "172.17.0.2"
#             ip_prefix_length          = 16
#             ipv6_gateway              = ""
#             mac_address               = "02:42:ac:11:00:02"
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
#         external = 8000
#         internal = 80
#         ip       = "0.0.0.0"
#         protocol = "tcp"
#     }
# }
# 
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
#     hostname                                    = "1147226c3981"
#     id                                          = "1147226c3981297fb3f9cb20e0249d1784a3b4d478ed015d1be3715d35dbc402"
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
# 
# # docker_container.nginx[2]:
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
#     hostname                                    = "6257ba7d1686"
#     id                                          = "6257ba7d16865b9438f81450e32b59f3f4bf9c6eff299d551dd92726a500a36c"
#     image                                       = "sha256:593aee2afb642798b83a85306d2625fd7f089c0a1242c7e75a237846d80aa2a0"
#     init                                        = false
#     ipc_mode                                    = "private"
#     log_driver                                  = "json-file"
#     logs                                        = false
#     max_retry_count                             = 0
#     memory                                      = 0
#     memory_swap                                 = 0
#     must_run                                    = true
#     name                                        = "web-2"
#     network_data                                = [
#         {
#             gateway                   = "172.17.0.1"
#             global_ipv6_address       = ""
#             global_ipv6_prefix_length = 0
#             ip_address                = "172.17.0.3"
#             ip_prefix_length          = 16
#             ipv6_gateway              = ""
#             mac_address               = "02:42:ac:11:00:03"
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
#         external = 8002
#         internal = 80
#         ip       = "0.0.0.0"
#         protocol = "tcp"
#     }
# }
# 
# # docker_image.nginx:
# resource "docker_image" "nginx" {
#     id           = "sha256:593aee2afb642798b83a85306d2625fd7f089c0a1242c7e75a237846d80aa2a0nginx:latest"
#     image_id     = "sha256:593aee2afb642798b83a85306d2625fd7f089c0a1242c7e75a237846d80aa2a0"
#     keep_locally = false
#     name         = "nginx:latest"
#     repo_digest  = "nginx@sha256:add4792d930c25dd2abf2ef9ea79de578097a1c175a16ab25814332fe33622de"
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
#     hostname                                    = "1147226c3981"
#     id                                          = "1147226c3981297fb3f9cb20e0249d1784a3b4d478ed015d1be3715d35dbc402"
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


# Marque o state como tainted (com defeito), para que seja recriado pelo terraform,
# utilizando o comando abaixo:
# 
# $ terraform taint docker_container.nginx[1]
# Resource instance docker_container.nginx[1] has been marked as tainted.


# Em seguida execute o comando "terraform apply" e verifique as ações que serão
# realizadas, conforme a seguir:
# 
# $ terraform apply
# ...
# Plan: 3 to add, 0 to change, 3 to destroy.
# ...


# Agora remova um state do terraform, conforme a seguir, para tornar o recurso não
# mais gerenciado pelo terraform:
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
# docker_container.nginx[1]: Destroying... [id=104c16964d4caa7ff3b41cf0eca034ab46c32673396e550013c26793750e08fc]
# docker_container.nginx[0]: Destroying... [id=8bc2a400c4401797a8b9170cf4d49e8e53e99d81973ffa354ac8da95b03056ec]
# docker_container.nginx[0]: Destruction complete after 0s
# docker_container.nginx[1]: Destruction complete after 0s
# docker_image.nginx: Destroying... [id=sha256:593aee2afb642798b83a85306d2625fd7f089c0a1242c7e75a237846d80aa2a0nginx:latest]
# │
# │ Error: Unable to remove Docker image: Error response from daemon: conflict: unable to remove repository reference "nginx:latest" (must force) - container 0ac838b08cc2 is using its referenced image 593aee2afb64
# │
# │
# │


# Observe que foi apresentado um erro na remoção da imagem. Este erro foi ocasionado
# por existir um container (0ac838b08cc2) que está fazendo uso da imagem, e por isso,
# a imagem docker não pode ser removida. Este container não é mais gerenciado pelo
# terraform. Para corrigir o problema execute a sequência de comandos abaixo:
# 
# $ docker stop web-2
#
# $ docker rm web-2
# 
# E repita o processo executando o comando "terraform destroy" para remover os
# itens restantes.
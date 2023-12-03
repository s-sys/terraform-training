# Lab05
# Atividade 5.3.
# 
# Crie uma automação em terraform para a criação de containers em docker com base 
# nas definições de um mapa de variáveis. A automação deve identificar a quantidade
# de elementos e os parâmetros e definir as propriedades de acordo com o especificado.
# Neste exemplo, ao invés de utilizar count, deve-se utilizar a estrutura for_each. 


# Crie um arquivo chamado "~/terraform/lab05/exe03/main.tf", com o seguinte conteúdo:


terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.0"
    }
  }
}

provider "docker" {
  host = "tcp://192.168.1.11:2375"
}

resource "docker_image" "nginx" {
  name         = "nginx:stable"
  keep_locally = false
}

resource "docker_container" "nginx" {
  for_each = {for o in var.instances: o.name => o}
  image    = docker_image.nginx.image_id
  name     = each.key
  ports {
    internal = each.value.internal_port
    external = each.value.external_port
  }
}


# Crie um arquivo chamado "~/terraform/lab05/exe03/variables.tf", com o seguinte conteúdo:
# 
# variable "instances" {
#   type = list(object({
#     name          = string
#     internal_port = number
#     external_port = number
#   }))
# }


# Crie um arquivo chamado "~/terraform/lab05/exe03/terraform.tfvars", com o seguinte conteúdo:
# 
# instances = [
#   {
#     name          = "container-01"
#     internal_port = 80
#     external_port = 8080
#   },
#   {
#     name          = "container-02"
#     internal_port = 80
#     external_port = 8081
#   },
#   {
#     name          = "container-03"
#     internal_port = 80
#     external_port = 8082
#   },
#   {
#     name          = "container-04"
#     internal_port = 80
#     external_port = 8083
#   }
# ]


# Crie um arquivo chamado "~/terraform/lab05/exe03/terraform-3-nodes.tfvars", com o seguinte conteúdo:
# 
# instances = [
#   {
#     name          = "container-01"
#     internal_port = 80
#     external_port = 8080
#   },
#   {
#     name          = "container-03"
#     internal_port = 80
#     external_port = 8082
#   },
#   {
#     name          = "container-04"
#     internal_port = 80
#     external_port = 8083
#   }
# ]


# Execute o comando abaixo para inicializar o diretório do terraform:
# 
# $ terraform init
# 
# Initializing the backend...
# 
# Initializing provider plugins...
# - Reusing previous version of kreuzwerker/docker from the dependency lock file
# - Using previously-installed kreuzwerker/docker v3.0.2
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
# $ terraform apply
# 
# Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
#   + create
# 
# Terraform will perform the following actions:
# 
#   # docker_container.nginx["container-01"] will be created
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
#       + image                                       = (known after apply)
#       + init                                        = (known after apply)
#       + ipc_mode                                    = (known after apply)
#       + log_driver                                  = (known after apply)
#       + logs                                        = false
#       + must_run                                    = true
#       + name                                        = "container-01"
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
#           + external = 8080
#           + internal = 80
#           + ip       = "0.0.0.0"
#           + protocol = "tcp"
#         }
#     }
# 
#   # docker_container.nginx["container-02"] will be created
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
#       + image                                       = (known after apply)
#       + init                                        = (known after apply)
#       + ipc_mode                                    = (known after apply)
#       + log_driver                                  = (known after apply)
#       + logs                                        = false
#       + must_run                                    = true
#       + name                                        = "container-02"
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
#           + external = 8081
#           + internal = 80
#           + ip       = "0.0.0.0"
#           + protocol = "tcp"
#         }
#     }
# 
#   # docker_container.nginx["container-03"] will be created
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
#       + image                                       = (known after apply)
#       + init                                        = (known after apply)
#       + ipc_mode                                    = (known after apply)
#       + log_driver                                  = (known after apply)
#       + logs                                        = false
#       + must_run                                    = true
#       + name                                        = "container-03"
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
#           + external = 8082
#           + internal = 80
#           + ip       = "0.0.0.0"
#           + protocol = "tcp"
#         }
#     }
# 
#   # docker_container.nginx["container-04"] will be created
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
#       + image                                       = (known after apply)
#       + init                                        = (known after apply)
#       + ipc_mode                                    = (known after apply)
#       + log_driver                                  = (known after apply)
#       + logs                                        = false
#       + must_run                                    = true
#       + name                                        = "container-04"
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
#           + external = 8083
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
#       + name         = "nginx:stable"
#       + repo_digest  = (known after apply)
#     }
# 
# Plan: 5 to add, 0 to change, 0 to destroy.
# 
# Do you want to perform these actions?
#   Terraform will perform the actions described above.
#   Only 'yes' will be accepted to approve.
# 
#   Enter a value: yes
# 
# docker_image.nginx: Creating...
# docker_image.nginx: Creation complete after 5s [id=sha256:967ca3be8ed4cdc3b937a7b5a5a899166389e2cf3704d9f588f4db903488d12fnginx:stable]
# docker_container.nginx["container-02"]: Creating...
# docker_container.nginx["container-03"]: Creating...
# docker_container.nginx["container-04"]: Creating...
# docker_container.nginx["container-01"]: Creating...
# docker_container.nginx["container-02"]: Creation complete after 4s [id=0f7f8796d24d78d1406de02e98f74dcf50e9539acdbc09ef4dc85e713f299d77]
# docker_container.nginx["container-03"]: Creation complete after 4s [id=82278825eadb7b0bdeb3919b6f0ab31701d42348fd26b6a6003de8556abf5186]
# docker_container.nginx["container-01"]: Creation complete after 4s [id=0c801be09bad6d7ba47ded4be95520a4d969f8bedaf90159d495fcef3b809b13]
# docker_container.nginx["container-04"]: Creation complete after 4s [id=75c42bbb9156ff2c02ef70bf88ca4d0918b2dbbf2da4aa6e97e1678b379aaa7e]
# 
# Apply complete! Resources: 5 added, 0 changed, 0 destroyed.


# Verifique o status dos containers, conforme o comando abaixo:
# 
# $ docker ps
# CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS          PORTS                  NAMES
# 0f7f8796d24d   967ca3be8ed4   "/docker-entrypoint.…"   53 seconds ago   Up 49 seconds   0.0.0.0:8081->80/tcp   container-02
# 75c42bbb9156   967ca3be8ed4   "/docker-entrypoint.…"   53 seconds ago   Up 49 seconds   0.0.0.0:8083->80/tcp   container-04
# 82278825eadb   967ca3be8ed4   "/docker-entrypoint.…"   53 seconds ago   Up 49 seconds   0.0.0.0:8082->80/tcp   container-03
# 0c801be09bad   967ca3be8ed4   "/docker-entrypoint.…"   53 seconds ago   Up 49 seconds   0.0.0.0:8080->80/tcp   container-01


# Na sequência execute novamente o comando de "terraform apply", mas utilizando outro arquivo de variáveis:
#
# $ terraform apply -var-file terraform-3-nodes.tfvars
# 
# docker_image.nginx: Refreshing state... [id=sha256:967ca3be8ed4cdc3b937a7b5a5a899166389e2cf3704d9f588f4db903488d12fnginx:stable]
# docker_container.nginx["container-02"]: Refreshing state... [id=0f7f8796d24d78d1406de02e98f74dcf50e9539acdbc09ef4dc85e713f299d77]
# docker_container.nginx["container-01"]: Refreshing state... [id=0c801be09bad6d7ba47ded4be95520a4d969f8bedaf90159d495fcef3b809b13]
# docker_container.nginx["container-03"]: Refreshing state... [id=82278825eadb7b0bdeb3919b6f0ab31701d42348fd26b6a6003de8556abf5186]
# docker_container.nginx["container-04"]: Refreshing state... [id=75c42bbb9156ff2c02ef70bf88ca4d0918b2dbbf2da4aa6e97e1678b379aaa7e]
# 
# Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
#   - destroy
# 
# Terraform will perform the following actions:
# 
#   # docker_container.nginx["container-02"] will be destroyed
#   # (because key ["container-02"] is not in for_each map)
#   - resource "docker_container" "nginx" {
#       - attach                                      = false -> null
#       - command                                     = [
#           - "nginx",
#           - "-g",
#           - "daemon off;",
#         ] -> null
#       - container_read_refresh_timeout_milliseconds = 15000 -> null
#       - cpu_shares                                  = 0 -> null
#       - dns                                         = [] -> null
#       - dns_opts                                    = [] -> null
#       - dns_search                                  = [] -> null
#       - entrypoint                                  = [
#           - "/docker-entrypoint.sh",
#         ] -> null
#       - env                                         = [] -> null
#       - group_add                                   = [] -> null
#       - hostname                                    = "0f7f8796d24d" -> null
#       - id                                          = "0f7f8796d24d78d1406de02e98f74dcf50e9539acdbc09ef4dc85e713f299d77" -> null
#       - image                                       = "sha256:967ca3be8ed4cdc3b937a7b5a5a899166389e2cf3704d9f588f4db903488d12f" -> null
#       - init                                        = false -> null
#       - ipc_mode                                    = "private" -> null
#       - log_driver                                  = "json-file" -> null
#       - log_opts                                    = {} -> null
#       - logs                                        = false -> null
#       - max_retry_count                             = 0 -> null
#       - memory                                      = 0 -> null
#       - memory_swap                                 = 0 -> null
#       - must_run                                    = true -> null
#       - name                                        = "container-02" -> null
#       - network_data                                = [
#           - {
#               - gateway                   = "172.17.0.1"
#               - global_ipv6_address       = ""
#               - global_ipv6_prefix_length = 0
#               - ip_address                = "172.17.0.2"
#               - ip_prefix_length          = 16
#               - ipv6_gateway              = ""
#               - mac_address               = "02:42:ac:11:00:02"
#               - network_name              = "bridge"
#             },
#         ] -> null
#       - network_mode                                = "default" -> null
#       - privileged                                  = false -> null
#       - publish_all_ports                           = false -> null
#       - read_only                                   = false -> null
#       - remove_volumes                              = true -> null
#       - restart                                     = "no" -> null
#       - rm                                          = false -> null
#       - runtime                                     = "runc" -> null
#       - security_opts                               = [] -> null
#       - shm_size                                    = 64 -> null
#       - start                                       = true -> null
#       - stdin_open                                  = false -> null
#       - stop_signal                                 = "SIGQUIT" -> null
#       - stop_timeout                                = 0 -> null
#       - storage_opts                                = {} -> null
#       - sysctls                                     = {} -> null
#       - tmpfs                                       = {} -> null
#       - tty                                         = false -> null
#       - wait                                        = false -> null
#       - wait_timeout                                = 60 -> null
# 
#       - ports {
#           - external = 8081 -> null
#           - internal = 80 -> null
#           - ip       = "0.0.0.0" -> null
#           - protocol = "tcp" -> null
#         }
#     }
# 
# Plan: 0 to add, 0 to change, 1 to destroy.
# 
# Do you want to perform these actions?
#   Terraform will perform the actions described above.
#   Only 'yes' will be accepted to approve.
# 
#   Enter a value: yes
# 
# docker_container.nginx["container-02"]: Destroying... [id=0f7f8796d24d78d1406de02e98f74dcf50e9539acdbc09ef4dc85e713f299d77]
# docker_container.nginx["container-02"]: Destruction complete after 0s
# 
# Apply complete! Resources: 0 added, 0 changed, 1 destroyed.


# Observem que apenas o containter "docker_container.nginx["container-02"]" foi removido.
# 


# Execute o comando "terraform destroy" para destruir o ambiente, conforme abaixo:
# 
# $ terraform destroy -var-file terraform-3-nodes.tfvars
# 
# docker_image.nginx: Refreshing state... [id=sha256:967ca3be8ed4cdc3b937a7b5a5a899166389e2cf3704d9f588f4db903488d12fnginx:stable]
# docker_container.nginx["container-04"]: Refreshing state... [id=75c42bbb9156ff2c02ef70bf88ca4d0918b2dbbf2da4aa6e97e1678b379aaa7e]
# docker_container.nginx["container-03"]: Refreshing state... [id=82278825eadb7b0bdeb3919b6f0ab31701d42348fd26b6a6003de8556abf5186]
# docker_container.nginx["container-01"]: Refreshing state... [id=0c801be09bad6d7ba47ded4be95520a4d969f8bedaf90159d495fcef3b809b13]
# 
# Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
#   - destroy
# 
# Terraform will perform the following actions:
# 
#   # docker_container.nginx["container-01"] will be destroyed
#   - resource "docker_container" "nginx" {
#       - attach                                      = false -> null
#       - command                                     = [
#           - "nginx",
#           - "-g",
#           - "daemon off;",
#         ] -> null
#       - container_read_refresh_timeout_milliseconds = 15000 -> null
#       - cpu_shares                                  = 0 -> null
#       - dns                                         = [] -> null
#       - dns_opts                                    = [] -> null
#       - dns_search                                  = [] -> null
#       - entrypoint                                  = [
#           - "/docker-entrypoint.sh",
#         ] -> null
#       - env                                         = [] -> null
#       - group_add                                   = [] -> null
#       - hostname                                    = "0c801be09bad" -> null
#       - id                                          = "0c801be09bad6d7ba47ded4be95520a4d969f8bedaf90159d495fcef3b809b13" -> null
#       - image                                       = "sha256:967ca3be8ed4cdc3b937a7b5a5a899166389e2cf3704d9f588f4db903488d12f" -> null
#       - init                                        = false -> null
#       - ipc_mode                                    = "private" -> null
#       - log_driver                                  = "json-file" -> null
#       - log_opts                                    = {} -> null
#       - logs                                        = false -> null
#       - max_retry_count                             = 0 -> null
#       - memory                                      = 0 -> null
#       - memory_swap                                 = 0 -> null
#       - must_run                                    = true -> null
#       - name                                        = "container-01" -> null
#       - network_data                                = [
#           - {
#               - gateway                   = "172.17.0.1"
#               - global_ipv6_address       = ""
#               - global_ipv6_prefix_length = 0
#               - ip_address                = "172.17.0.5"
#               - ip_prefix_length          = 16
#               - ipv6_gateway              = ""
#               - mac_address               = "02:42:ac:11:00:05"
#               - network_name              = "bridge"
#             },
#         ] -> null
#       - network_mode                                = "default" -> null
#       - privileged                                  = false -> null
#       - publish_all_ports                           = false -> null
#       - read_only                                   = false -> null
#       - remove_volumes                              = true -> null
#       - restart                                     = "no" -> null
#       - rm                                          = false -> null
#       - runtime                                     = "runc" -> null
#       - security_opts                               = [] -> null
#       - shm_size                                    = 64 -> null
#       - start                                       = true -> null
#       - stdin_open                                  = false -> null
#       - stop_signal                                 = "SIGQUIT" -> null
#       - stop_timeout                                = 0 -> null
#       - storage_opts                                = {} -> null
#       - sysctls                                     = {} -> null
#       - tmpfs                                       = {} -> null
#       - tty                                         = false -> null
#       - wait                                        = false -> null
#       - wait_timeout                                = 60 -> null
# 
#       - ports {
#           - external = 8080 -> null
#           - internal = 80 -> null
#           - ip       = "0.0.0.0" -> null
#           - protocol = "tcp" -> null
#         }
#     }
# 
#   # docker_container.nginx["container-03"] will be destroyed
#   - resource "docker_container" "nginx" {
#       - attach                                      = false -> null
#       - command                                     = [
#           - "nginx",
#           - "-g",
#           - "daemon off;",
#         ] -> null
#       - container_read_refresh_timeout_milliseconds = 15000 -> null
#       - cpu_shares                                  = 0 -> null
#       - dns                                         = [] -> null
#       - dns_opts                                    = [] -> null
#       - dns_search                                  = [] -> null
#       - entrypoint                                  = [
#           - "/docker-entrypoint.sh",
#         ] -> null
#       - env                                         = [] -> null
#       - group_add                                   = [] -> null
#       - hostname                                    = "82278825eadb" -> null
#       - id                                          = "82278825eadb7b0bdeb3919b6f0ab31701d42348fd26b6a6003de8556abf5186" -> null
#       - image                                       = "sha256:967ca3be8ed4cdc3b937a7b5a5a899166389e2cf3704d9f588f4db903488d12f" -> null
#       - init                                        = false -> null
#       - ipc_mode                                    = "private" -> null
#       - log_driver                                  = "json-file" -> null
#       - log_opts                                    = {} -> null
#       - logs                                        = false -> null
#       - max_retry_count                             = 0 -> null
#       - memory                                      = 0 -> null
#       - memory_swap                                 = 0 -> null
#       - must_run                                    = true -> null
#       - name                                        = "container-03" -> null
#       - network_data                                = [
#           - {
#               - gateway                   = "172.17.0.1"
#               - global_ipv6_address       = ""
#               - global_ipv6_prefix_length = 0
#               - ip_address                = "172.17.0.3"
#               - ip_prefix_length          = 16
#               - ipv6_gateway              = ""
#               - mac_address               = "02:42:ac:11:00:03"
#               - network_name              = "bridge"
#             },
#         ] -> null
#       - network_mode                                = "default" -> null
#       - privileged                                  = false -> null
#       - publish_all_ports                           = false -> null
#       - read_only                                   = false -> null
#       - remove_volumes                              = true -> null
#       - restart                                     = "no" -> null
#       - rm                                          = false -> null
#       - runtime                                     = "runc" -> null
#       - security_opts                               = [] -> null
#       - shm_size                                    = 64 -> null
#       - start                                       = true -> null
#       - stdin_open                                  = false -> null
#       - stop_signal                                 = "SIGQUIT" -> null
#       - stop_timeout                                = 0 -> null
#       - storage_opts                                = {} -> null
#       - sysctls                                     = {} -> null
#       - tmpfs                                       = {} -> null
#       - tty                                         = false -> null
#       - wait                                        = false -> null
#       - wait_timeout                                = 60 -> null
# 
#       - ports {
#           - external = 8082 -> null
#           - internal = 80 -> null
#           - ip       = "0.0.0.0" -> null
#           - protocol = "tcp" -> null
#         }
#     }
# 
#   # docker_container.nginx["container-04"] will be destroyed
#   - resource "docker_container" "nginx" {
#       - attach                                      = false -> null
#       - command                                     = [
#           - "nginx",
#           - "-g",
#           - "daemon off;",
#         ] -> null
#       - container_read_refresh_timeout_milliseconds = 15000 -> null
#       - cpu_shares                                  = 0 -> null
#       - dns                                         = [] -> null
#       - dns_opts                                    = [] -> null
#       - dns_search                                  = [] -> null
#       - entrypoint                                  = [
#           - "/docker-entrypoint.sh",
#         ] -> null
#       - env                                         = [] -> null
#       - group_add                                   = [] -> null
#       - hostname                                    = "75c42bbb9156" -> null
#       - id                                          = "75c42bbb9156ff2c02ef70bf88ca4d0918b2dbbf2da4aa6e97e1678b379aaa7e" -> null
#       - image                                       = "sha256:967ca3be8ed4cdc3b937a7b5a5a899166389e2cf3704d9f588f4db903488d12f" -> null
#       - init                                        = false -> null
#       - ipc_mode                                    = "private" -> null
#       - log_driver                                  = "json-file" -> null
#       - log_opts                                    = {} -> null
#       - logs                                        = false -> null
#       - max_retry_count                             = 0 -> null
#       - memory                                      = 0 -> null
#       - memory_swap                                 = 0 -> null
#       - must_run                                    = true -> null
#       - name                                        = "container-04" -> null
#       - network_data                                = [
#           - {
#               - gateway                   = "172.17.0.1"
#               - global_ipv6_address       = ""
#               - global_ipv6_prefix_length = 0
#               - ip_address                = "172.17.0.4"
#               - ip_prefix_length          = 16
#               - ipv6_gateway              = ""
#               - mac_address               = "02:42:ac:11:00:04"
#               - network_name              = "bridge"
#             },
#         ] -> null
#       - network_mode                                = "default" -> null
#       - privileged                                  = false -> null
#       - publish_all_ports                           = false -> null
#       - read_only                                   = false -> null
#       - remove_volumes                              = true -> null
#       - restart                                     = "no" -> null
#       - rm                                          = false -> null
#       - runtime                                     = "runc" -> null
#       - security_opts                               = [] -> null
#       - shm_size                                    = 64 -> null
#       - start                                       = true -> null
#       - stdin_open                                  = false -> null
#       - stop_signal                                 = "SIGQUIT" -> null
#       - stop_timeout                                = 0 -> null
#       - storage_opts                                = {} -> null
#       - sysctls                                     = {} -> null
#       - tmpfs                                       = {} -> null
#       - tty                                         = false -> null
#       - wait                                        = false -> null
#       - wait_timeout                                = 60 -> null
# 
#       - ports {
#           - external = 8083 -> null
#           - internal = 80 -> null
#           - ip       = "0.0.0.0" -> null
#           - protocol = "tcp" -> null
#         }
#     }
# 
#   # docker_image.nginx will be destroyed
#   - resource "docker_image" "nginx" {
#       - id           = "sha256:967ca3be8ed4cdc3b937a7b5a5a899166389e2cf3704d9f588f4db903488d12fnginx:stable" -> null
#       - image_id     = "sha256:967ca3be8ed4cdc3b937a7b5a5a899166389e2cf3704d9f588f4db903488d12f" -> null
#       - keep_locally = false -> null
#       - name         = "nginx:stable" -> null
#       - repo_digest  = "nginx@sha256:8091c5f722b5060431042b000a742df96a586c6ecc3dcb440fbbdbdc3c261f3e" -> null
#     }
# 
# Plan: 0 to add, 0 to change, 4 to destroy.
# 
# Do you really want to destroy all resources?
#   Terraform will destroy all your managed infrastructure, as shown above.
#   There is no undo. Only 'yes' will be accepted to confirm.
# 
#   Enter a value: yes
# 
# docker_container.nginx["container-04"]: Destroying... [id=75c42bbb9156ff2c02ef70bf88ca4d0918b2dbbf2da4aa6e97e1678b379aaa7e]
# docker_container.nginx["container-03"]: Destroying... [id=82278825eadb7b0bdeb3919b6f0ab31701d42348fd26b6a6003de8556abf5186]
# docker_container.nginx["container-01"]: Destroying... [id=0c801be09bad6d7ba47ded4be95520a4d969f8bedaf90159d495fcef3b809b13]
# docker_container.nginx["container-04"]: Destruction complete after 1s
# docker_container.nginx["container-03"]: Destruction complete after 1s
# docker_container.nginx["container-01"]: Destruction complete after 1s
# docker_image.nginx: Destroying... [id=sha256:967ca3be8ed4cdc3b937a7b5a5a899166389e2cf3704d9f588f4db903488d12fnginx:stable]
# docker_image.nginx: Destruction complete after 0s
# 
# Destroy complete! Resources: 4 destroyed.


# Ao final compare o arquivo main.tf deste exercício com o do exercício anterior e observe as diferenças
# de implementação para a criação dos objetos. 
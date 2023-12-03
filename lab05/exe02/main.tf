# Lab05
# Atividade 5.2.
# 
# Crie uma automação em terraform para a criação de containers em docker com base
# nas definições de um mapa de variáveis. A automação deve identificar a quantidade
# de elementos e os parâmetros e definir as propriedades de acordo com o especificado.


# Crie um arquivo chamado "~/terraform/lab05/exe02/main.tf", com o seguinte conteúdo:


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
  count = length(var.instances)
  image = docker_image.nginx.image_id
  name  = "${var.instances[count.index].name}"
  ports {
    internal = var.instances[count.index].internal_port
    external = var.instances[count.index].external_port
  }
}


# Crie um arquivo chamado "~/terraform/lab05/exe01/variables.tf", com o seguinte conteúdo:
# 
# variable "instances" {
#   type = list(object({
#     name          = string
#     internal_port = number
#     external_port = number
#   }))
# }


# Crie um arquivo chamado "~/terraform/lab05/exe01/terraform.tfvars", com o seguinte conteúdo:
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


# Crie um arquivo chamado "~/terraform/lab05/exe01/terraform-3-nodes.tfvars", com o seguinte conteúdo:
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
# - Finding kreuzwerker/docker versions matching "~> 3.0.0"...
# - Installing kreuzwerker/docker v3.0.2...
# - Installed kreuzwerker/docker v3.0.2 (self-signed, key ID BD080C4571C6104C)
# 
# Partner and community providers are signed by their developers.
# If you'd like to know more about provider signing, you can read about it here:
# https://www.terraform.io/docs/cli/plugins/signing.html
# 
# Terraform has created a lock file .terraform.lock.hcl to record the provider
# selections it made above. Include this file in your version control repository
# so that Terraform can guarantee to make the same selections by default when
# you run "terraform init" in the future.
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


# Na sequência execute o comando abaixo para validar o plano de execução do terraform:
# 
# $ terraform plan
# 
# Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
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
#   # docker_container.nginx[3] will be created
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
# ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
# 
# Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply"
# now.


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
#   # docker_container.nginx[3] will be created
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
# docker_container.nginx[0]: Creating...
# docker_container.nginx[2]: Creating...
# docker_container.nginx[1]: Creating...
# docker_container.nginx[3]: Creating...
# docker_container.nginx[0]: Creation complete after 4s [id=824e0be4f3127247672347d54787505bf3608021e00b027641b585c00cf496c6]
# docker_container.nginx[2]: Creation complete after 4s [id=15492df8a581c80c683997f52e9df60eb145c397a2627250e9803d863f4d0a47]
# docker_container.nginx[1]: Creation complete after 4s [id=f06dd31bc9983ada0b935349cb75e372a0def7d7e7567623245b9becb7d8bd7f]
# docker_container.nginx[3]: Creation complete after 4s [id=6bae7ff19e699c28d03ff681d14edcdb2ca2fe0f2c21a9ce7813b5dd287cf470]
# 
# Apply complete! Resources: 5 added, 0 changed, 0 destroyed.


# Verifique o status dos containers, conforme o comando abaixo:
# 
# $ docker ps
# CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS          PORTS                  NAMES
# 2f3aa3e70ef5   967ca3be8ed4   "/docker-entrypoint.…"   23 seconds ago   Up 20 seconds   0.0.0.0:8083->80/tcp   container-04
# c029d0278613   967ca3be8ed4   "/docker-entrypoint.…"   23 seconds ago   Up 19 seconds   0.0.0.0:8080->80/tcp   container-01
# da1b774576c0   967ca3be8ed4   "/docker-entrypoint.…"   23 seconds ago   Up 19 seconds   0.0.0.0:8081->80/tcp   container-02
# 6150bb848277   967ca3be8ed4   "/docker-entrypoint.…"   23 seconds ago   Up 20 seconds   0.0.0.0:8082->80/tcp   container-03


# Na sequência execute novamente o comando de "terraform apply", mas utilizando outro arquivo de variáveis:
# 
# $ terraform apply -var-file terraform-3-nodes.tfvars 
# 
# docker_image.nginx: Refreshing state... [id=sha256:967ca3be8ed4cdc3b937a7b5a5a899166389e2cf3704d9f588f4db903488d12fnginx:stable]
# docker_container.nginx[1]: Refreshing state... [id=da1b774576c08f21cf4cfb264147de80affc6a223a398ed0e0a20163c926fd5f]
# docker_container.nginx[3]: Refreshing state... [id=2f3aa3e70ef53a35b8cd3a961aaa81f516e64904cd23c78644f65c544ec445eb]
# docker_container.nginx[2]: Refreshing state... [id=6150bb8482774a90c947d17bbf1e18b3de5a311cd98fd44065b5cef0bcf4f823]
# docker_container.nginx[0]: Refreshing state... [id=c029d02786133bb31affbb72fafe067c0b07e03346fae9294b5ea28ef3391d4a]
# 
# Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
#   - destroy
# -/+ destroy and then create replacement
# 
# Terraform will perform the following actions:
# 
#   # docker_container.nginx[2] must be replaced
# -/+ resource "docker_container" "nginx" {
#       + bridge                                      = (known after apply)
#       ~ command                                     = [
#           - "nginx",
#           - "-g",
#           - "daemon off;",
#         ] -> (known after apply)
#       + container_logs                              = (known after apply)
#       - cpu_shares                                  = 0 -> null
#       - dns                                         = [] -> null
#       - dns_opts                                    = [] -> null
#       - dns_search                                  = [] -> null
#       ~ entrypoint                                  = [
#           - "/docker-entrypoint.sh",
#         ] -> (known after apply)
#       ~ env                                         = [] -> (known after apply)
#       + exit_code                                   = (known after apply)
#       - group_add                                   = [] -> null
#       ~ hostname                                    = "6150bb848277" -> (known after apply)
#       ~ id                                          = "6150bb8482774a90c947d17bbf1e18b3de5a311cd98fd44065b5cef0bcf4f823" -> (known after apply)
#       ~ init                                        = false -> (known after apply)
#       ~ ipc_mode                                    = "private" -> (known after apply)
#       ~ log_driver                                  = "json-file" -> (known after apply)
#       - log_opts                                    = {} -> null
#       - max_retry_count                             = 0 -> null
#       - memory                                      = 0 -> null
#       - memory_swap                                 = 0 -> null
#         name                                        = "container-03"
#       ~ network_data                                = [
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
#         ] -> (known after apply)
#       - network_mode                                = "default" -> null
#       - privileged                                  = false -> null
#       - publish_all_ports                           = false -> null
#       ~ runtime                                     = "runc" -> (known after apply)
#       ~ security_opts                               = [] -> (known after apply)
#       ~ shm_size                                    = 64 -> (known after apply)
#       ~ stop_signal                                 = "SIGQUIT" -> (known after apply)
#       ~ stop_timeout                                = 0 -> (known after apply)
#       - storage_opts                                = {} -> null
#       - sysctls                                     = {} -> null
#       - tmpfs                                       = {} -> null
#         # (14 unchanged attributes hidden)
# 
#       ~ ports {
#           ~ external = 8082 -> 8083 # forces replacement
#             # (3 unchanged attributes hidden)
#         }
#     }
# 
#   # docker_container.nginx[3] will be destroyed
#   # (because index [3] is out of range for count)
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
#       - hostname                                    = "2f3aa3e70ef5" -> null
#       - id                                          = "2f3aa3e70ef53a35b8cd3a961aaa81f516e64904cd23c78644f65c544ec445eb" -> null
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
#           - external = 8083 -> null
#           - internal = 80 -> null
#           - ip       = "0.0.0.0" -> null
#           - protocol = "tcp" -> null
#         }
#     }
# 
# Plan: 1 to add, 0 to change, 2 to destroy.
# 
# Do you want to perform these actions?
#   Terraform will perform the actions described above.
#   Only 'yes' will be accepted to approve.
# 
#   Enter a value: yes
# 
# docker_container.nginx[2]: Destroying... [id=6150bb8482774a90c947d17bbf1e18b3de5a311cd98fd44065b5cef0bcf4f823]
# docker_container.nginx[3]: Destroying... [id=2f3aa3e70ef53a35b8cd3a961aaa81f516e64904cd23c78644f65c544ec445eb]
# docker_container.nginx[2]: Destruction complete after 1s
# docker_container.nginx[2]: Creating...
# docker_container.nginx[3]: Destruction complete after 1s
# docker_container.nginx[2]: Creation complete after 0s [id=8820a1eac7e53b5867b4c59f7bdd1a016c667444fe19142241bb59400b2758bc]
# 
# Apply complete! Resources: 1 added, 0 changed, 2 destroyed.


# Você deve receber uma mensagem erro ao executar o comando acima. Este comportamento é normal, e ocorre devido a forma
# como o terraform trata os índices. Em caso de erro execute novamente o mesmo comando:
# 
# $ terraform apply -var-file terraform-3-nodes.tfvars 


# Observe que o container "docker_container.nginx[2]" e "docker_container.nginx[3]" foram destruídos e o container "docker_container.nginx[2]" foi recriados.

 
# Execute o comando "terraform destroy" para destruir o ambiente, conforme abaixo:
# 
# $ terraform destroy -var-file terraform-3-nodes.tfvars 
# 
# docker_image.nginx: Refreshing state... [id=sha256:967ca3be8ed4cdc3b937a7b5a5a899166389e2cf3704d9f588f4db903488d12fnginx:stable]
# docker_container.nginx[2]: Refreshing state... [id=8820a1eac7e53b5867b4c59f7bdd1a016c667444fe19142241bb59400b2758bc]
# docker_container.nginx[1]: Refreshing state... [id=da1b774576c08f21cf4cfb264147de80affc6a223a398ed0e0a20163c926fd5f]
# docker_container.nginx[0]: Refreshing state... [id=c029d02786133bb31affbb72fafe067c0b07e03346fae9294b5ea28ef3391d4a]
# 
# Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
#   - destroy
# 
# Terraform will perform the following actions:
# 
#   # docker_container.nginx[0] will be destroyed
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
#       - hostname                                    = "c029d0278613" -> null
#       - id                                          = "c029d02786133bb31affbb72fafe067c0b07e03346fae9294b5ea28ef3391d4a" -> null
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
#   # docker_container.nginx[1] will be destroyed
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
#       - hostname                                    = "da1b774576c0" -> null
#       - id                                          = "da1b774576c08f21cf4cfb264147de80affc6a223a398ed0e0a20163c926fd5f" -> null
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
#           - external = 8081 -> null
#           - internal = 80 -> null
#           - ip       = "0.0.0.0" -> null
#           - protocol = "tcp" -> null
#         }
#     }
# 
#   # docker_container.nginx[2] will be destroyed
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
#       - hostname                                    = "8820a1eac7e5" -> null
#       - id                                          = "8820a1eac7e53b5867b4c59f7bdd1a016c667444fe19142241bb59400b2758bc" -> null
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
# docker_container.nginx[1]: Destroying... [id=da1b774576c08f21cf4cfb264147de80affc6a223a398ed0e0a20163c926fd5f]
# docker_container.nginx[0]: Destroying... [id=c029d02786133bb31affbb72fafe067c0b07e03346fae9294b5ea28ef3391d4a]
# docker_container.nginx[2]: Destroying... [id=8820a1eac7e53b5867b4c59f7bdd1a016c667444fe19142241bb59400b2758bc]
# docker_container.nginx[1]: Destruction complete after 1s
# docker_container.nginx[0]: Destruction complete after 1s
# docker_container.nginx[2]: Destruction complete after 1s
# docker_image.nginx: Destroying... [id=sha256:967ca3be8ed4cdc3b937a7b5a5a899166389e2cf3704d9f588f4db903488d12fnginx:stable]
# docker_image.nginx: Destruction complete after 0s
# 
# Destroy complete! Resources: 4 destroyed.
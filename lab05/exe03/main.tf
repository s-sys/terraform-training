# Lab05
# Atividade 5.3.
# 
# Crie uma automação em terraform para a criação de containers em docker com base nas definições de um mapa de variáveis. A automação deve identificar a quantidade de elementos e os parâmetros e definir as propriedades de acordo com o especificado. Neste exemplo, ao invés de utilizar count, deve-se utilizar a estrutura for_each. 


# Crie um arquivo chamado "~/terraform/lab05/exe03/main.tf", com o seguinte conteúdo:

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

resource "docker_image" "nginx" {
  name         = "nginx:stable"
  keep_locally = false
}

resource "docker_container" "nginx" {
  for_each = { for o in var.instances: o.name => o}
  image    = docker_image.nginx.latest
  name     = each.key
  ports {
    internal = each.value.internal_port
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
# - Finding kreuzwerker/docker versions matching "2.15.0"...
# - Installing kreuzwerker/docker v2.15.0...
# - Installed kreuzwerker/docker v2.15.0 (self-signed, key ID BD080C4571C6104C)
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
#       + image            = (known after apply)
#       + init             = (known after apply)
#       + ip_address       = (known after apply)
#       + ip_prefix_length = (known after apply)
#       + ipc_mode         = (known after apply)
#       + log_driver       = "json-file"
#       + logs             = false
#       + must_run         = true
#       + name             = "container-01"
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
#           + external = 8080
#           + internal = 80
#           + ip       = "0.0.0.0"
#           + protocol = "tcp"
#         }
#     }
# 
#   # docker_container.nginx["container-02"] will be created
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
#       + image            = (known after apply)
#       + init             = (known after apply)
#       + ip_address       = (known after apply)
#       + ip_prefix_length = (known after apply)
#       + ipc_mode         = (known after apply)
#       + log_driver       = "json-file"
#       + logs             = false
#       + must_run         = true
#       + name             = "container-02"
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
#           + external = 8081
#           + internal = 80
#           + ip       = "0.0.0.0"
#           + protocol = "tcp"
#         }
#     }
# 
#   # docker_container.nginx["container-03"] will be created
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
#       + image            = (known after apply)
#       + init             = (known after apply)
#       + ip_address       = (known after apply)
#       + ip_prefix_length = (known after apply)
#       + ipc_mode         = (known after apply)
#       + log_driver       = "json-file"
#       + logs             = false
#       + must_run         = true
#       + name             = "container-03"
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
#           + external = 8082
#           + internal = 80
#           + ip       = "0.0.0.0"
#           + protocol = "tcp"
#         }
#     }
# 
#   # docker_container.nginx["container-04"] will be created
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
#       + image            = (known after apply)
#       + init             = (known after apply)
#       + ip_address       = (known after apply)
#       + ip_prefix_length = (known after apply)
#       + ipc_mode         = (known after apply)
#       + log_driver       = "json-file"
#       + logs             = false
#       + must_run         = true
#       + name             = "container-04"
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
#       + keep_locally = false
#       + latest       = (known after apply)
#       + name         = "nginx:stable"
#       + output       = (known after apply)
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
# docker_image.nginx: Creation complete after 4s [id=sha256:c8d03f6b8b915209c54fc8ead682f7a5709d11226f6b81185850199f18b277a2nginx:stable]
# docker_container.nginx["container-04"]: Creating...
# docker_container.nginx["container-02"]: Creating...
# docker_container.nginx["container-01"]: Creating...
# docker_container.nginx["container-03"]: Creating...
# docker_container.nginx["container-02"]: Creation complete after 2s [id=6cfb9f7252513ba361f2e62060a3f0390c58a4b593d85d685337ac926ee05176]
# docker_container.nginx["container-01"]: Creation complete after 2s [id=ce9c3640025f2039d33fa1b74604fcd29849507f346db6dab5ee544f012f65fb]
# docker_container.nginx["container-03"]: Creation complete after 3s [id=0267a7fd21408c9c42361b527ca71fccc7603131787ddd6f4ed5b592d462b519]
# docker_container.nginx["container-04"]: Creation complete after 3s [id=49cc788b57dba46f68ffd8d11f2a69ded1fc9b351d928cb5dc1782e40b55b77b]
# 
# Apply complete! Resources: 5 added, 0 changed, 0 destroyed.


# Verifique o status dos containers, conforme o comando abaixo:
# 
# $ docker ps
# CONTAINER ID   IMAGE          COMMAND                  CREATED              STATUS              PORTS                  NAMES
# 0267a7fd2140   c8d03f6b8b91   "/docker-entrypoint.…"   About a minute ago   Up 59 seconds       0.0.0.0:8082->80/tcp   container-03
# ce9c3640025f   c8d03f6b8b91   "/docker-entrypoint.…"   About a minute ago   Up 59 seconds       0.0.0.0:8080->80/tcp   container-01
# 49cc788b57db   c8d03f6b8b91   "/docker-entrypoint.…"   About a minute ago   Up 59 seconds       0.0.0.0:8083->80/tcp   container-04
# 6cfb9f725251   c8d03f6b8b91   "/docker-entrypoint.…"   About a minute ago   Up About a minute   0.0.0.0:8081->80/tcp   container-02



# Na sequência execute novamente o comando de "terraform apply", mas utilizando outro arquivo de variáveis:
#
# $ terraform apply -var-file terraform-3-nodes.tfvars
# 
# docker_image.nginx: Refreshing state... [id=sha256:c8d03f6b8b915209c54fc8ead682f7a5709d11226f6b81185850199f18b277a2nginx:stable]
# docker_container.nginx["container-04"]: Refreshing state... [id=49cc788b57dba46f68ffd8d11f2a69ded1fc9b351d928cb5dc1782e40b55b77b]
# docker_container.nginx["container-01"]: Refreshing state... [id=ce9c3640025f2039d33fa1b74604fcd29849507f346db6dab5ee544f012f65fb]
# docker_container.nginx["container-02"]: Refreshing state... [id=6cfb9f7252513ba361f2e62060a3f0390c58a4b593d85d685337ac926ee05176]
# docker_container.nginx["container-03"]: Refreshing state... [id=0267a7fd21408c9c42361b527ca71fccc7603131787ddd6f4ed5b592d462b519]
# 
# Note: Objects have changed outside of Terraform
# 
# Terraform detected the following changes made outside of Terraform since the last "terraform apply":
# 
#   # docker_container.nginx["container-01"] has been changed
#   ~ resource "docker_container" "nginx" {
#       + dns               = []
#       + dns_opts          = []
#       + dns_search        = []
#       + group_add         = []
#         id                = "ce9c3640025f2039d33fa1b74604fcd29849507f346db6dab5ee544f012f65fb"
#       + links             = []
#       + log_opts          = {}
#         name              = "container-01"
#       + storage_opts      = {}
#       + sysctls           = {}
#       + tmpfs             = {}
#         # (31 unchanged attributes hidden)
# 
#         # (1 unchanged block hidden)
#     }
#   # docker_container.nginx["container-02"] has been changed
#   ~ resource "docker_container" "nginx" {
#       + dns               = []
#       + dns_opts          = []
#       + dns_search        = []
#       + group_add         = []
#         id                = "6cfb9f7252513ba361f2e62060a3f0390c58a4b593d85d685337ac926ee05176"
#       + links             = []
#       + log_opts          = {}
#         name              = "container-02"
#       + storage_opts      = {}
#       + sysctls           = {}
#       + tmpfs             = {}
#         # (31 unchanged attributes hidden)
# 
#         # (1 unchanged block hidden)
#     }
#   # docker_container.nginx["container-03"] has been changed
#   ~ resource "docker_container" "nginx" {
#       + dns               = []
#       + dns_opts          = []
#       + dns_search        = []
#       + group_add         = []
#         id                = "0267a7fd21408c9c42361b527ca71fccc7603131787ddd6f4ed5b592d462b519"
#       + links             = []
#       + log_opts          = {}
#         name              = "container-03"
#       + storage_opts      = {}
#       + sysctls           = {}
#       + tmpfs             = {}
#         # (31 unchanged attributes hidden)
# 
#         # (1 unchanged block hidden)
#     }
#   # docker_container.nginx["container-04"] has been changed
#   ~ resource "docker_container" "nginx" {
#       + dns               = []
#       + dns_opts          = []
#       + dns_search        = []
#       + group_add         = []
#         id                = "49cc788b57dba46f68ffd8d11f2a69ded1fc9b351d928cb5dc1782e40b55b77b"
#       + links             = []
#       + log_opts          = {}
#         name              = "container-04"
#       + storage_opts      = {}
#       + sysctls           = {}
#       + tmpfs             = {}
#         # (31 unchanged attributes hidden)
# 
#         # (1 unchanged block hidden)
#     }
# 
# Unless you have made equivalent changes to your configuration, or ignored the relevant attributes using ignore_changes, the following plan may
# include actions to undo or respond to these changes.
# 
# ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
# 
# Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
#   - destroy
# 
# Terraform will perform the following actions:
# 
#   # docker_container.nginx["container-02"] will be destroyed
#   - resource "docker_container" "nginx" {
#       - attach            = false -> null
#       - command           = [
#           - "nginx",
#           - "-g",
#           - "daemon off;",
#         ] -> null
#       - cpu_shares        = 0 -> null
#       - dns               = [] -> null
#       - dns_opts          = [] -> null
#       - dns_search        = [] -> null
#       - entrypoint        = [
#           - "/docker-entrypoint.sh",
#         ] -> null
#       - env               = [] -> null
#       - gateway           = "172.17.0.1" -> null
#       - group_add         = [] -> null
#       - hostname          = "6cfb9f725251" -> null
#       - id                = "6cfb9f7252513ba361f2e62060a3f0390c58a4b593d85d685337ac926ee05176" -> null
#       - image             = "sha256:c8d03f6b8b915209c54fc8ead682f7a5709d11226f6b81185850199f18b277a2" -> null
#       - init              = false -> null
#       - ip_address        = "172.17.0.2" -> null
#       - ip_prefix_length  = 16 -> null
#       - ipc_mode          = "private" -> null
#       - links             = [] -> null
#       - log_driver        = "json-file" -> null
#       - log_opts          = {} -> null
#       - logs              = false -> null
#       - max_retry_count   = 0 -> null
#       - memory            = 0 -> null
#       - memory_swap       = 0 -> null
#       - must_run          = true -> null
#       - name              = "container-02" -> null
#       - network_data      = [
#           - {
#               - gateway                   = "172.17.0.1"
#               - global_ipv6_address       = ""
#               - global_ipv6_prefix_length = 0
#               - ip_address                = "172.17.0.2"
#               - ip_prefix_length          = 16
#               - ipv6_gateway              = ""
#               - network_name              = "bridge"
#             },
#         ] -> null
#       - network_mode      = "default" -> null
#       - privileged        = false -> null
#       - publish_all_ports = false -> null
#       - read_only         = false -> null
#       - remove_volumes    = true -> null
#       - restart           = "no" -> null
#       - rm                = false -> null
#       - security_opts     = [] -> null
#       - shm_size          = 64 -> null
#       - start             = true -> null
#       - stdin_open        = false -> null
#       - storage_opts      = {} -> null
#       - sysctls           = {} -> null
#       - tmpfs             = {} -> null
#       - tty               = false -> null
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
# docker_container.nginx["container-02"]: Destroying... [id=6cfb9f7252513ba361f2e62060a3f0390c58a4b593d85d685337ac926ee05176]
# docker_container.nginx["container-02"]: Destruction complete after 1s
# 
# Apply complete! Resources: 0 added, 0 changed, 1 destroyed.


# Observem que apenas o containter "docker_container.nginx["container-02"]" foi removido.
# 

 
# Execute o comando "terraform destroy" para destruir o ambiente, conforme abaixo:
# 
# $ terraform destroy 
# 
# docker_image.nginx: Refreshing state... [id=sha256:c8d03f6b8b915209c54fc8ead682f7a5709d11226f6b81185850199f18b277a2nginx:stable]
# docker_container.nginx["container-04"]: Refreshing state... [id=49cc788b57dba46f68ffd8d11f2a69ded1fc9b351d928cb5dc1782e40b55b77b]
# docker_container.nginx["container-03"]: Refreshing state... [id=0267a7fd21408c9c42361b527ca71fccc7603131787ddd6f4ed5b592d462b519]
# docker_container.nginx["container-01"]: Refreshing state... [id=ce9c3640025f2039d33fa1b74604fcd29849507f346db6dab5ee544f012f65fb]
# 
# Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
#   - destroy
# 
# Terraform will perform the following actions:
# 
#   # docker_container.nginx["container-01"] will be destroyed
#   - resource "docker_container" "nginx" {
#       - attach            = false -> null
#       - command           = [
#           - "nginx",
#           - "-g",
#           - "daemon off;",
#         ] -> null
#       - cpu_shares        = 0 -> null
#       - dns               = [] -> null
#       - dns_opts          = [] -> null
#       - dns_search        = [] -> null
#       - entrypoint        = [
#           - "/docker-entrypoint.sh",
#         ] -> null
#       - env               = [] -> null
#       - gateway           = "172.17.0.1" -> null
#       - group_add         = [] -> null
#       - hostname          = "ce9c3640025f" -> null
#       - id                = "ce9c3640025f2039d33fa1b74604fcd29849507f346db6dab5ee544f012f65fb" -> null
#       - image             = "sha256:c8d03f6b8b915209c54fc8ead682f7a5709d11226f6b81185850199f18b277a2" -> null
#       - init              = false -> null
#       - ip_address        = "172.17.0.3" -> null
#       - ip_prefix_length  = 16 -> null
#       - ipc_mode          = "private" -> null
#       - links             = [] -> null
#       - log_driver        = "json-file" -> null
#       - log_opts          = {} -> null
#       - logs              = false -> null
#       - max_retry_count   = 0 -> null
#       - memory            = 0 -> null
#       - memory_swap       = 0 -> null
#       - must_run          = true -> null
#       - name              = "container-01" -> null
#       - network_data      = [
#           - {
#               - gateway                   = "172.17.0.1"
#               - global_ipv6_address       = ""
#               - global_ipv6_prefix_length = 0
#               - ip_address                = "172.17.0.3"
#               - ip_prefix_length          = 16
#               - ipv6_gateway              = ""
#               - network_name              = "bridge"
#             },
#         ] -> null
#       - network_mode      = "default" -> null
#       - privileged        = false -> null
#       - publish_all_ports = false -> null
#       - read_only         = false -> null
#       - remove_volumes    = true -> null
#       - restart           = "no" -> null
#       - rm                = false -> null
#       - security_opts     = [] -> null
#       - shm_size          = 64 -> null
#       - start             = true -> null
#       - stdin_open        = false -> null
#       - storage_opts      = {} -> null
#       - sysctls           = {} -> null
#       - tmpfs             = {} -> null
#       - tty               = false -> null
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
#       - attach            = false -> null
#       - command           = [
#           - "nginx",
#           - "-g",
#           - "daemon off;",
#         ] -> null
#       - cpu_shares        = 0 -> null
#       - dns               = [] -> null
#       - dns_opts          = [] -> null
#       - dns_search        = [] -> null
#       - entrypoint        = [
#           - "/docker-entrypoint.sh",
#         ] -> null
#       - env               = [] -> null
#       - gateway           = "172.17.0.1" -> null
#       - group_add         = [] -> null
#       - hostname          = "0267a7fd2140" -> null
#       - id                = "0267a7fd21408c9c42361b527ca71fccc7603131787ddd6f4ed5b592d462b519" -> null
#       - image             = "sha256:c8d03f6b8b915209c54fc8ead682f7a5709d11226f6b81185850199f18b277a2" -> null
#       - init              = false -> null
#       - ip_address        = "172.17.0.5" -> null
#       - ip_prefix_length  = 16 -> null
#       - ipc_mode          = "private" -> null
#       - links             = [] -> null
#       - log_driver        = "json-file" -> null
#       - log_opts          = {} -> null
#       - logs              = false -> null
#       - max_retry_count   = 0 -> null
#       - memory            = 0 -> null
#       - memory_swap       = 0 -> null
#       - must_run          = true -> null
#       - name              = "container-03" -> null
#       - network_data      = [
#           - {
#               - gateway                   = "172.17.0.1"
#               - global_ipv6_address       = ""
#               - global_ipv6_prefix_length = 0
#               - ip_address                = "172.17.0.5"
#               - ip_prefix_length          = 16
#               - ipv6_gateway              = ""
#               - network_name              = "bridge"
#             },
#         ] -> null
#       - network_mode      = "default" -> null
#       - privileged        = false -> null
#       - publish_all_ports = false -> null
#       - read_only         = false -> null
#       - remove_volumes    = true -> null
#       - restart           = "no" -> null
#       - rm                = false -> null
#       - security_opts     = [] -> null
#       - shm_size          = 64 -> null
#       - start             = true -> null
#       - stdin_open        = false -> null
#       - storage_opts      = {} -> null
#       - sysctls           = {} -> null
#       - tmpfs             = {} -> null
#       - tty               = false -> null
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
#       - attach            = false -> null
#       - command           = [
#           - "nginx",
#           - "-g",
#           - "daemon off;",
#         ] -> null
#       - cpu_shares        = 0 -> null
#       - dns               = [] -> null
#       - dns_opts          = [] -> null
#       - dns_search        = [] -> null
#       - entrypoint        = [
#           - "/docker-entrypoint.sh",
#         ] -> null
#       - env               = [] -> null
#       - gateway           = "172.17.0.1" -> null
#       - group_add         = [] -> null
#       - hostname          = "49cc788b57db" -> null
#       - id                = "49cc788b57dba46f68ffd8d11f2a69ded1fc9b351d928cb5dc1782e40b55b77b" -> null
#       - image             = "sha256:c8d03f6b8b915209c54fc8ead682f7a5709d11226f6b81185850199f18b277a2" -> null
#       - init              = false -> null
#       - ip_address        = "172.17.0.4" -> null
#       - ip_prefix_length  = 16 -> null
#       - ipc_mode          = "private" -> null
#       - links             = [] -> null
#       - log_driver        = "json-file" -> null
#       - log_opts          = {} -> null
#       - logs              = false -> null
#       - max_retry_count   = 0 -> null
#       - memory            = 0 -> null
#       - memory_swap       = 0 -> null
#       - must_run          = true -> null
#       - name              = "container-04" -> null
#       - network_data      = [
#           - {
#               - gateway                   = "172.17.0.1"
#               - global_ipv6_address       = ""
#               - global_ipv6_prefix_length = 0
#               - ip_address                = "172.17.0.4"
#               - ip_prefix_length          = 16
#               - ipv6_gateway              = ""
#               - network_name              = "bridge"
#             },
#         ] -> null
#       - network_mode      = "default" -> null
#       - privileged        = false -> null
#       - publish_all_ports = false -> null
#       - read_only         = false -> null
#       - remove_volumes    = true -> null
#       - restart           = "no" -> null
#       - rm                = false -> null
#       - security_opts     = [] -> null
#       - shm_size          = 64 -> null
#       - start             = true -> null
#       - stdin_open        = false -> null
#       - storage_opts      = {} -> null
#       - sysctls           = {} -> null
#       - tmpfs             = {} -> null
#       - tty               = false -> null
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
#       - id           = "sha256:c8d03f6b8b915209c54fc8ead682f7a5709d11226f6b81185850199f18b277a2nginx:stable" -> null
#       - keep_locally = false -> null
#       - latest       = "sha256:c8d03f6b8b915209c54fc8ead682f7a5709d11226f6b81185850199f18b277a2" -> null
#       - name         = "nginx:stable" -> null
#       - repo_digest  = "nginx@sha256:9e37120c97a0787656cad9c24c3a5d5d606a770523144d01eae6734095a92c20" -> null
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
# docker_container.nginx["container-04"]: Destroying... [id=49cc788b57dba46f68ffd8d11f2a69ded1fc9b351d928cb5dc1782e40b55b77b]
# docker_container.nginx["container-01"]: Destroying... [id=ce9c3640025f2039d33fa1b74604fcd29849507f346db6dab5ee544f012f65fb]
# docker_container.nginx["container-03"]: Destroying... [id=0267a7fd21408c9c42361b527ca71fccc7603131787ddd6f4ed5b592d462b519]
# docker_container.nginx["container-03"]: Destruction complete after 1s
# docker_container.nginx["container-01"]: Destruction complete after 1s
# docker_container.nginx["container-04"]: Destruction complete after 1s
# docker_image.nginx: Destroying... [id=sha256:c8d03f6b8b915209c54fc8ead682f7a5709d11226f6b81185850199f18b277a2nginx:stable]
# docker_image.nginx: Destruction complete after 0s
# 
# Destroy complete! Resources: 4 destroyed.

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
  count = length(var.instances)
  image = docker_image.nginx.latest
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
#   # docker_container.nginx[3] will be created
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
# ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
# 
# Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.


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
#   # docker_container.nginx[3] will be created
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
#       + name         = "nginx:latest"
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
# docker_image.nginx: Creation complete after 6s [id=sha256:87a94228f133e2da99cb16d653cd1373c5b4e8689956386c1c12b60a20421a02nginx:latest]
# docker_container.nginx[0]: Creating...
# docker_container.nginx[1]: Creating...
# docker_container.nginx[2]: Creating...
# docker_container.nginx[3]: Creating...
# docker_container.nginx[3]: Creation complete after 4s [id=cb4f5bab798b2c8fffdd526d48c9b1599e17796fd6900f8e6d4b28a9a14337f2]
# docker_container.nginx[1]: Creation complete after 4s [id=95cd486b083655a061939a00e15b2d4f944c1c0fb514fe07f299557b5f9ef1b0]
# docker_container.nginx[2]: Creation complete after 4s [id=faf7122d486909ae5e0bb6ac36fe242e0026dad5e4d35d72ceb87e9b1f591f75]
# docker_container.nginx[0]: Creation complete after 4s [id=d529939683fcf9240da37d3026542c50c1b3096d6a019b2751e9e937454d0c06]
# 
# Apply complete! Resources: 5 added, 0 changed, 0 destroyed.


# Verifique o status dos containers, conforme o comando abaixo:
# 
# $ docker ps
# CONTAINER ID   IMAGE          COMMAND                  CREATED         STATUS         PORTS                  NAMES
# 49135a8b04c7   c8d03f6b8b91   "/docker-entrypoint.…"   6 minutes ago   Up 6 minutes   0.0.0.0:8083->80/tcp   container-04
# 7d104c4a45c8   c8d03f6b8b91   "/docker-entrypoint.…"   7 minutes ago   Up 7 minutes   0.0.0.0:8080->80/tcp   container-01
# 9da47bbbf940   c8d03f6b8b91   "/docker-entrypoint.…"   7 minutes ago   Up 7 minutes   0.0.0.0:8081->80/tcp   container-02


# Na sequência execute novamente o comando de "terraform apply", mas utilizando outro arquivo de variáveis:
# 
# $ terraform apply -var-file terraform-3-nodes.tfvars 
# 
# docker_image.nginx: Refreshing state... [id=sha256:c8d03f6b8b915209c54fc8ead682f7a5709d11226f6b81185850199f18b277a2nginx:stable]
# docker_container.nginx[3]: Refreshing state... [id=4a1a3bc944ac60994c3f9c5cc3578dae1e790f8cb308785f680a643ab346d7f0]
# docker_container.nginx[2]: Refreshing state... [id=5201769530fb779b135905a62c2398824fd2789a64a23b12ae69574b1a02b870]
# docker_container.nginx[1]: Refreshing state... [id=9da47bbbf94050756e5de109a4df1316c0e79a7d7028da3fcfd28059c370fd21]
# docker_container.nginx[0]: Refreshing state... [id=7d104c4a45c8daebe78d310091d68173b2fb7047f6b69114529fcb9a31946f0c]
# 
# Note: Objects have changed outside of Terraform
# 
# Terraform detected the following changes made outside of Terraform since the last "terraform apply":
# 
#   # docker_container.nginx[0] has been changed
#   ~ resource "docker_container" "nginx" {
#       + dns               = []
#       + dns_opts          = []
#       + dns_search        = []
#       + group_add         = []
#         id                = "7d104c4a45c8daebe78d310091d68173b2fb7047f6b69114529fcb9a31946f0c"
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
#   # docker_container.nginx[1] has been changed
#   ~ resource "docker_container" "nginx" {
#       + dns               = []
#       + dns_opts          = []
#       + dns_search        = []
#       + group_add         = []
#         id                = "9da47bbbf94050756e5de109a4df1316c0e79a7d7028da3fcfd28059c370fd21"
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
#   # docker_container.nginx[2] has been changed
#   ~ resource "docker_container" "nginx" {
#       + dns               = []
#       + dns_opts          = []
#       + dns_search        = []
#       + group_add         = []
#         id                = "5201769530fb779b135905a62c2398824fd2789a64a23b12ae69574b1a02b870"
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
#   # docker_container.nginx[3] has been changed
#   ~ resource "docker_container" "nginx" {
#       + dns               = []
#       + dns_opts          = []
#       + dns_search        = []
#       + group_add         = []
#         id                = "4a1a3bc944ac60994c3f9c5cc3578dae1e790f8cb308785f680a643ab346d7f0"
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
# -/+ destroy and then create replacement
# 
# Terraform will perform the following actions:
# 
#   # docker_container.nginx[2] must be replaced
# -/+ resource "docker_container" "nginx" {
#       + bridge            = (known after apply)
#       ~ command           = [
#           - "nginx",
#           - "-g",
#           - "daemon off;",
#         ] -> (known after apply)
#       + container_logs    = (known after apply)
#       - cpu_shares        = 0 -> null
#       - dns               = [] -> null
#       - dns_opts          = [] -> null
#       - dns_search        = [] -> null
#       ~ entrypoint        = [
#           - "/docker-entrypoint.sh",
#         ] -> (known after apply)
#       ~ env               = [] -> (known after apply)
#       + exit_code         = (known after apply)
#       ~ gateway           = "172.17.0.1" -> (known after apply)
#       - group_add         = [] -> null
#       ~ hostname          = "5201769530fb" -> (known after apply)
#       ~ id                = "5201769530fb779b135905a62c2398824fd2789a64a23b12ae69574b1a02b870" -> (known after apply)
#       ~ init              = false -> (known after apply)
#       ~ ip_address        = "172.17.0.5" -> (known after apply)
#       ~ ip_prefix_length  = 16 -> (known after apply)
#       ~ ipc_mode          = "private" -> (known after apply)
#       - links             = [] -> null
#       - log_opts          = {} -> null
#       - max_retry_count   = 0 -> null
#       - memory            = 0 -> null
#       - memory_swap       = 0 -> null
#       ~ name              = "container-03" -> "container-04" # forces replacement
#       ~ network_data      = [
#           - {
#               - gateway                   = "172.17.0.1"
#               - global_ipv6_address       = ""
#               - global_ipv6_prefix_length = 0
#               - ip_address                = "172.17.0.5"
#               - ip_prefix_length          = 16
#               - ipv6_gateway              = ""
#               - network_name              = "bridge"
#             },
#         ] -> (known after apply)
#       - network_mode      = "default" -> null
#       - privileged        = false -> null
#       - publish_all_ports = false -> null
#       ~ security_opts     = [] -> (known after apply)
#       ~ shm_size          = 64 -> (known after apply)
#       - storage_opts      = {} -> null
#       - sysctls           = {} -> null
#       - tmpfs             = {} -> null
#         # (12 unchanged attributes hidden)
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
#       ~ ports {
#           ~ external = 8082 -> 8083 # forces replacement
#             # (3 unchanged attributes hidden)
#         }
#     }
# 
#   # docker_container.nginx[3] will be destroyed
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
#       - hostname          = "4a1a3bc944ac" -> null
#       - id                = "4a1a3bc944ac60994c3f9c5cc3578dae1e790f8cb308785f680a643ab346d7f0" -> null
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
# Plan: 1 to add, 0 to change, 2 to destroy.
# 
# Do you want to perform these actions?
#   Terraform will perform the actions described above.
#   Only 'yes' will be accepted to approve.
# 
#   Enter a value: yes
# 
# docker_container.nginx[2]: Destroying... [id=5201769530fb779b135905a62c2398824fd2789a64a23b12ae69574b1a02b870]
# docker_container.nginx[3]: Destroying... [id=4a1a3bc944ac60994c3f9c5cc3578dae1e790f8cb308785f680a643ab346d7f0]
# docker_container.nginx[3]: Destruction complete after 1s
# docker_container.nginx[2]: Destruction complete after 1s
# docker_container.nginx[2]: Creating...
# docker_container.nginx[2]: Creation complete after 1s [id=49135a8b04c7b98e36f462d899da796423f9bb5d4cbcba86aa6f8341c8182408]
# 
# Apply complete! Resources: 1 added, 0 changed, 2 destroyed.


# Observe que o container "docker_container.nginx[2]" e "docker_container.nginx[3]" foram destruídos e o container "docker_container.nginx[2]" foi recriados.

 
# Execute o comando "terraform destroy" para destruir o ambiente, conforme abaixo:
# 
# $ terraform destroy 
# 
# docker_image.nginx: Refreshing state... [id=sha256:c8d03f6b8b915209c54fc8ead682f7a5709d11226f6b81185850199f18b277a2nginx:stable]
# docker_container.nginx[0]: Refreshing state... [id=7d104c4a45c8daebe78d310091d68173b2fb7047f6b69114529fcb9a31946f0c]
# docker_container.nginx[2]: Refreshing state... [id=49135a8b04c7b98e36f462d899da796423f9bb5d4cbcba86aa6f8341c8182408]
# docker_container.nginx[1]: Refreshing state... [id=9da47bbbf94050756e5de109a4df1316c0e79a7d7028da3fcfd28059c370fd21]
# 
# Note: Objects have changed outside of Terraform
# 
# Terraform detected the following changes made outside of Terraform since the last "terraform apply":
# 
#   # docker_container.nginx[2] has been changed
#   ~ resource "docker_container" "nginx" {
#       + dns               = []
#       + dns_opts          = []
#       + dns_search        = []
#       + group_add         = []
#         id                = "49135a8b04c7b98e36f462d899da796423f9bb5d4cbcba86aa6f8341c8182408"
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
#   # docker_container.nginx[0] will be destroyed
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
#       - hostname          = "7d104c4a45c8" -> null
#       - id                = "7d104c4a45c8daebe78d310091d68173b2fb7047f6b69114529fcb9a31946f0c" -> null
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
#       - name              = "container-01" -> null
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
#           - external = 8080 -> null
#           - internal = 80 -> null
#           - ip       = "0.0.0.0" -> null
#           - protocol = "tcp" -> null
#         }
#     }
# 
#   # docker_container.nginx[1] will be destroyed
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
#       - hostname          = "9da47bbbf940" -> null
#       - id                = "9da47bbbf94050756e5de109a4df1316c0e79a7d7028da3fcfd28059c370fd21" -> null
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
#       - name              = "container-02" -> null
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
#           - external = 8081 -> null
#           - internal = 80 -> null
#           - ip       = "0.0.0.0" -> null
#           - protocol = "tcp" -> null
#         }
#     }
# 
#   # docker_container.nginx[2] will be destroyed
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
#       - hostname          = "49135a8b04c7" -> null
#       - id                = "49135a8b04c7b98e36f462d899da796423f9bb5d4cbcba86aa6f8341c8182408" -> null
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
# docker_container.nginx[0]: Destroying... [id=7d104c4a45c8daebe78d310091d68173b2fb7047f6b69114529fcb9a31946f0c]
# docker_container.nginx[1]: Destroying... [id=9da47bbbf94050756e5de109a4df1316c0e79a7d7028da3fcfd28059c370fd21]
# docker_container.nginx[2]: Destroying... [id=49135a8b04c7b98e36f462d899da796423f9bb5d4cbcba86aa6f8341c8182408]
# docker_container.nginx[2]: Destruction complete after 1s
# docker_container.nginx[1]: Destruction complete after 1s
# docker_container.nginx[0]: Destruction complete after 1s
# docker_image.nginx: Destroying... [id=sha256:c8d03f6b8b915209c54fc8ead682f7a5709d11226f6b81185850199f18b277a2nginx:stable]
# docker_image.nginx: Destruction complete after 0s
# 
# Destroy complete! Resources: 4 destroyed.

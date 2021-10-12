# Lab03
# Atividade 3.5.
# 
# Utilize o terraform para automatizar o deploy do servidor web nginx e implemente uma validação para que a aplicação seja criada apenas caso o servidor 192.168.1.20 esteja disponível através de ping.


# Crie um arquivo chamado "~/terraform/lab03/exe05/main.tf", com o seguinte conteúdo:

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
  name         = "nginx:latest"
  keep_locally = false

  provisioner "local-exec" {
    command = "ping -c 1 -t 5 192.168.1.20"
  }
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.name
  name  = "tutorial"
  ports {
    internal = 80
    external = 8000
  }

  provisioner "local-exec" {
    command = "ping -c 1 -t 5 192.168.1.20"
  }
}


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
#   # docker_container.nginx will be created
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
#       + name             = "tutorial"
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
# Plan: 2 to add, 0 to change, 0 to destroy.
# 
# Do you want to perform these actions?
#   Terraform will perform the actions described above.
#   Only 'yes' will be accepted to approve.
# 
#   Enter a value: yes
# 
# docker_image.nginx: Creating...
# docker_image.nginx: Provisioning with 'local-exec'...
# docker_image.nginx (local-exec): Executing: ["/bin/sh" "-c" "ping -c 1 -t 5 192.168.1.20"]
# docker_image.nginx (local-exec): PING 192.168.1.20 (192.168.1.20) 56(84) bytes of data.
# docker_image.nginx (local-exec): From 192.168.1.1 icmp_seq=1 Destination Host Unreachable
# 
# docker_image.nginx (local-exec): --- 192.168.1.20 ping statistics ---
# docker_image.nginx (local-exec): 1 packets transmitted, 0 received, +1 errors, 100% packet loss, time 0ms
# 
# ╷
# │ Error: local-exec provisioner error
# │ 
# │   with docker_image.nginx,
# │   on main.tf line 18, in resource "docker_image" "nginx":
# │   18:   provisioner "local-exec" {
# │ 
# │ Error running command 'ping -c 1 -t 5 192.168.1.20': exit status 1. Output: PING 192.168.1.20 (192.168.1.20) 56(84) bytes of data.
# │ From 192.168.1.1 icmp_seq=1 Destination Host Unreachable
# │ 
# │ --- 192.168.1.20 ping statistics ---
# │ 1 packets transmitted, 0 received, +1 errors, 100% packet loss, time 0ms
# │ 
# │ 
# ╵


# Observe que ocorreu um erro na execução da automação devido a máquina de IP 192.168.1.20 não estar acessível. Desta forma o recurso não foi criado e o state foi marcado como "taint", ou seja, para remoção na próxima execução do comando "terraform apply". Verifique o state utilizando os comandos abaixo:
# 
# $ terraform state list
# docker_image.nginx
# 
# $ terraform state show docker_image.nginx
# # docker_image.nginx: (tainted)
# resource "docker_image" "nginx" {
#     id           = "sha256:f8f4ffc8092c956ddd6a3a64814f36882798065799b8aedeebedf2855af3395bnginx:latest"
#     keep_locally = false
#     latest       = "sha256:f8f4ffc8092c956ddd6a3a64814f36882798065799b8aedeebedf2855af3395b"
#     name         = "nginx:latest"
#     repo_digest  = "nginx@sha256:06e4235e95299b1d6d595c5ef4c41a9b12641f6683136c18394b858967cd1506"
# }
# 
# Observe o valor de "tainted" ao lado do state, para informar ao terraform que o objeto deve ser excluído. Ao executar o comando "terraform apply" novamente, observe o seguinte trecho na saída da execução:
# 
#   # docker_image.nginx is tainted, so must be replaced
# -/+ resource "docker_image" "nginx" {
#       ~ id           = "sha256:f8f4ffc8092c956ddd6a3a64814f36882798065799b8aedeebedf2855af3395bnginx:latest" -> (known after apply)
#       ~ latest       = "sha256:f8f4ffc8092c956ddd6a3a64814f36882798065799b8aedeebedf2855af3395b" -> (known after apply)
#         name         = "nginx:latest"
#       + output       = (known after apply)
#       ~ repo_digest  = "nginx@sha256:06e4235e95299b1d6d595c5ef4c41a9b12641f6683136c18394b858967cd1506" -> (known after apply)
#         # (1 unchanged attribute hidden)
#     }
# 
# Plan: 2 to add, 0 to change, 1 to destroy.


# Execute o comando "terraform destroy" para destruir o ambiente, conforme abaixo:
# 
# $ terraform destroy

# Lab03
# Atividade 3.5.
# 
# Utilize o terraform para automatizar o deploy do servidor web nginx e implemente
# uma validação para que a aplicação seja criada apenas caso o servidor
# 192.168.1.20 esteja disponível através de ping.


# Crie um arquivo chamado "~/terraform/lab03/exe05/main.tf", com o seguinte conteúdo:

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
#   # docker_container.nginx will be created
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
#       + name                                        = "tutorial"
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
#   # docker_image.nginx will be created
#   + resource "docker_image" "nginx" {
#       + id           = (known after apply)
#       + image_id     = (known after apply)
#       + keep_locally = false
#       + name         = "nginx:latest"
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
# │
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
# 


# Observe que ocorreu um erro na execução da automação devido a máquina de IP
# 192.168.1.20 não estar acessível. Desta forma o recurso não foi criado e o
# state foi marcado como "taint", ou seja, para remoção na próxima execução do
# comando "terraform apply". Verifique o state utilizando os comandos abaixo:
# 
# $ terraform state list
# docker_image.nginx
# 
# $ terraform state show docker_image.nginx
# # docker_image.nginx: (tainted)
# resource "docker_image" "nginx" {
#     id           = "sha256:593aee2afb642798b83a85306d2625fd7f089c0a1242c7e75a237846d80aa2a0nginx:latest"
#     image_id     = "sha256:593aee2afb642798b83a85306d2625fd7f089c0a1242c7e75a237846d80aa2a0"
#     keep_locally = false
#     name         = "nginx:latest"
#     repo_digest  = "nginx@sha256:add4792d930c25dd2abf2ef9ea79de578097a1c175a16ab25814332fe33622de"
# }


# Observe o valor de "tainted" ao lado do state, para informar ao terraform que
# o objeto deve ser excluído. Ao executar o comando "terraform apply" novamente,
# observe o seguinte trecho na saída da execução:
# 
#   # docker_image.nginx is tainted, so must be replaced
# -/+ resource "docker_image" "nginx" {
#       ~ id           = "sha256:593aee2afb642798b83a85306d2625fd7f089c0a1242c7e75a237846d80aa2a0nginx:latest" -> (known after apply)
#       ~ image_id     = "sha256:593aee2afb642798b83a85306d2625fd7f089c0a1242c7e75a237846d80aa2a0" -> (known after apply)
#         name         = "nginx:latest"
#       ~ repo_digest  = "nginx@sha256:add4792d930c25dd2abf2ef9ea79de578097a1c175a16ab25814332fe33622de" -> (known after apply)
#         # (1 unchanged attribute hidden)
#     }
# 
# Plan: 2 to add, 0 to change, 1 to destroy.


# Execute o comando "terraform destroy" para destruir o ambiente, conforme abaixo:
# 
# $ terraform destroy

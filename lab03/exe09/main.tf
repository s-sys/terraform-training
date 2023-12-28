# Lab03
# Atividade 3.9.
# 
# Crie um cenário de testes para validação se as configurações apresentadas no seu arquivo
# de configuração do terraform foram definidas corretamente, conforme o esperado.
# Utilizaremos uma configuração anterior para a realização e validação dos testes.


# Crie um arquivo chamado "~/terraform/lab03/exe09/main.tf",
# com o seguinte conteúdo:

terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

provider "docker" {
  host = "tcp://192.168.1.11:2375"
}

resource "docker_image" "ubuntu" {
  name         = "ubuntu:jammy"
  keep_locally = false
}

resource "docker_container" "ubuntu" {
  image   = docker_image.ubuntu.name
  name    = "ubuntu"
  command = ["tail", "-f", "/dev/null"]
}


# Execute o comando abaixo para inicializar o diretório do terraform e verifique
# a saída do comando:
#
# $ terraform init
# 
# Initializing the backend...
# 
# Initializing provider plugins...
# - Reusing previous version of kreuzwerker/docker from the dependency lock file
# - Installing kreuzwerker/docker v3.0.2...
# - Installed kreuzwerker/docker v3.0.2 (self-signed, key ID BD080C4571C6104C)
# 
# Partner and community providers are signed by their developers.
# If you'd like to know more about provider signing, you can read about it here:
# https://www.terraform.io/docs/cli/plugins/signing.html
# 
# Terraform has made some changes to the provider dependency selections recorded
# in the .terraform.lock.hcl file. Review those changes and commit them to your
# version control system if they represent changes you intended to make.
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


# Crie um arquivo chamado "~/terraform/lab03/exe09/main.tftest.hcl",
# com o seguinte conteúdo:

# variables {
#   docker_image_name = "ubuntu:jammy"
#   keep_locally      = false
# }
# 
# run "validate_ubuntu_version" {
#   command = plan
# 
#   assert {
#     condition     = docker_image.ubuntu.name == var.docker_image_name
#     error_message = "Ubuntu image not valid."
#   }
# }
# 
# run "validate_docker_cache" {
#   command = plan
# 
#   assert {
#     condition     = docker_image.ubuntu.keep_locally == var.keep_locally
#     error_message = "Docker image should not be cached locally."
#   }
# }


# Na sequência execute o comando abaixo para aplicar o teste unitário na configuração do terraform:
# 
# $ terraform test
#
# main.tftest.hcl... in progress
#   run "validate_ubuntu_version"... pass
#   run "validate_docker_cache"... pass
# main.tftest.hcl... tearing down
# main.tftest.hcl... pass
# 
# Success! 2 passed, 0 failed.
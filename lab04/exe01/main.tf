# Lab04
# Atividade 4.1.
# 
# Crie um arquivo de terraform para a automação de uso de um módulo customizado. Defina as variáveis de entrada e analise as interações entre os arquivos.


# Crie um arquivo chamado "~/terraform/lab04/exe01/main.tf", com o seguinte conteúdo:

module "user1" {
  source    = "./modules/userinfo"
  username  = "joao"
  full_name = "Joao Manuel da Silva"
  address   = "Rua das Orquideas, 100"
  city      = "Belo Horizonte"
  state     = "MG"
  zip       = "13500-000"
}

module "user2" {
  source    = "./modules/userinfo"
  username  = "maria"
  full_name = "Maria Joaquina"
  address   = "Rua da Esquina, 99"
  city      = "Sao Paulo"
  state     = "SP"
  zip       = "04120-190"
}


# Crie um arquivo chamado "~/terraform/lab04/exe01/output.tf", com o seguinte conteúdo:
# 
# output "arquivo_saida_user1" {
#   value = "Arquivo result-${module.user1.username}.txt criado com sucesso."
# }
# 
# output "arquivo_saida_user2" {
#   value = "Arquivo result-${module.user2.username}.txt criado com sucesso."
# }


# Obtenha o arquivo "modules.tar.gz" disponível no repositório do exercício e descompacte, conforme abaixo:
# 
# tar xvf modules.tar.gz
#
# Verifique a estrutura dos arquivos, conforme abaixo:
# 
# $ ls -lR modules
# modules:
# total 4
# drwxrwxr-x 2 azureroot azureroot 4096 Oct 12 14:58 userinfo
# 
# modules/userinfo:
# total 12
# -rw-rw-r-- 1 azureroot azureroot 632 Oct 12 14:54 main.tf
# -rw-rw-r-- 1 azureroot azureroot 251 Oct 12 14:58 output.tf
# -rw-rw-r-- 1 azureroot azureroot 233 Oct 12 14:18 variables.tf


# Execute o comando abaixo para inicializar o diretório do terraform:
# 
# $ terraform init
# 
# Na sequência execute o comando abaixo para validar o plano de execução do terraform:
# 
# $ terraform plan
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
#   # module.user1.null_resource.userinfo will be created
#   + resource "null_resource" "userinfo" {
#       + id       = (known after apply)
#       + triggers = {
#           + "username" = "joao"
#         }
#     }
# 
#   # module.user2.null_resource.userinfo will be created
#   + resource "null_resource" "userinfo" {
#       + id       = (known after apply)
#       + triggers = {
#           + "username" = "maria"
#         }
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
# module.user2.null_resource.userinfo: Creating...
# module.user1.null_resource.userinfo: Creating...
# module.user2.null_resource.userinfo: Provisioning with 'local-exec'...
# module.user2.null_resource.userinfo (local-exec): Executing: ["/bin/sh" "-c" "echo maria > result-maria.txt"]
# module.user1.null_resource.userinfo: Provisioning with 'local-exec'...
# module.user1.null_resource.userinfo (local-exec): Executing: ["/bin/sh" "-c" "echo joao > result-joao.txt"]
# module.user2.null_resource.userinfo: Provisioning with 'local-exec'...
# module.user2.null_resource.userinfo (local-exec): Executing: ["/bin/sh" "-c" "echo Maria Joaquina >> result-maria.txt"]
# module.user1.null_resource.userinfo: Provisioning with 'local-exec'...
# module.user1.null_resource.userinfo (local-exec): Executing: ["/bin/sh" "-c" "echo Joao Manuel da Silva >> result-joao.txt"]
# module.user2.null_resource.userinfo: Provisioning with 'local-exec'...
# module.user2.null_resource.userinfo (local-exec): Executing: ["/bin/sh" "-c" "echo Rua da Esquina, 99 >> result-maria.txt"]
# module.user1.null_resource.userinfo: Provisioning with 'local-exec'...
# module.user1.null_resource.userinfo (local-exec): Executing: ["/bin/sh" "-c" "echo Rua das Orquideas, 100 >> result-joao.txt"]
# module.user2.null_resource.userinfo: Provisioning with 'local-exec'...
# module.user2.null_resource.userinfo (local-exec): Executing: ["/bin/sh" "-c" "echo Sao Paulo >> result-maria.txt"]
# module.user1.null_resource.userinfo: Provisioning with 'local-exec'...
# module.user1.null_resource.userinfo (local-exec): Executing: ["/bin/sh" "-c" "echo Belo Horizonte >> result-joao.txt"]
# module.user1.null_resource.userinfo: Provisioning with 'local-exec'...
# module.user2.null_resource.userinfo: Provisioning with 'local-exec'...
# module.user1.null_resource.userinfo (local-exec): Executing: ["/bin/sh" "-c" "echo MG >> result-joao.txt"]
# module.user2.null_resource.userinfo (local-exec): Executing: ["/bin/sh" "-c" "echo SP >> result-maria.txt"]
# module.user1.null_resource.userinfo: Provisioning with 'local-exec'...
# module.user1.null_resource.userinfo (local-exec): Executing: ["/bin/sh" "-c" "echo 13500-000 >> result-joao.txt"]
# module.user2.null_resource.userinfo: Provisioning with 'local-exec'...
# module.user2.null_resource.userinfo (local-exec): Executing: ["/bin/sh" "-c" "echo 04120-190 >> result-maria.txt"]
# module.user1.null_resource.userinfo: Creation complete after 0s [id=3113938443872069048]
# module.user2.null_resource.userinfo: Creation complete after 0s [id=1871131236478713477]
# 
# Apply complete! Resources: 2 added, 0 changed, 0 destroyed.


# Verifique que os arquivos "result-joao.txt" e "result-maria.txt" foram criados e analise o conteúdo, conforme abaixo:
# 
# $ cat result-joao.txt 
# joao
# Joao Manuel da Silva
# Rua das Orquideas, 100
# Belo Horizonte
# MG
# 13500-000
# 
# $ cat result-maria.txt 
# maria
# Maria Joaquina
# Rua da Esquina, 99
# Sao Paulo
# SP
# 04120-190


# Execute o comando "terraform destroy" para destruir o ambiente, conforme abaixo:
# 
# $ terraform destroy
# module.user1.null_resource.userinfo: Refreshing state... [id=3113938443872069048]
# module.user2.null_resource.userinfo: Refreshing state... [id=1871131236478713477]
# 
# Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
#   - destroy
# 
# Terraform will perform the following actions:
# 
#   # module.user1.null_resource.userinfo will be destroyed
#   - resource "null_resource" "userinfo" {
#       - id       = "3113938443872069048" -> null
#       - triggers = {
#           - "username" = "joao"
#         } -> null
#     }
# 
#   # module.user2.null_resource.userinfo will be destroyed
#   - resource "null_resource" "userinfo" {
#       - id       = "1871131236478713477" -> null
#       - triggers = {
#           - "username" = "maria"
#         } -> null
#     }
# 
# Plan: 0 to add, 0 to change, 2 to destroy.
# 
# Do you really want to destroy all resources?
#   Terraform will destroy all your managed infrastructure, as shown above.
#   There is no undo. Only 'yes' will be accepted to confirm.
# 
#   Enter a value: yes
# 
# module.user1.null_resource.userinfo: Destroying... [id=3113938443872069048]
# module.user2.null_resource.userinfo: Destroying... [id=1871131236478713477]
# module.user1.null_resource.userinfo: Provisioning with 'local-exec'...
# module.user2.null_resource.userinfo: Provisioning with 'local-exec'...
# module.user1.null_resource.userinfo (local-exec): Executing: ["/bin/sh" "-c" "rm -f result-joao.txt"]
# module.user2.null_resource.userinfo (local-exec): Executing: ["/bin/sh" "-c" "rm -f result-maria.txt"]
# module.user2.null_resource.userinfo: Destruction complete after 0s
# module.user1.null_resource.userinfo: Destruction complete after 0s
# 
# Destroy complete! Resources: 2 destroyed.


# Observe que os arquivos "result-joao.txt" e "result-maria.txt" foram excluídos corretamente. 

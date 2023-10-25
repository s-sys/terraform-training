# Lab02
# Atividade 2.5.
# 
# Defina uma variável chamada "users" no terraform para armazenar uma lista de
# usuários. Esta variável deve ser do tipo "list". Crie um arquivo "terraform.tfvars"
# para conter a definição das variáveis a serem lidas de forma automática pelo terraform.
# Crie uma variável local que concatene os elementos da variável "users" separando
# os elementos por vírgula. Ao final da execução do "terraform apply" o valor
# desta variável deve ser exibido na saída de execução.


# Crie um arquivo chamado "~/terraform/lab02/exe05/main.tf", com o seguinte conteúdo:

variable "users" {
  type = list(string)
}

locals {
  my_users = join(", ", var.users)
}

resource "null_resource" "local" {

  provisioner "local-exec" {
    command = "echo Usuários: ${local.my_users} > output.txt"
  }
}

output "my_users" {
  value = local.my_users
}

# Crie o arquivo "~/terraform/lab01/exe05/terraform.tfvars" com o seguinte conteúdo:
# 
# users = [
#   "joao",
#   "maria",
#   "lucas"
# ]


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


# Ao final da execução do comando "terraform apply", verifique o conteúdo do arquivo
# "utput.txt" gerado no mesmo diretório.
# 
# $ cat output.txt


# Verifique também a saída da execução do comando "terraform apply" contendo na seção
# "Output" o conteúdo da variável "my_users", conforme a seguir:
# 
# $ terraform apply
# 
# Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
#   + create
# 
# Terraform will perform the following actions:
# 
#   # null_resource.local will be created
#   + resource "null_resource" "local" {
#       + id = (known after apply)
#     }
# 
# Plan: 1 to add, 0 to change, 0 to destroy.
# 
# Changes to Outputs:
#   + my_users = "joao, maria, lucas"
# 
# Do you want to perform these actions?
#   Terraform will perform the actions described above.
#   Only 'yes' will be accepted to approve.
# 
#   Enter a value: yes
# 
# null_resource.local: Creating...
# null_resource.local: Provisioning with 'local-exec'...
# null_resource.local (local-exec): Executing: ["/bin/sh" "-c" "echo Usuários: joao, maria, lucas > output.txt"]
# null_resource.local: Creation complete after 0s [id=5844714635026405979]
# 
# Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
# 
# Outputs:
# 
# my_users = "joao, maria, lucas"


# Execute o comando "terraform output" para exibir todas as variáveis definidas como output.
# 
# $ terraform output
# my_users = "joao, maria, lucas"


# Execute o comando "terraform destroy" para desfazer todas as alterações.

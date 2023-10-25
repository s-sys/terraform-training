# Lab02
# Atividade 2.1.
# 
# Defina uma variável chamada "id_image" no terraform para armazenar o identificador da imagem de servidor a ser utilizada. Esta variável deve ser do tipo "string".


# Crie um arquivo chamado "~/terraform/lab02/exe01/main.tf", com o seguinte conteúdo:

variable "image_id" {
  type = string
}

resource "null_resource" "local" {

  provisioner "local-exec" {
    command = "echo ${var.image_id} > output.txt"
  }
}


# Execute o comando abaixo para inicializar o diretório do terraform:
# 
# $ terraform init
# 
# Initializing the backend...
# 
# Initializing provider plugins...
# - Finding latest version of hashicorp/null...
# - Installing hashicorp/null v3.2.1...
# - Installed hashicorp/null v3.2.1 (signed by HashiCorp)
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
# var.image_id
#   Enter a value: 


# Observe que será solicitado o valor para a variável var.image_id. Verifique que na definição da variável não foi definido um valor padrão, portanto o terraform solicitará a inserção do valor da variável durante o momento da execução. A variável pode ser digitada no prompt após a execução do comando "terraform plan" ou "terraform apply", ou diretamente pela linha de comando conforme exemplos abaixo:
# 
# Método 1:
# $ terraform plan -var image_id="ubuntu22-lts"
# 
# Método 2:
# $ export TF_VAR_image_id="ubuntu22-lts"
# $ terraform plan
# 
# Método 3:
# $ terraform plan -var-file=variables.tfvars


# A saída do comando "terraform plan" será exibida conforme a seguir:
# 
# Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following
# symbols:
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


# O mesmo processo de definição de variáveis também deve ser utilizado durante a execução do comando "terraform apply", conforme os exemplos abaixo:
# 
# Método 1:
# $ terraform apply -var image_id="ubuntu22-lts"
# 
# Método 2:
# $ export TF_VAR_image_id="ubuntu22-lts"
# $ terraform apply
# 
# Método 3:
# $ terraform apply -var-file=variables.tfvars


# A saída do comando "terraform apply" será exibida conforme a seguir:
# 
# Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following
# symbols:
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
# Do you want to perform these actions?
#   Terraform will perform the actions described above.
#   Only 'yes' will be accepted to approve.
# 
#   Enter a value: yes
# 
# null_resource.local: Creating...
# null_resource.local: Provisioning with 'local-exec'...
# null_resource.local (local-exec): Executing: ["/bin/sh" "-c" "echo ubuntu22-lts > output.txt"]
# null_resource.local: Creation complete after 0s [id=8484164384349941440]
# 
# Apply complete! Resources: 1 added, 0 changed, 0 destroyed.


# Ao final da execução do comando "terraform apply", verifique o conteúdo do arquivo output.txt gerado no mesmo diretório.
# 
# $ cat output.txt
# ubuntu22-lts

# Execute o comando "terraform destroy" para desfazer todas as alterações.
# Lembre-se que a definição da varíavel também se aplica.
# A saída do comando "terraform destroy" será exibida conforme a seguir:
# 
# null_resource.local: Refreshing state... [id=8484164384349941440]
# 
# Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following
# symbols:
#   - destroy
# 
# Terraform will perform the following actions:
# 
#   # null_resource.local will be destroyed
#   - resource "null_resource" "local" {
#       - id = "8484164384349941440" -> null
#     }
# 
# Plan: 0 to add, 0 to change, 1 to destroy.
# 
# Do you really want to destroy all resources?
#   Terraform will destroy all your managed infrastructure, as shown above.
#   There is no undo. Only 'yes' will be accepted to confirm.
# 
#   Enter a value: yes
# 
# null_resource.local: Destroying... [id=8484164384349941440]
# null_resource.local: Destruction complete after 0s
# 
# Destroy complete! Resources: 1 destroyed.

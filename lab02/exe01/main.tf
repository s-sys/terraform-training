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
# Na sequência execute o comando abaixo para validar o plano de execução do terraform:
# 
# $ terraform plan
# var.image_id
#   Enter a value: 


# Observe que será solicitado o valor para a variável var.image_id. Verifique que na definição da variável não foi definido um valor padrão, portanto o terraform solicitará a inserção do valor da variável durante o momento da execução. A variável pode ser digitada no prompt após a execução do comando "terraform plan" ou "terraform apply", ou diretamente pela linha de comando conforme exemplos abaixo:
# 
# Método 1:
# $ terraform plan -var image_id="ubuntu20-lts"
# 
# Método 2:
# $ export TF_VAR_image_id="ubuntu20-lts"
# $ terraform plan
# 
# Método 3:
# $ terraform plan -var-file=variables.tfvars


# O mesmo processo de definição de variáveis também deve ser utilizado durante a execução do comando "terraform apply", conforme os exemplos abaixo:
# 
# Método 1:
# $ terraform apply -var image_id="ubuntu20-lts"
# 
# Método 2:
# $ export TF_VAR_image_id="ubuntu20-lts"
# $ terraform apply
# 
# Método 3:
# $ terraform apply -var-file=variables.tfvars


# Ao final da execução do comando "terraform apply", verifique o conteúdo do arquivo output.txt gerado no mesmo diretório.
# 
# $ cat output.txt


# Execute o comando "terraform destroy" para desfazer todas as alterações.

# Lab02
# Atividade 2.2.
# 
# Defina uma variável chamada "region" no terraform para armazenar o identificador da região onde um servidor será instanciado. Esta variável deve ser do tipo "string" e possuir um valor padrão de "centralus". Crie também uma variável chamada "names" do tipo "list", para armazenar uma lista de nomes permitidos para a máquina e defina uma lista de nomes de sua escolha.


# Crie um arquivo chamado "~/terraform/lab02/exe02/main.tf", com o seguinte conteúdo:

variable "region" {
  type    = string
  default = "centralus"
}

variable "names" {
  type    = list(string)
  default = ["tucana", "andromeda", "triangulum"]
}

resource "null_resource" "local" {

  provisioner "local-exec" {
    command = "echo ${var.region} > output.txt"
  }

  provisioner "local-exec" {
    command = "echo ${join(", ", var.names)} >> output.txt"
  }
}


# Execute o comando abaixo para inicializar o diretório do terraform:
# 
# $ terraform init
# 
# Na sequência execute o comando abaixo para validar o plano de execução do terraform:
# 
# $ terraform plan


# Observe que não será solicitado o valor para as variáveis "region" e "names". Este comportamento ocorreu pois as variáveis tiveram valores padrões definidos durante a sua declaração. Caso os valores não sejam adequados, será necessário utilizar algum dos métodos abaixo para alterar seus valores:
# 
# Método 1:
# $ terraform plan -var region="westus" -var names='["terra", "marte", "jupiter", "saturno"]'
# 
# Método 2:
# $ export TF_VAR_region="westus"
# $ export TF_VAR_names='["marte", "jupiter", "saturno"]'
# $ terraform plan
# 
# Método 3:
# $ terraform plan -var-file=variables.tfvars


# O mesmo processo de definição de variáveis também deve ser utilizado durante a execução do comando "terraform apply", conforme os exemplos abaixo:
# 
# Método 1:
# $ terraform apply -var region="westus" -var names='["terra", "marte", "jupiter", "saturno"]'
# 
# Método 2:
# $ export TF_VAR_region="westus"
# $ export TF_VAR_names='["marte", "jupiter", "saturno"]'
# $ terraform apply
# 
# Método 3:
# $ terraform apply -var-file=variables.tfvars


# Ao final da execução do comando "terraform apply", verifique o conteúdo do arquivo output.txt gerado no mesmo diretório.
# 
# $ cat output.txt


# Execute o comando "terraform destroy" para desfazer todas as alterações.

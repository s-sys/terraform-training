# Lab02
# Atividade 2.4.
# 
# Defina uma variável chamada "user_info" no terraform para armazenar dados de um usuário, como por exemplo nome de usuário, nome completo, endereço, cidade, estado e CEP. Esta variável deve ser do tipo "object" e cada um dos dados do usuário deve ter seu tipo ajustado de acordo com a informação a ser armazenada. Crie uma validação para permitir a definição apenas de usuários que residam no estado de Minas Gerais (MG).


# Crie um arquivo chamado "~/terraform/lab02/exe04/main.tf", com o seguinte conteúdo:

variable "user_info" {
  type    = object({
    username     = string
    full_name    = string
    full_address = string
    city         = string
    state        = string
    zip          = string
  })

  validation {
    condition     = var.user_info.state == "MG"
    error_message = "Usuário não é de Minas Gerais."
  }
}

resource "null_resource" "local" {

  provisioner "local-exec" {
    command = "echo Informações do usuário: ${jsonencode(var.user_info)} > output.txt"
  }
}


# Crie o arquivo "~/terraform/lab01/exe04/variables.tfvars" com o seguinte conteúdo:
# 
# user_info = {
#   username     = "joao"
#   full_name    = "João Manuel"
#   full_address = "Rua Desconhecida, 100"
#   city         = "Belo Horizonte"
#   state        = "MG"
#   zip          = "13255-000"
# }


# Execute o comando abaixo para inicializar o diretório do terraform:
# 
# $ terraform init
# 
# Na sequência execute o comando abaixo para validar o plano de execução do terraform:
# 
# $ terraform plan -var-file=variables.tfvars
# 
# Em seguida execute o comando abaixo para aplicar a configuração do terraform:
# 
# $ terraform apply -var-file=variables.tfvars


# Ao final da execução do comando "terraform apply", verifique o conteúdo do arquivo output.txt gerado no mesmo diretório.
# 
# $ cat output.txt


# Execute o comando "terraform destroy" para desfazer todas as alterações.


# Faça a alteração do campo "state" no arquivo "variables.tfvars" para "SP", execute o processo novamente e observe o resultado.

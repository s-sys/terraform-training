# Lab02
# Atividade 2.3.
# 
# Defina uma variável chamada "username" no terraform para armazenar o nome de um usuário de aplicação. Esta variável deve ser do tipo "string" e não pode conter mais do que 10 caracteres. Crie também uma variável chamada "password" do tipo "string", para armazenar a senha do usuário da aplicação. Esta senha deve ser definida como sensível para que seu conteúdo não seja exibido no plano de execução do terraform.


# Crie um arquivo chamado "~/terraform/lab02/exe03/main.tf", com o seguinte conteúdo:

variable "username" {
  type    = string
  default = "user01"

  validation {
    condition     = length(var.username) <= 10
    error_message = "Nome de usuário maior que 10 caracteres não é suportado."
  }
}

variable "password" {
  type      = string
  sensitive = true
}

resource "null_resource" "local" {

  provisioner "local-exec" {
    command = "echo Usuário: ${var.username} > output.txt"
  }

  provisioner "local-exec" {
    command = "echo Senha: ${var.password} >> output.txt"
  }
}


# Execute o comando abaixo para inicializar o diretório do terraform:
# 
# $ terraform init
# 
# Na sequência execute o comando abaixo para validar o plano de execução do terraform:
# 
# $ terraform plan


# Observe que será solicitado o valor para a variável var.password. Verifique que na definição da variável não foi definido um valor padrão, portanto o terraform solicitará a inserção do valor da variável durante o momento da execução. A variável pode ser digitada no prompt após a execução do comando "terraform plan" ou "terraform apply", ou diretamente pela linha de comando conforme exemplos abaixo:
# 
# Método 1:
# $ terraform apply -var username="JoaoManuelDaSilva" -var password="Password@123"
# 
# Método 2:
# $ export TF_VAR_username="JoaoManuelDaSilva"
# $ export TF_VAR_password="Password@123"
# $ terraform plan
# 
# Método 3:
# $ terraform plan -var-file=variables.tfvars


# Após a execução do comando "terraform plan" com as opções acima, a seguinte mensagem foi exibida:
# 
# $ terraform plan -var username="JoaoManuelDaSilva" -var password="Password@123"
# ╷
# │ Error: Invalid value for variable
# │ 
# │   on main.tf line 1:
# │    1: variable "username" {
# │ 
# │ Nome de usuário maior que 10 caracteres não é suportado.
# │ 
# │ This was checked by the validation rule at main.tf:5,3-13.
# ╵
# 
# Isto ocorreu devido a validação implementada na variável que não permite que a variável var.username possua mais do que 10 caracteres. Faça a correção definindo o valor da variável para "JoaoManuel" e repita o processo.


# O mesmo processo de definição de variáveis também deve ser utilizado durante a execução do comando "terraform apply", conforme os exemplos abaixo:
# 
# Método 1:
# $ terraform apply -var username="JoaoManuel" -var password="Password@123"
# 
# Método 2:
# $ export TF_VAR_username="JoaoManuel"
# $ export TF_VAR_password="Password@123"
# $ terraform apply
# 
# Método 3:
# $ terraform apply -var-file=variables.tfvars


# Ao final da execução do comando "terraform apply", verifique o conteúdo do arquivo output.txt gerado no mesmo diretório. Observe que a saída do comando "terraform apply" não exibiu a senha na saída do console. Isto ocorreu devido a presenção do parâmetro "sensitive = true" na definição da variável.
# 
# $ cat output.txt


# Execute o comando "terraform destroy" para desfazer todas as alterações.

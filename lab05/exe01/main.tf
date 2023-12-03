# Lab05
# Atividade 5.1.
# 
# Crie uma automação em terraform, que utilize um módulo customizado para a criação
# de um banco de dados MySQL e realize algumas validações, conforme a seguir:
#   - O banco de dados deve ter seu nome iniciados em "DB-". Qualquer banco que
#       não tenha este prefixo deverá ter o mesmo adicionado automaticamente pela automação.
#   - O nome do banco de dados deve ser sempre em maiúsculo e não pode conter mais
#       do que 14 caracteres, sendo truncado automaticamente caso exceda este tamanho.
#   - O nome de usuário deve ser iniciado com "u-". Qualquer usuário que não tenha
#       este prefixo deverá ser corrigido automaticamente pela automação.
#   - O nome do usuário não pode ter mais que 14 caracteres e caracteres em 
#       branco " " devem ser substituidos por underline ("_").
#   - O nome do usuário deve ser sempre em minúsculo.
#   - A senha do usuário deve ser gerada automaticamente e aleatoriamente e deve
#        conter 10 caracteres e possuir caracteres maiúsculos, minúsculos e números.


# Crie um arquivo chamado "~/terraform/lab05/exe01/main.tf", com o seguinte conteúdo:


module "mysql" {
  source   = "./modules/mysql"
  user     = var.user
  database = var.database
}


# Crie um arquivo chamado "~/terraform/lab05/exe01/variables.tf", com o seguinte conteúdo:
# 
# variable "user" {
#   type = string
# }
# 
# variable "database" {
#   type = string
# }


# Crie um arquivo chamado "~/terraform/lab05/exe01/output.tf", com o seguinte conteúdo:
# 
# output "user" {
#   value     = "Username: ${module.mysql.user}"
# }
# 
# output "database" {
#   value     = "Database: ${module.mysql.database}"
# }
# 
# output "password" {
#   value     = "Password: ${module.mysql.password}"
#   sensitive = true
# }


# Crie um arquivo chamado "~/terraform/lab05/exe01/terraform.tfvars", com o seguinte conteúdo:
# 
# user     = "maria"
# database = "my_data"


# Obtenha o arquivo "modules.tar.gz" disponível no repositório do exercício e descompacte,
# conforme abaixo:
# 
# tar xvf modules.tar.gz
#
# Verifique a estrutura dos arquivos, conforme abaixo:
# 
# $ ls -lR modules
modules:
# total 0
# drwxr-xr-x 2 azureroot users 58 Oct 15  2021 mysql
# 
# modules/mysql:
# total 12
# -rw-r--r-- 1 azureroot users 1306 Oct 15  2021 main.tf
# -rw-r--r-- 1 azureroot users  134 Oct 14  2021 output.tf
# -rw-r--r-- 1 azureroot users   77 Oct 14  2021 variables.tf


# Observe o arquivo "~/terraform/lab05/exe01/modules/mysql/main.tf", no bloco de definição
# das variáveis locais, conforme abaixo:
# 
# locals {
#   db_name  = (
#                upper(substr(var.database, 0, 3)) == "DB-"
#                ? substr(upper(var.database), 0, 14)
#                : substr(upper("DB-${var.database}"), 0, 14)
#              )
#   user     = (
#                lower(substr(var.user, 0, 2)) == "u-"
#                ? replace(substr(lower(var.user), 0, 14), " ", "_")
#                : replace(substr(lower("u-${var.user}"), 0, 14), " ", "_")
#              )
#   password = random_password.password.result
# }
# 
# resource "random_password" "password" {
#   length      = 10
#   min_lower   = 1
#   min_numeric = 1
#   min_upper   = 1
#   lower       = true
#   upper       = true
#   number      = true
#   special     = false
# 
# }
# 
# Analise as expressões utilizadas para atender aos requisitos do exercício e valide
# se todas as condições estão atendidas.


# Execute o comando abaixo para inicializar o diretório do terraform:
# 
# $ terraform init
# 
# Initializing the backend...
# Initializing modules...
# - mysql in modules/mysql
# 
# Initializing provider plugins...
# - Finding winebarrel/mysql versions matching "~> 1.10.6"...
# - Finding latest version of hashicorp/random...
# - Installing winebarrel/mysql v1.10.6...
# - Installed winebarrel/mysql v1.10.6 (self-signed, key ID 879D0138295C4E40)
# - Installing hashicorp/random v3.5.1...
# - Installed hashicorp/random v3.5.1 (signed by HashiCorp)
# 
# Partner and community providers are signed by their developers.
# If you'd like to know more about provider signing, you can read about it here:
# https://www.terraform.io/docs/cli/plugins/signing.html
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
# 
# Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
#   + create
# 
# Terraform will perform the following actions:
# 
#   # module.mysql.mysql_database.database will be created
#   + resource "mysql_database" "database" {
#       + default_character_set = "utf8"
#       + default_collation     = "utf8_general_ci"
#       + id                    = (known after apply)
#       + name                  = "DB-MY_DATA"
#     }
# 
#   # module.mysql.mysql_grant.grant will be created
#   + resource "mysql_grant" "grant" {
#       + database   = "DB-MY_DATA"
#       + grant      = false
#       + host       = "%"
#       + id         = (known after apply)
#       + privileges = [
#           + "ALL",
#         ]
#       + table      = "*"
#       + tls_option = "NONE"
#       + user       = "u-maria"
#     }
# 
#   # module.mysql.mysql_user.user will be created
#   + resource "mysql_user" "user" {
#       + host               = "%"
#       + id                 = (known after apply)
#       + plaintext_password = (sensitive value)
#       + tls_option         = "NONE"
#       + user               = "u-maria"
#     }
# 
#   # module.mysql.random_password.password will be created
#   + resource "random_password" "password" {
#       + bcrypt_hash = (sensitive value)
#       + id          = (known after apply)
#       + length      = 10
#       + lower       = true
#       + min_lower   = 1
#       + min_numeric = 1
#       + min_special = 0
#       + min_upper   = 1
#       + number      = true
#       + numeric     = true
#       + result      = (sensitive value)
#       + special     = false
#       + upper       = true
#     }
# 
# Plan: 4 to add, 0 to change, 0 to destroy.
# 
# Changes to Outputs:
#   + database = "Database: DB-MY_DATA"
#   + password = (sensitive value)
#   + user     = "Username: u-maria"
# ╷
# │ Warning: Attribute Deprecated
# │
# │   with module.mysql.random_password.password,
# │   on modules/mysql/main.tf line 42, in resource "random_password" "password":
# │   42:   number  = true
# │
# │ **NOTE**: This is deprecated, use `numeric` instead.
# │
# │ (and one more similar warning elsewhere)
# ╵
# 
# ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
# 
# Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply"
# now.


# Em seguida execute o comando abaixo para aplicar a configuração do terraform:
# 
# $ terraform apply
# 
# Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
#   + create
# 
# Terraform will perform the following actions:
# 
#   # module.mysql.mysql_database.database will be created
#   + resource "mysql_database" "database" {
#       + default_character_set = "utf8"
#       + default_collation     = "utf8_general_ci"
#       + id                    = (known after apply)
#       + name                  = "DB-MY_DATA"
#     }
# 
#   # module.mysql.mysql_grant.grant will be created
#   + resource "mysql_grant" "grant" {
#       + database   = "DB-MY_DATA"
#       + grant      = false
#       + host       = "%"
#       + id         = (known after apply)
#       + privileges = [
#           + "ALL",
#         ]
#       + table      = "*"
#       + tls_option = "NONE"
#       + user       = "u-maria"
#     }
# 
#   # module.mysql.mysql_user.user will be created
#   + resource "mysql_user" "user" {
#       + host               = "%"
#       + id                 = (known after apply)
#       + plaintext_password = (sensitive value)
#       + tls_option         = "NONE"
#       + user               = "u-maria"
#     }
# 
#   # module.mysql.random_password.password will be created
#   + resource "random_password" "password" {
#       + bcrypt_hash = (sensitive value)
#       + id          = (known after apply)
#       + length      = 10
#       + lower       = true
#       + min_lower   = 1
#       + min_numeric = 1
#       + min_special = 0
#       + min_upper   = 1
#       + number      = true
#       + numeric     = true
#       + result      = (sensitive value)
#       + special     = false
#       + upper       = true
#     }
# 
# Plan: 4 to add, 0 to change, 0 to destroy.
# 
# Changes to Outputs:
#   + database = "Database: DB-MY_DATA"
#   + password = (sensitive value)
#   + user     = "Username: u-maria"
# 
# Do you want to perform these actions?
#   Terraform will perform the actions described above.
#   Only 'yes' will be accepted to approve.
# 
#   Enter a value: yes
# 
# module.mysql.mysql_database.database: Creating...
# module.mysql.random_password.password: Creating...
# module.mysql.mysql_database.database: Creation complete after 0s [id=DB-MY_DATA]
# module.mysql.random_password.password: Creation complete after 0s [id=none]
# module.mysql.mysql_user.user: Creating...
# module.mysql.mysql_user.user: Creation complete after 0s [id=u-maria@%]
# module.mysql.mysql_grant.grant: Creating...
# module.mysql.mysql_grant.grant: Creation complete after 0s [id=u-maria@%:`DB-MY_DATA`]
# 
# Apply complete! Resources: 4 added, 0 changed, 0 destroyed.
# 
# Outputs:
# 
# database = "Database: DB-MY_DATA"
# password = <sensitive>
# user = "Username: u-maria"


# Observe que a senha não foi exibida diretamente por estar classificada como sensível.
# Para exibir a senha utilize o comando abaixo:
# 
# $ terraform output password
# "Password: Qb3K4GD4No"


# Verifique se a conexão com o banco de dados MySQL está funcionando corretamente com
# o usuário "u-maria", e valide se o banco de dados "DB-MY_DATA" foi criado com sucesso,
# conforme abaixo:
# 
# $ mysql -h 192.168.1.13 -u u-maria -p
# Enter password:
# Welcome to the MariaDB monitor.  Commands end with ; or \g.
# Your MariaDB connection id is 42
# Server version: 10.6.12-MariaDB-0ubuntu0.22.04.1 Ubuntu 22.04
# 
# Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.
# 
# Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.
# 
# MariaDB [(none)]> show databases;
# +--------------------+
# | Database           |
# +--------------------+
# | DB-MY_DATA         |
# | information_schema |
# +--------------------+
# 2 rows in set (0.002 sec)
# 
# MariaDB [(none)]> ^DBye


# Execute o comando "terraform destroy" para destruir o ambiente, conforme abaixo:
# 
# $ terraform destroy
# module.mysql.random_password.password: Refreshing state... [id=none]
# module.mysql.mysql_database.database: Refreshing state... [id=DB-MY_DATA]
# module.mysql.mysql_user.user: Refreshing state... [id=u-maria@%]
# module.mysql.mysql_grant.grant: Refreshing state... [id=u-maria@%:`DB-MY_DATA`]
# 
# Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
#   - destroy
# 
# Terraform will perform the following actions:
# 
#   # module.mysql.mysql_database.database will be destroyed
#   - resource "mysql_database" "database" {
#       - default_character_set = "utf8mb3" -> null
#       - default_collation     = "utf8mb3_general_ci" -> null
#       - id                    = "DB-MY_DATA" -> null
#       - name                  = "DB-MY_DATA" -> null
#     }
# 
#   # module.mysql.mysql_grant.grant will be destroyed
#   - resource "mysql_grant" "grant" {
#       - database   = "DB-MY_DATA" -> null
#       - grant      = false -> null
#       - host       = "%" -> null
#       - id         = "u-maria@%:`DB-MY_DATA`" -> null
#       - privileges = [
#           - "ALL PRIVILEGES",
#         ] -> null
#       - table      = "*" -> null
#       - tls_option = "NONE" -> null
#       - user       = "u-maria" -> null
#     }
# 
#   # module.mysql.mysql_user.user will be destroyed
#   - resource "mysql_user" "user" {
#       - host               = "%" -> null
#       - id                 = "u-maria@%" -> null
#       - plaintext_password = (sensitive value) -> null
#       - tls_option         = "NONE" -> null
#       - user               = "u-maria" -> null
#     }
# 
#   # module.mysql.random_password.password will be destroyed
#   - resource "random_password" "password" {
#       - bcrypt_hash = (sensitive value) -> null
#       - id          = "none" -> null
#       - length      = 10 -> null
#       - lower       = true -> null
#       - min_lower   = 1 -> null
#       - min_numeric = 1 -> null
#       - min_special = 0 -> null
#       - min_upper   = 1 -> null
#       - number      = true -> null
#       - numeric     = true -> null
#       - result      = (sensitive value) -> null
#       - special     = false -> null
#       - upper       = true -> null
#     }
# 
# Plan: 0 to add, 0 to change, 4 to destroy.
# 
# Changes to Outputs:
#   - database = "Database: DB-MY_DATA" -> null
#   - password = (sensitive value) -> null
#   - user     = "Username: u-maria" -> null
# 
# Do you really want to destroy all resources?
#   Terraform will destroy all your managed infrastructure, as shown above.
#   There is no undo. Only 'yes' will be accepted to confirm.
# 
#   Enter a value: yes
# 
# module.mysql.mysql_grant.grant: Destroying... [id=u-maria@%:`DB-MY_DATA`]
# module.mysql.mysql_grant.grant: Destruction complete after 0s
# module.mysql.mysql_database.database: Destroying... [id=DB-MY_DATA]
# module.mysql.mysql_user.user: Destroying... [id=u-maria@%]
# module.mysql.mysql_user.user: Destruction complete after 0s
# module.mysql.mysql_database.database: Destruction complete after 0s
# module.mysql.random_password.password: Destroying... [id=none]
# module.mysql.random_password.password: Destruction complete after 0s
# 
# Destroy complete! Resources: 4 destroyed.

# Lab05
# Atividade 5.1.
# 
# Crie uma automação em terraform, que utilize um módulo customizado para a criação de um banco de dados MySQL e realize algumas validações, conforme a seguir:
#   - O banco de dados deve ter seu nome iniciados em "DB-". Qualquer banco que não tenha este prefixo deverá ter o mesmo adicionado automaticamente pela automação.
#   - O nome do banco de dados deve ser sempre em maiúsculo e não pode conter mais do que 14 caracteres, sendo truncado automaticamente caso exceda este tamanho.
#   - O nome de usuário deve ser iniciado com "u-". Qualquer usuário que não tenha este prefixo deverá ser corrigido automaticamente pela automação.
#   - O nome do usuário não pode ter mais que 14 caracteres e caracteres em branco " " devem ser substituidos por underline ("_").
#   - O nome do usuário deve ser sempre em minúsculo.
#   - A senha do usuário deve ser gerada automaticamente e aleatoriamente e deve conter 10 caracteres e possuir caracteres maiúsculos, minúsculos e números.


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


# Crie um arquivo chamado "~/terraform/lab05/exe01/terraform.tfvars", com o seguinte conteúdo:
# 
# user     = "maria"
# database = "my_data"


# Obtenha o arquivo "modules.tar.gz" disponível no repositório do exercício e descompacte, conforme abaixo:
# 
# tar xvf modules.tar.gz
#
# Verifique a estrutura dos arquivos, conforme abaixo:
# 
# $ ls -lR modules
# modules/:
# total 4
# drwxrwxr-x 2 azureroot azureroot 4096 Oct 14 22:51 mysql
# 
# modules/mysql:
# total 12
# -rw-rw-r-- 1 azureroot azureroot 1307 Oct 14 22:51 main.tf
# -rw-rw-r-- 1 azureroot azureroot  134 Oct 14 22:16 output.tf
# -rw-rw-r-- 1 azureroot azureroot   77 Oct 14 22:04 variables.tf


# Observe o arquivo "~/terraform/lab05/exe01/modules/mysql/main.tf", no bloco de definição das variáveis locais, conforme abaixo:
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
# Analise as expressões utilizadas para atender aos requisitos do exercício e valide se todas as condições estão atendidas.


# Execute o comando abaixo para inicializar o diretório do terraform:
# 
# $ terraform init
# 
# Initializing modules...
# - mysql in modules/mysql
# 
# Initializing the backend...
# 
# Initializing provider plugins...
# - Finding latest version of hashicorp/random...
# - Finding winebarrel/mysql versions matching "~> 1.10.6"...
# - Installing hashicorp/random v3.1.0...
# - Installed hashicorp/random v3.1.0 (signed by HashiCorp)
# - Installing winebarrel/mysql v1.10.6...
# - Installed winebarrel/mysql v1.10.6 (self-signed, key ID 879D0138295C4E40)
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
#       + id          = (known after apply)
#       + length      = 10
#       + lower       = true
#       + min_lower   = 1
#       + min_numeric = 1
#       + min_special = 0
#       + min_upper   = 1
#       + number      = true
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
# ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
# 
# Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.


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
#       + id          = (known after apply)
#       + length      = 10
#       + lower       = true
#       + min_lower   = 1
#       + min_numeric = 1
#       + min_special = 0
#       + min_upper   = 1
#       + number      = true
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
# module.mysql.random_password.password: Creating...
# module.mysql.mysql_database.database: Creating...
# module.mysql.random_password.password: Creation complete after 0s [id=none]
# module.mysql.mysql_database.database: Creation complete after 0s [id=DB-MY_DATA]
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


# Observe que a senha não foi exibida diretamente por estar classificada como sensível. Para exibir a senha utilize o comando abaixo:
# 
# $ terraform output password
# "Password: 7UvyAHiBso"


# Verifique se a conexão com o banco de dados MySQL está funcionando corretamente com o usuário "u-maria", e valide se o banco de dados "DB-MY_DATA" foi criado com sucesso, conforme abaixo:
# 
# $ mysql -h 192.168.1.13 -u u-maria -p
# Enter password: 
# Welcome to the MySQL monitor.  Commands end with ; or \g.
# Your MySQL connection id is 83
# Server version: 5.5.5-10.6.4-MariaDB-1:10.6.4+maria~focal mariadb.org binary distribution
# 
# Copyright (c) 2000, 2021, Oracle and/or its affiliates.
# 
# Oracle is a registered trademark of Oracle Corporation and/or its
# affiliates. Other names may be trademarks of their respective
# owners.
# 
# Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.
# 
# mysql> show databases;
# +--------------------+
# | Database           |
# +--------------------+
# | DB-MY_DATA         |
# | information_schema |
# +--------------------+
# 2 rows in set (0.00 sec)
# 
# mysql> ^DBye


# Execute o comando "terraform destroy" para destruir o ambiente, conforme abaixo:
# 
# $ terraform destroy 
# 
# module.mysql.mysql_database.database: Refreshing state... [id=DB-MY_DATA]
# module.mysql.random_password.password: Refreshing state... [id=none]
# module.mysql.mysql_user.user: Refreshing state... [id=u-maria@%]
# module.mysql.mysql_grant.grant: Refreshing state... [id=u-maria@%:`DB-MY_DATA`]
# 
# Note: Objects have changed outside of Terraform
# 
# Terraform detected the following changes made outside of Terraform since the last "terraform apply":
# 
#   # module.mysql.mysql_grant.grant has been changed
#   ~ resource "mysql_grant" "grant" {
#         id         = "u-maria@%:`DB-MY_DATA`"
#       ~ privileges = [
#           - "ALL",
#           + "ALL PRIVILEGES",
#         ]
#         # (6 unchanged attributes hidden)
#     }
# 
# Unless you have made equivalent changes to your configuration, or ignored the relevant attributes using ignore_changes, the following plan may
# include actions to undo or respond to these changes.
# 
# ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
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
#       - plaintext_password = (sensitive value)
#       - tls_option         = "NONE" -> null
#       - user               = "u-maria" -> null
#     }
# 
#   # module.mysql.random_password.password will be destroyed
#   - resource "random_password" "password" {
#       - id          = "none" -> null
#       - length      = 10 -> null
#       - lower       = true -> null
#       - min_lower   = 1 -> null
#       - min_numeric = 1 -> null
#       - min_special = 0 -> null
#       - min_upper   = 1 -> null
#       - number      = true -> null
#       - result      = (sensitive value)
#       - special     = false -> null
#       - upper       = true -> null
#     }
# 
# Plan: 0 to add, 0 to change, 4 to destroy.
# 
# Changes to Outputs:
#   - database = "Database: DB-MY_DATA" -> null
#   - password = (sensitive value)
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

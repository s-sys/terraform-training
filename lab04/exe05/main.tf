# Lab04
# Atividade 4.5.
# 
# Crie uma automação em terraform que utilize um módulo em terraform para a criação
# de de um banco de dados e usuário em MySQL. Utilize como referência o conteúdo do
# exercício 4.2. Os valores das variáveis devem ser definidos em um arquivo
# "terraform.tfvars" e a senha deve ser gerada de forma aleatória e exibida na
# saída da execução.


# Crie um arquivo chamado "~/terraform/lab04/exe05/main.tf", com o seguinte conteúdo:

module "mysql" {
  source   = "./modules/mysql"
  user     = var.user
  database = var.database
}


# Crie um arquivo chamado "~/terraform/lab04/exe05/variables.tf", com o seguinte conteúdo:
# 
# variable "user" {
#   type = string
# }
# 
# variable "database" {
#   type = string
# }


# Crie um arquivo chamado "~/terraform/lab04/exe05/terraform.tfvars", com o seguinte conteúdo:
# 
# user     = "maria"
# database = "my_data"


# Crie um arquivo chamado "~/terraform/lab04/exe05/output.tfvars", com o seguinte conteúdo:
#
# output "password" {
#   value     = "Password: ${module.mysql.password}"
#   sensitive = true
# }


# Obtenha o arquivo "modules.tar.gz" disponível no repositório do exercício e descompacte,
# conforme abaixo:
# 
# tar xvf modules.tar.gz
#
# Verifique a estrutura dos arquivos, conforme abaixo:
# 
# $ ls -lR modules
# modules:
# total 4
# drwxrwxr-x 2 azureroot azureroot 4096 Oct 14 11:46 mysql
# 
# modules/mysql:
# total 12
# -rw-rw-r-- 1 azureroot azureroot 730 Oct 14 11:23 main.tf
# -rw-rw-r-- 1 azureroot azureroot  64 Oct 14 11:46 output.tf
# -rw-rw-r-- 1 azureroot azureroot  77 Oct 14 11:43 variables.tf


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
#       + name                  = "my_data"
#     }
# 
#   # module.mysql.mysql_grant.grant will be created
#   + resource "mysql_grant" "grant" {
#       + database   = "my_data"
#       + grant      = false
#       + host       = "%"
#       + id         = (known after apply)
#       + privileges = [
#           + "ALL",
#         ]
#       + table      = "*"
#       + tls_option = "NONE"
#       + user       = "maria"
#     }
# 
#   # module.mysql.mysql_user.user will be created
#   + resource "mysql_user" "user" {
#       + host               = "%"
#       + id                 = (known after apply)
#       + plaintext_password = (sensitive value)
#       + tls_option         = "NONE"
#       + user               = "maria"
#     }
# 
#   # module.mysql.random_password.password will be created
#   + resource "random_password" "password" {
#       + bcrypt_hash = (sensitive value)
#       + id          = (known after apply)
#       + length      = 10
#       + lower       = true
#       + min_lower   = 0
#       + min_numeric = 0
#       + min_special = 0
#       + min_upper   = 0
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
#   + password = (sensitive value)
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
#       + name                  = "my_data"
#     }
# 
#   # module.mysql.mysql_grant.grant will be created
#   + resource "mysql_grant" "grant" {
#       + database   = "my_data"
#       + grant      = false
#       + host       = "%"
#       + id         = (known after apply)
#       + privileges = [
#           + "ALL",
#         ]
#       + table      = "*"
#       + tls_option = "NONE"
#       + user       = "maria"
#     }
# 
#   # module.mysql.mysql_user.user will be created
#   + resource "mysql_user" "user" {
#       + host               = "%"
#       + id                 = (known after apply)
#       + plaintext_password = (sensitive value)
#       + tls_option         = "NONE"
#       + user               = "maria"
#     }
# 
#   # module.mysql.random_password.password will be created
#   + resource "random_password" "password" {
#       + bcrypt_hash = (sensitive value)
#       + id          = (known after apply)
#       + length      = 10
#       + lower       = true
#       + min_lower   = 0
#       + min_numeric = 0
#       + min_special = 0
#       + min_upper   = 0
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
#   + password = (sensitive value)
# 
# Do you want to perform these actions?
#   Terraform will perform the actions described above.
#   Only 'yes' will be accepted to approve.
# 
#   Enter a value: yes
# 
# module.mysql.mysql_database.database: Creating...
# module.mysql.random_password.password: Creating...
# module.mysql.mysql_database.database: Creation complete after 0s [id=my_data]
# module.mysql.random_password.password: Creation complete after 0s [id=none]
# module.mysql.mysql_user.user: Creating...
# module.mysql.mysql_user.user: Creation complete after 0s [id=maria@%]
# module.mysql.mysql_grant.grant: Creating...
# module.mysql.mysql_grant.grant: Creation complete after 0s [id=maria@%:`my_data`]
# 
# Apply complete! Resources: 4 added, 0 changed, 0 destroyed.
# 
# Outputs:
# 
# password = <sensitive>


# Observe que a senha não foi exibida diretamente por estar classificada como
# sensível. Para exibir a senha utilize o comando abaixo:
# 
# $ terraform output password
# "Password: oWKuINtlMw"


# Verifique se a conexão com o banco de dados MySQL está funcionando corretamente
# com o usuário "maria", e valide se o banco de dados "my_data" foi criado com
# sucesso, conforme abaixo:
# 
# $ mysql -h 192.168.1.13 -u maria -p
# Enter password:
# Welcome to the MariaDB monitor.  Commands end with ; or \g.
# Your MariaDB connection id is 32
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
# | information_schema |
# | my_data            |
# +--------------------+
# 2 rows in set (0.002 sec)
# 
# MariaDB [(none)]> ^DBye


# Execute o comando "terraform destroy" para destruir o ambiente, conforme abaixo:
# 
# $ terraform destroy
# module.mysql.mysql_database.database: Refreshing state... [id=my_data]
# module.mysql.random_password.password: Refreshing state... [id=none]
# module.mysql.mysql_user.user: Refreshing state... [id=maria@%]
# module.mysql.mysql_grant.grant: Refreshing state... [id=maria@%:`my_data`]
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
#       - id                    = "my_data" -> null
#       - name                  = "my_data" -> null
#     }
# 
#   # module.mysql.mysql_grant.grant will be destroyed
#   - resource "mysql_grant" "grant" {
#       - database   = "my_data" -> null
#       - grant      = false -> null
#       - host       = "%" -> null
#       - id         = "maria@%:`my_data`" -> null
#       - privileges = [
#           - "ALL PRIVILEGES",
#         ] -> null
#       - table      = "*" -> null
#       - tls_option = "NONE" -> null
#       - user       = "maria" -> null
#     }
# 
#   # module.mysql.mysql_user.user will be destroyed
#   - resource "mysql_user" "user" {
#       - host               = "%" -> null
#       - id                 = "maria@%" -> null
#       - plaintext_password = (sensitive value) -> null
#       - tls_option         = "NONE" -> null
#       - user               = "maria" -> null
#     }
# 
#   # module.mysql.random_password.password will be destroyed
#   - resource "random_password" "password" {
#       - bcrypt_hash = (sensitive value) -> null
#       - id          = "none" -> null
#       - length      = 10 -> null
#       - lower       = true -> null
#       - min_lower   = 0 -> null
#       - min_numeric = 0 -> null
#       - min_special = 0 -> null
#       - min_upper   = 0 -> null
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
#   - password = (sensitive value) -> null
# 
# Do you really want to destroy all resources?
#   Terraform will destroy all your managed infrastructure, as shown above.
#   There is no undo. Only 'yes' will be accepted to confirm.
# 
#   Enter a value: yes
# 
# module.mysql.mysql_grant.grant: Destroying... [id=maria@%:`my_data`]
# module.mysql.mysql_grant.grant: Destruction complete after 0s
# module.mysql.mysql_database.database: Destroying... [id=my_data]
# module.mysql.mysql_user.user: Destroying... [id=maria@%]
# module.mysql.mysql_user.user: Destruction complete after 0s
# module.mysql.random_password.password: Destroying... [id=none]
# module.mysql.random_password.password: Destruction complete after 0s
# module.mysql.mysql_database.database: Destruction complete after 0s
# 
# Destroy complete! Resources: 4 destroyed.
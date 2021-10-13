# Lab04
# Atividade 4.2.
# 
# Crie uma automação em terraform para a criação de um banco de dados em um servidor MySQL existente. Crie um banco de dados chamado "myapp" e um usuário chamado "joao" com a senha "Linux@123". Através do terraform forneça acesso completo ("ALL") para o usuário "joao" apenas no banco de dados "myapp". Ao final conecte-se no banco de dados para validar os acessos.


# Crie um arquivo chamado "~/terraform/lab04/exe02/main.tf", com o seguinte conteúdo:

terraform {
  required_providers {
    mysql = {
      source  = "winebarrel/mysql"
      version = "~> 1.10.6"
    }
  }
  required_version = ">= 0.13"
}

provider "mysql" {
  endpoint = "192.168.1.13"
  username = "root"
  password = "linux"
}

resource "mysql_database" "myapp" {
  name = "myapp"
}

resource "mysql_user" "joao" {
  user               = "joao"
  host               = "%"
  plaintext_password = "Linux@123"
}

resource "mysql_grant" "joao" {
  user       = "${mysql_user.joao.user}"
  host       = "${mysql_user.joao.host}"
  database   = "${mysql_database.myapp.name}"
  privileges = ["ALL"]
  grant      = false
}


# Execute o comando abaixo para inicializar o diretório do terraform:
# 
# $ terraform init
# 
# Initializing the backend...
# 
# Initializing provider plugins...
# - Finding winebarrel/mysql versions matching "~> 1.10.6"...
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
#   # mysql_database.myapp will be created
#   + resource "mysql_database" "myapp" {
#       + default_character_set = "utf8"
#       + default_collation     = "utf8_general_ci"
#       + id                    = (known after apply)
#       + name                  = "myapp"
#     }
# 
#   # mysql_grant.joao will be created
#   + resource "mysql_grant" "joao" {
#       + database   = "myapp"
#       + grant      = false
#       + host       = "%"
#       + id         = (known after apply)
#       + privileges = [
#           + "ALL",
#         ]
#       + table      = "*"
#       + tls_option = "NONE"
#       + user       = "joao"
#     }
# 
#   # mysql_user.joao will be created
#   + resource "mysql_user" "joao" {
#       + host               = "%"
#       + id                 = (known after apply)
#       + plaintext_password = (sensitive value)
#       + tls_option         = "NONE"
#       + user               = "joao"
#     }
# 
# Plan: 3 to add, 0 to change, 0 to destroy.
# 
# ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
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
#   # mysql_database.myapp will be created
#   + resource "mysql_database" "myapp" {
#       + default_character_set = "utf8"
#       + default_collation     = "utf8_general_ci"
#       + id                    = (known after apply)
#       + name                  = "myapp"
#     }
# 
#   # mysql_grant.joao will be created
#   + resource "mysql_grant" "joao" {
#       + database   = "myapp"
#       + grant      = false
#       + host       = "%"
#       + id         = (known after apply)
#       + privileges = [
#           + "ALL",
#         ]
#       + table      = "*"
#       + tls_option = "NONE"
#       + user       = "joao"
#     }
# 
#   # mysql_user.joao will be created
#   + resource "mysql_user" "joao" {
#       + host               = "%"
#       + id                 = (known after apply)
#       + plaintext_password = (sensitive value)
#       + tls_option         = "NONE"
#       + user               = "joao"
#     }
# 
# Plan: 3 to add, 0 to change, 0 to destroy.
# 
# Do you want to perform these actions?
#   Terraform will perform the actions described above.
#   Only 'yes' will be accepted to approve.
# 
#   Enter a value: yes
# 
# mysql_database.myapp: Creating...
# mysql_user.joao: Creating...
# mysql_user.joao: Creation complete after 0s [id=joao@%]
# mysql_database.myapp: Creation complete after 0s [id=myapp]
# mysql_grant.joao: Creating...
# mysql_grant.joao: Creation complete after 0s [id=joao@%:`myapp`]
# 
# Apply complete! Resources: 3 added, 0 changed, 0 destroyed.


# Verifique se a conexão com o banco de dados MySQL está funcionando corretamente com o usuário "joao", e valide se o banco de dados "myapp" foi criado com sucesso, conforme abaixo:
# 
# $ mysql -h 192.168.1.13 -u joao -p 
# Enter password: 
# Welcome to the MySQL monitor.  Commands end with ; or \g.
# Your MySQL connection id is 36
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
# | information_schema |
# | myapp              |
# +--------------------+
# 2 rows in set (0.01 sec)
# 
# mysql> ^DBye


# Execute o comando "terraform destroy" para destruir o ambiente, conforme abaixo:
# 
# $ terraform destroy 
# 
# mysql_database.myapp: Refreshing state... [id=myapp]
# mysql_user.joao: Refreshing state... [id=joao@%]
# mysql_grant.joao: Refreshing state... [id=joao@%:`myapp`]
# 
# Note: Objects have changed outside of Terraform
# 
# Terraform detected the following changes made outside of Terraform since the last "terraform apply":
# 
#   # mysql_grant.joao has been changed
#   ~ resource "mysql_grant" "joao" {
#         id         = "joao@%:`myapp`"
#       ~ privileges = [
#           - "ALL",
#           + "ALL PRIVILEGES",
#         ]
#         # (6 unchanged attributes hidden)
#     }
# 
# Unless you have made equivalent changes to your configuration, or ignored the relevant attributes using ignore_changes, the following plan may include
# actions to undo or respond to these changes.
# 
# ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
# 
# Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
#   - destroy
# 
# Terraform will perform the following actions:
# 
#   # mysql_database.myapp will be destroyed
#   - resource "mysql_database" "myapp" {
#       - default_character_set = "utf8mb3" -> null
#       - default_collation     = "utf8mb3_general_ci" -> null
#       - id                    = "myapp" -> null
#       - name                  = "myapp" -> null
#     }
# 
#   # mysql_grant.joao will be destroyed
#   - resource "mysql_grant" "joao" {
#       - database   = "myapp" -> null
#       - grant      = false -> null
#       - host       = "%" -> null
#       - id         = "joao@%:`myapp`" -> null
#       - privileges = [
#           - "ALL PRIVILEGES",
#         ] -> null
#       - table      = "*" -> null
#       - tls_option = "NONE" -> null
#       - user       = "joao" -> null
#     }
# 
#   # mysql_user.joao will be destroyed
#   - resource "mysql_user" "joao" {
#       - host               = "%" -> null
#       - id                 = "joao@%" -> null
#       - plaintext_password = (sensitive value)
#       - tls_option         = "NONE" -> null
#       - user               = "joao" -> null
#     }
# 
# Plan: 0 to add, 0 to change, 3 to destroy.
# 
# Do you really want to destroy all resources?
#   Terraform will destroy all your managed infrastructure, as shown above.
#   There is no undo. Only 'yes' will be accepted to confirm.
# 
#   Enter a value: yes
# 
# mysql_grant.joao: Destroying... [id=joao@%:`myapp`]
# mysql_grant.joao: Destruction complete after 0s
# mysql_database.myapp: Destroying... [id=myapp]
# mysql_user.joao: Destroying... [id=joao@%]
# mysql_user.joao: Destruction complete after 0s
# mysql_database.myapp: Destruction complete after 0s
# 
# Destroy complete! Resources: 3 destroyed.


# Verifique que o usuário "joao" foi removido, utilizando o comando abaixo:
# 
# $ mysql -h 192.168.1.13 -u joao -p 
# Enter password: 
# ERROR 1045 (28000): Access denied for user 'joao'@'192.168.1.1' (using password: YES)

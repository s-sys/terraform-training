# Lab04
# Atividade 4.3.
# 
# Crie uma automação em terraform para a criação de um banco de dados em um servidor
# PostgreSQL existente. Crie um banco de dados chamado "myapp" e um usuário chamado
# "app" com a senha "Linux@123". Através do terraform forneça acesso "SELECT",
# "INSERT" e "UPDATE" para o usuário "app" apenas no banco de dados "myapp".
# Ao final conecte-se no banco de dados para validar os acessos.


# Crie um arquivo chamado "~/terraform/lab04/exe03/main.tf", com o seguinte conteúdo:

terraform {
  required_providers {
    postgresql = {
      source = "cyrilgdn/postgresql"
      version = "~> 1.21.0"
    }
  }
}

provider "postgresql" {
  host            = "192.168.1.13"
  port            = 5432
  username        = "postgres"
  password        = "linux"
  sslmode         = "disable"
  connect_timeout = 10
}

resource "postgresql_role" "app" {
  name     = "app"
  login    = true
  password = "Linux@123"
}

resource "postgresql_database" "myapp" {
  name  = "myapp"
  owner = postgresql_role.app.name
}

resource "postgresql_grant" "read_write" {
  database    = postgresql_database.myapp.name
  role        = postgresql_role.app.name
  schema      = "public"
  object_type = "table"
  privileges  = ["SELECT", "INSERT", "DELETE"]
}


# Execute o comando abaixo para inicializar o diretório do terraform:
# 
# $ terraform init
# 
# Initializing the backend...
# 
# Initializing provider plugins...
# - Finding cyrilgdn/postgresql versions matching "~> 1.21.0"...
# - Installing cyrilgdn/postgresql v1.21.0...
# - Installed cyrilgdn/postgresql v1.21.0 (self-signed, key ID 3918DD444A3876A6)
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
# Terraform used the selected providers to generate the following execution plan. Resource actions are indicated
# with the following symbols:
#   + create
# 
# Terraform will perform the following actions:
# 
#   # postgresql_database.myapp will be created
#   + resource "postgresql_database" "myapp" {
#       + allow_connections = true
#       + connection_limit  = -1
#       + encoding          = (known after apply)
#       + id                = (known after apply)
#       + is_template       = (known after apply)
#       + lc_collate        = (known after apply)
#       + lc_ctype          = (known after apply)
#       + name              = "myapp"
#       + owner             = "app"
#       + tablespace_name   = (known after apply)
#       + template          = (known after apply)
#     }
# 
#   # postgresql_grant.read_write will be created
#   + resource "postgresql_grant" "read_write" {
#       + database          = "myapp"
#       + id                = (known after apply)
#       + object_type       = "table"
#       + privileges        = [
#           + "DELETE",
#           + "INSERT",
#           + "SELECT",
#         ]
#       + role              = "app"
#       + schema            = "public"
#       + with_grant_option = false
#     }
# 
#   # postgresql_role.app will be created
#   + resource "postgresql_role" "app" {
#       + bypass_row_level_security = false
#       + connection_limit          = -1
#       + create_database           = false
#       + create_role               = false
#       + encrypted_password        = true
#       + id                        = (known after apply)
#       + inherit                   = true
#       + login                     = true
#       + name                      = "app"
#       + password                  = (sensitive value)
#       + replication               = false
#       + skip_drop_role            = false
#       + skip_reassign_owned       = false
#       + superuser                 = false
#       + valid_until               = "infinity"
#     }
# 
# Plan: 3 to add, 0 to change, 0 to destroy.
# 
# ────────────────────────────────────────────────────────────────────────────────────────────────────────────────
# 
# Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these
# actions if you run "terraform apply" now.


# Em seguida execute o comando abaixo para aplicar a configuração do terraform:
# 
# $ terraform apply
# 
# Terraform used the selected providers to generate the following execution plan. Resource actions are indicated
# with the following symbols:
#   + create
# 
# Terraform will perform the following actions:
# 
#   # postgresql_database.myapp will be created
#   + resource "postgresql_database" "myapp" {
#       + allow_connections = true
#       + connection_limit  = -1
#       + encoding          = (known after apply)
#       + id                = (known after apply)
#       + is_template       = (known after apply)
#       + lc_collate        = (known after apply)
#       + lc_ctype          = (known after apply)
#       + name              = "myapp"
#       + owner             = "app"
#       + tablespace_name   = (known after apply)
#       + template          = (known after apply)
#     }
# 
#   # postgresql_grant.read_write will be created
#   + resource "postgresql_grant" "read_write" {
#       + database          = "myapp"
#       + id                = (known after apply)
#       + object_type       = "table"
#       + privileges        = [
#           + "DELETE",
#           + "INSERT",
#           + "SELECT",
#         ]
#       + role              = "app"
#       + schema            = "public"
#       + with_grant_option = false
#     }
# 
#   # postgresql_role.app will be created
#   + resource "postgresql_role" "app" {
#       + bypass_row_level_security = false
#       + connection_limit          = -1
#       + create_database           = false
#       + create_role               = false
#       + encrypted_password        = true
#       + id                        = (known after apply)
#       + inherit                   = true
#       + login                     = true
#       + name                      = "app"
#       + password                  = (sensitive value)
#       + replication               = false
#       + skip_drop_role            = false
#       + skip_reassign_owned       = false
#       + superuser                 = false
#       + valid_until               = "infinity"
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
# postgresql_role.app: Creating...
# postgresql_role.app: Creation complete after 0s [id=app]
# postgresql_database.myapp: Creating...
# postgresql_database.myapp: Creation complete after 0s [id=myapp]
# postgresql_grant.read_write: Creating...
# postgresql_grant.read_write: Creation complete after 1s [id=app_myapp_public_table]
# 
# Apply complete! Resources: 3 added, 0 changed, 0 destroyed.


# Verifique se a conexão com o banco de dados PostgreSQL está funcionando
# corretamente com o usuário "app", e valide se o banco de dados "myapp" foi
# criado com sucesso, conforme abaixo:
# 
# $ psql -h 192.168.1.13 -U app -d myapp -W
# Password:
# psql (14.9)
# SSL connection (protocol: TLSv1.3, cipher: TLS_AES_256_GCM_SHA384, bits: 256, compression: off)
# Type "help" for help.
# 
# myapp=> \list
#                                   List of databases
#    Name    |  Owner   | Encoding |   Collate   |    Ctype    |   Access privileges
# -----------+----------+----------+-------------+-------------+-----------------------
#  myapp     | app      | UTF8     | en_US.UTF-8 | en_US.UTF-8 |
#  postgres  | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 |
#  template0 | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres          +
#            |          |          |             |             | postgres=CTc/postgres
#  template1 | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres          +
#            |          |          |             |             | postgres=CTc/postgres
# (4 rows)
# 
# myapp=> \q


# Execute o comando "terraform destroy" para destruir o ambiente, conforme abaixo:
# 
# $ terraform destroy 
# 
# Terraform used the selected providers to generate the following execution plan. Resource actions are indicated
# with the following symbols:
#   - destroy
# 
# Terraform will perform the following actions:
# 
#   # postgresql_database.myapp will be destroyed
#   - resource "postgresql_database" "myapp" {
#       - allow_connections = true -> null
#       - connection_limit  = -1 -> null
#       - encoding          = "UTF8" -> null
#       - id                = "myapp" -> null
#       - is_template       = false -> null
#       - lc_collate        = "en_US.UTF-8" -> null
#       - lc_ctype          = "en_US.UTF-8" -> null
#       - name              = "myapp" -> null
#       - owner             = "app" -> null
#       - tablespace_name   = "pg_default" -> null
#       - template          = "template0" -> null
#     }
# 
#   # postgresql_grant.read_write will be destroyed
#   - resource "postgresql_grant" "read_write" {
#       - database          = "myapp" -> null
#       - id                = "app_myapp_public_table" -> null
#       - object_type       = "table" -> null
#       - privileges        = [
#           - "DELETE",
#           - "INSERT",
#           - "SELECT",
#         ] -> null
#       - role              = "app" -> null
#       - schema            = "public" -> null
#       - with_grant_option = false -> null
#     }
# 
#   # postgresql_role.app will be destroyed
#   - resource "postgresql_role" "app" {
#       - bypass_row_level_security           = false -> null
#       - connection_limit                    = -1 -> null
#       - create_database                     = false -> null
#       - create_role                         = false -> null
#       - encrypted_password                  = true -> null
#       - id                                  = "app" -> null
#       - idle_in_transaction_session_timeout = 0 -> null
#       - inherit                             = true -> null
#       - login                               = true -> null
#       - name                                = "app" -> null
#       - password                            = (sensitive value) -> null
#       - replication                         = false -> null
#       - roles                               = [] -> null
#       - search_path                         = [] -> null
#       - skip_drop_role                      = false -> null
#       - skip_reassign_owned                 = false -> null
#       - statement_timeout                   = 0 -> null
#       - superuser                           = false -> null
#       - valid_until                         = "infinity" -> null
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
# postgresql_grant.read_write: Destroying... [id=app_myapp_public_table]
# postgresql_grant.read_write: Destruction complete after 1s
# postgresql_database.myapp: Destroying... [id=myapp]
# postgresql_database.myapp: Destruction complete after 0s
# postgresql_role.app: Destroying... [id=app]
# postgresql_role.app: Destruction complete after 0s
# 
# Destroy complete! Resources: 3 destroyed.


# Verifique que o usuário "app" and o bando de dados "myapp" foram removidos, utilizando o comando abaixo:
# 
# $ psql -h 192.168.1.13 -U app -d myapp -W
# Password:
# psql: error: connection to server at "db" (192.168.1.13), port 5432 failed: FATAL:  password authentication failed for user "app"
# connection to server at "db" (192.168.1.13), port 5432 failed: FATAL:  password authentication failed for user "app"

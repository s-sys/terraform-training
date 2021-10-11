# Lab03
# Atividade 3.3.
# 
# Instale o serviço do HashiCups para a realização de operações de CRUD (create, read, update and delete) com dados do provider customizado.


# A partir da máquina docker (192.168.1.11), com o usuário ubuntu, execute os seguintes comandos para inicializar os containers do serviço HashiCups:
# 
# $ git clone https://github.com/hashicorp/learn-terraform-hashicups-provider
# $ cd learn-terraform-hashicups-provider
# $ cd docker_compose
# $ docker-compose up
# 
# Será exibido o console da aplicação e mantenha esta tela aberta. Em um outro terminal execute o seguinte comando para validar se o serviço está ativo:
# 
# $ curl 192.168.1.11:19090/health
# ok


# A partir da máquina host, execute os seguintes comandos abaixo para instalar o provider customizado.
# 
# P_VERSION="0.3.1"
# P_URL="https://github.com/hashicorp/terraform-provider-hashicups"
# P_PATH="releases/download/v${P_VERSION}/terraform-provider-hashicups_${P_VERSION}_linux_amd64.zip"
# curl -LO ${P_URL}/${P_PATH}
# P_LOCAL_PATH="${HOME}/.terraform.d/plugins/hashicorp.com/edu/hashicups/${P_VERSION}/linux_amd64"
# mkdir -p ${P_LOCAL_PATH}
# unzip terraform-provider-hashicups_${P_VERSION}_linux_amd64.zip -d ${P_LOCAL_PATH}
# chmod +x ${P_LOCAL_PATH}/terraform-provider-hashicups_v${P_VERSION}


# Crie um usuário para as operações a serem executadas no provider, utilizando os comandos abaixo:
# 
# $ curl -X POST 192.168.1.11:19090/signup -d '{"username":"education", "password":"test123"}'
# {"UserID":1,"Username":"education","token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2MzQwMDgxMzgsInVzZXJfaWQiOjEsInVzZXJuYW1lIjoidGVzdCJ9.XJficaXW4CqGl5-rOv94Jd3daCQs2Rq3yxLK0GwkH7A"}


# Define a variável HASHICUPS_TOKEN com o valor retornado pela opção token do comando de login, conforme o comando abaixo:
#
# Esta opção não precisa ser definida, pois as definições de autenticação já fazem parte do provider.
# $ export HASHICUPS_TOKEN="$(curl -s -X POST 192.168.1.11:19090/signin -d '{"username":"education", "password":"test123"}' | jq -r ".token")"


# Crie um arquivo chamado "~/terraform/lab03/exe03/main.tf", com o seguinte conteúdo:

terraform {
  required_providers {
    hashicups = {
      version = "~> 0.3.1"
      source  = "hashicorp.com/edu/hashicups"
    }
  }
}


# Execute o comando abaixo para inicializar o diretório do terraform e verifique a saída do comando:
# 
# $ terraform init
# 
# Initializing the backend...
# 
# Initializing provider plugins...
# - Finding hashicorp.com/edu/hashicups versions matching "~> 0.3.1"...
# - Installing hashicorp.com/edu/hashicups v0.3.1...
# - Installed hashicorp.com/edu/hashicups v0.3.1 (unauthenticated)
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


# Altere o arquivo "~/terraform/lab03/exe03/main.tf" incluindo as configurações para o provider e utilizando os recursos disponíveis, conforme abaixo:

provider "hashicups" {
  host     = "http://192.168.1.11:19090"
  username = "education"
  password = "test123"
}

resource "hashicups_order" "order" {
  items {
    coffee {
      id = 3
    }
    quantity = 2
  }
  items {
    coffee {
      id = 2
    }
    quantity = 2
  }
}

output "order" {
  value = hashicups_order.order
}


# Execute o comando "terraform apply" para aplicar as configurações e criar os pedidos executando o comando a seguir:
# 
# $ terraform apply
# 
# Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
#   + create
# 
# Terraform will perform the following actions:
# 
#   # hashicups_order.order will be created
#   + resource "hashicups_order" "order" {
#       + id           = (known after apply)
#       + last_updated = (known after apply)
# 
#       + items {
#           + quantity = 2
# 
#           + coffee {
#               + description = (known after apply)
#               + id          = 3
#               + image       = (known after apply)
#               + name        = (known after apply)
#               + price       = (known after apply)
#               + teaser      = (known after apply)
#             }
#         }
#       + items {
#           + quantity = 2
# 
#           + coffee {
#               + description = (known after apply)
#               + id          = 2
#               + image       = (known after apply)
#               + name        = (known after apply)
#               + price       = (known after apply)
#               + teaser      = (known after apply)
#             }
#         }
#     }
# 
# Plan: 1 to add, 0 to change, 0 to destroy.
# 
# Changes to Outputs:
#   + order = {
#       + id           = (known after apply)
#       + items        = [
#           + {
#               + coffee   = [
#                   + {
#                       + description = (known after apply)
#                       + id          = 3
#                       + image       = (known after apply)
#                       + name        = (known after apply)
#                       + price       = (known after apply)
#                       + teaser      = (known after apply)
#                     },
#                 ]
#               + quantity = 2
#             },
#           + {
#               + coffee   = [
#                   + {
#                       + description = (known after apply)
#                       + id          = 2
#                       + image       = (known after apply)
#                       + name        = (known after apply)
#                       + price       = (known after apply)
#                       + teaser      = (known after apply)
#                     },
#                 ]
#               + quantity = 2
#             },
#         ]
#       + last_updated = (known after apply)
#     }
# 
# Do you want to perform these actions?
#   Terraform will perform the actions described above.
#   Only 'yes' will be accepted to approve.
# 
#   Enter a value: yes
# 
# hashicups_order.order: Creating...
# hashicups_order.order: Creation complete after 1s [id=1]
# 
# Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
# 
# Outputs:
# 
# order = {
#   "id" = "1"
#   "items" = tolist([
#     {
#       "coffee" = tolist([
#         {
#           "description" = ""
#           "id" = 3
#           "image" = "/nomad.png"
#           "name" = "Nomadicano"
#           "price" = 150
#           "teaser" = "Drink one today and you will want to schedule another"
#         },
#       ])
#       "quantity" = 2
#     },
#     {
#       "coffee" = tolist([
#         {
#           "description" = ""
#           "id" = 2
#           "image" = "/vault.png"
#           "name" = "Vaulatte"
#           "price" = 200
#           "teaser" = "Nothing gives you a safe and secure feeling like a Vaulatte"
#         },
#       ])
#       "quantity" = 2
#     },
#   ])
#   "last_updated" = tostring(null)
# }


# Execute o comando abaixo para verificar o estado do recurso hashicups_order.order.
# 
# $ terraform state show hashicups_order.order
# hashicups_order.order:
# resource "hashicups_order" "order" {
#     id           = "1"
#     last_updated = "Monday, 11-Oct-21 04:26:29 UTC"
# 
#     items {
#         quantity = 3
# 
#         coffee {
#             id     = 3
#             image  = "/nomad.png"
#             name   = "Nomadicano"
#             price  = 150
#             teaser = "Drink one today and you will want to schedule another"
#         }
#     }
#     items {
#         quantity = 1
# 
#         coffee {
#             id     = 2
#             image  = "/vault.png"
#             name   = "Vaulatte"
#             price  = 200
#             teaser = "Nothing gives you a safe and secure feeling like a Vaulatte"
#         }
#     }
# }


# Agora altere os dados do arquivo para ajustar as quantidades do pedido, conforme a seguir:
# 
# resource "hashicups_order" "order" {
#   items {
#     coffee {
#       id = 3
#     }
#     quantity = 3
#   }
#   items {
#     coffee {
#       id = 2
#     }
#     quantity = 1
#   }
# }


# Execute novamente o comando "terraform apply" para aplicar as mudanças no arquivo, conforme a seguir:
# 
# $ terraform apply
# hashicups_order.order: Refreshing state... [id=1]
# 
# Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
#   ~ update in-place
# 
# Terraform will perform the following actions:
# 
#   # hashicups_order.order will be updated in-place
#   ~ resource "hashicups_order" "order" {
#         id           = "1"
#         # (1 unchanged attribute hidden)
# 
#       ~ items {
#           ~ quantity = 2 -> 3
# 
#             # (1 unchanged block hidden)
#         }
#       ~ items {
#           ~ quantity = 2 -> 1
# 
#             # (1 unchanged block hidden)
#         }
#     }
# 
# Plan: 0 to add, 1 to change, 0 to destroy.
# 
# Changes to Outputs:
#   ~ order = {
#       ~ items        = [
#           ~ {
#               ~ quantity = 2 -> 3
#                 # (1 unchanged element hidden)
#             },
#           ~ {
#               ~ quantity = 2 -> 1
#                 # (1 unchanged element hidden)
#             },
#         ]
#       ~ last_updated = "Monday, 11-Oct-21 04:26:29 UTC" -> "Monday, 11-Oct-21 04:30:56 UTC"
#         # (1 unchanged element hidden)
#     }
# 
# Do you want to perform these actions?
#   Terraform will perform the actions described above.
#   Only 'yes' will be accepted to approve.
# 
#   Enter a value: yes
# 
# hashicups_order.order: Modifying... [id=1]
# hashicups_order.order: Modifications complete after 0s [id=1]
# 
# Apply complete! Resources: 0 added, 1 changed, 0 destroyed.
# 
# Outputs:
# 
# order = {
#   "id" = "1"
#   "items" = tolist([
#     {
#       "coffee" = tolist([
#         {
#           "description" = ""
#           "id" = 3
#           "image" = "/nomad.png"
#           "name" = "Nomadicano"
#           "price" = 150
#           "teaser" = "Drink one today and you will want to schedule another"
#         },
#       ])
#       "quantity" = 3
#     },
#     {
#       "coffee" = tolist([
#         {
#           "description" = ""
#           "id" = 2
#           "image" = "/vault.png"
#           "name" = "Vaulatte"
#           "price" = 200
#           "teaser" = "Nothing gives you a safe and secure feeling like a Vaulatte"
#         },
#       ])
#       "quantity" = 1
#     },
#   ])
#   "last_updated" = "Monday, 11-Oct-21 04:30:56 UTC"
# }


# Execute o comando "terraform output" para verificar o valor da variáveis de saída "order":
# 
# $ terraform output
# order = {
#   "id" = "1"
#   "items" = tolist([
#     {
#       "coffee" = tolist([
#         {
#           "description" = ""
#           "id" = 3
#           "image" = "/nomad.png"
#           "name" = "Nomadicano"
#           "price" = 150
#           "teaser" = "Drink one today and you will want to schedule another"
#         },
#       ])
#       "quantity" = 3
#     },
#     {
#       "coffee" = tolist([
#         {
#           "description" = ""
#           "id" = 2
#           "image" = "/vault.png"
#           "name" = "Vaulatte"
#           "price" = 200
#           "teaser" = "Nothing gives you a safe and secure feeling like a Vaulatte"
#         },
#       ])
#       "quantity" = 1
#     },
#   ])
#   "last_updated" = "Monday, 11-Oct-21 04:30:56 UTC"
# }


# Altere o arquivo "~/terraform/lab03/exe03/main.tf" para adicionar um bloco de leitura de dados dos recursos do provider, conforme trecho abaixo:

data "hashicups_ingredients" "first_coffee" {
  coffee_id = hashicups_order.order.items[0].coffee[0].id
}

output "first_coffee_ingredients" {
  value = data.hashicups_ingredients.first_coffee
}


# Execute novamente o comando "terraform apply" para aplicar as mudanças no arquivo, conforme a seguir:
# 
# $ terraform apply
# hashicups_order.order: Refreshing state... [id=1]
# 
# Changes to Outputs:
#   + first_coffee_ingredients = {
#       + coffee_id   = 3
#       + id          = "3"
#       + ingredients = [
#           + {
#               + id       = 1
#               + name     = "ingredient - Espresso"
#               + quantity = 20
#               + unit     = "ml"
#             },
#           + {
#               + id       = 3
#               + name     = "ingredient - Hot Water"
#               + quantity = 100
#               + unit     = "ml"
#             },
#         ]
#     }
#   ~ order                    = {
#       ~ last_updated = "Monday, 11-Oct-21 04:30:56 UTC" -> "Monday, 11-Oct-21 04:31:09 UTC"
#         # (2 unchanged elements hidden)
#     }
# 
# You can apply this plan to save these new output values to the Terraform state, without changing any real infrastructure.
# 
# Do you want to perform these actions?
#   Terraform will perform the actions described above.
#   Only 'yes' will be accepted to approve.
# 
#   Enter a value: yes
# 
# 
# Apply complete! Resources: 0 added, 0 changed, 0 destroyed.
# 
# Outputs:
# 
# first_coffee_ingredients = {
#   "coffee_id" = 3
#   "id" = "3"
#   "ingredients" = tolist([
#     {
#       "id" = 1
#       "name" = "ingredient - Espresso"
#       "quantity" = 20
#       "unit" = "ml"
#     },
#     {
#       "id" = 3
#       "name" = "ingredient - Hot Water"
#       "quantity" = 100
#       "unit" = "ml"
#     },
#   ])
# }
# order = {
#   "id" = "1"
#   "items" = tolist([
#     {
#       "coffee" = tolist([
#         {
#           "description" = ""
#           "id" = 3
#           "image" = "/nomad.png"
#           "name" = "Nomadicano"
#           "price" = 150
#           "teaser" = "Drink one today and you will want to schedule another"
#         },
#       ])
#       "quantity" = 3
#     },
#     {
#       "coffee" = tolist([
#         {
#           "description" = ""
#           "id" = 2
#           "image" = "/vault.png"
#           "name" = "Vaulatte"
#           "price" = 200
#           "teaser" = "Nothing gives you a safe and secure feeling like a Vaulatte"
#         },
#       ])
#       "quantity" = 1
#     },
#   ])
#   "last_updated" = "Monday, 11-Oct-21 04:31:09 UTC"
# }


# Execute o comando "terraform destroy" para desfazer todas as alterações, conforme abaixo:
# 
# $ terraform destroy
# hashicups_order.order: Refreshing state... [id=1]
# 
# Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
#   - destroy
# 
# Terraform will perform the following actions:
# 
#   # hashicups_order.order will be destroyed
#   - resource "hashicups_order" "order" {
#       - id           = "1" -> null
#       - last_updated = "Monday, 11-Oct-21 04:31:09 UTC" -> null
# 
#       - items {
#           - quantity = 3 -> null
# 
#           - coffee {
#               - id     = 3 -> null
#               - image  = "/nomad.png" -> null
#               - name   = "Nomadicano" -> null
#               - price  = 150 -> null
#               - teaser = "Drink one today and you will want to schedule another" -> null
#             }
#         }
#       - items {
#           - quantity = 1 -> null
# 
#           - coffee {
#               - id     = 2 -> null
#               - image  = "/vault.png" -> null
#               - name   = "Vaulatte" -> null
#               - price  = 200 -> null
#               - teaser = "Nothing gives you a safe and secure feeling like a Vaulatte" -> null
#             }
#         }
#     }
# 
# Plan: 0 to add, 0 to change, 1 to destroy.
# 
# Changes to Outputs:
#   - first_coffee_ingredients = {
#       - coffee_id   = 3
#       - id          = "3"
#       - ingredients = [
#           - {
#               - id       = 1
#               - name     = "ingredient - Espresso"
#               - quantity = 20
#               - unit     = "ml"
#             },
#           - {
#               - id       = 3
#               - name     = "ingredient - Hot Water"
#               - quantity = 100
#               - unit     = "ml"
#             },
#         ]
#     } -> null
#   - order                    = {
#       - id           = "1"
#       - items        = [
#           - {
#               - coffee   = [
#                   - {
#                       - description = ""
#                       - id          = 3
#                       - image       = "/nomad.png"
#                       - name        = "Nomadicano"
#                       - price       = 150
#                       - teaser      = "Drink one today and you will want to schedule another"
#                     },
#                 ]
#               - quantity = 3
#             },
#           - {
#               - coffee   = [
#                   - {
#                       - description = ""
#                       - id          = 2
#                       - image       = "/vault.png"
#                       - name        = "Vaulatte"
#                       - price       = 200
#                       - teaser      = "Nothing gives you a safe and secure feeling like a Vaulatte"
#                     },
#                 ]
#               - quantity = 1
#             },
#         ]
#       - last_updated = "Monday, 11-Oct-21 04:31:09 UTC"
#     } -> null
# 
# Do you really want to destroy all resources?
#   Terraform will destroy all your managed infrastructure, as shown above.
#   There is no undo. Only 'yes' will be accepted to confirm.
# 
#   Enter a value: yes
# 
# hashicups_order.order: Destroying... [id=1]
# hashicups_order.order: Destruction complete after 0s
# 
# Destroy complete! Resources: 1 destroyed.

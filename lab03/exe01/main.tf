# Lab03
# Atividade 3.1.
# 
# Crie um arquivo de terraform para o carregamento dos providers "aws" na versão "3.59.0"
# e "azurerm" na versão "2.72.0". Após a inicialização faça o upgrade do provider "aws"
# para o último release dentro da versão "3.60.x".


# Crie um arquivo chamado "~/terraform/lab03/exe01/main.tf", com o seguinte conteúdo:


terraform {
required_providers {
azurerm = "= 2.72.0"
aws = "= 3.59.0"
}
}

provider "azurerm" {
features {}
}

provider "aws" {
region = "us-east-1"
}


# Execute o comando abaixo para realizar a formatação do arquivo e visualizar as
# diferenças na formatação:
# 
# $ terraform fmt -diff
# main.tf
# --- old/main.tf
# +++ new/main.tf
# @@ -1,15 +1,15 @@
#  terraform {
# -required_providers {
# -azurerm = "= 2.72.0"
# -aws = "~> 3.60.0"
# -}
# +  required_providers {
# +    azurerm = "= 2.72.0"
# +    aws     = "~> 3.60.0"
# +  }
#  }
#  
#  provider "azurerm" {
# -features {}
# +  features {}
#  }
#  
#  provider "aws" {
# -region = "us-east-1"
# +  region = "us-east-1"
#  }
 

# Verifque o arquivo após a formatação:
# 
# $ cat main.tf 
# terraform {
#   required_providers {
#     azurerm = "= 2.72.0"
#     aws     = "~> 3.60.0"
#   }
# }
# 
# provider "azurerm" {
#   features {}
# }
# 
# provider "aws" {
#   region = "us-east-1"
# }


# Execute o comando abaixo para inicializar o diretório do terraform:
# 
# $ terraform init
# 
# Na sequência execute o comando abaixo para validar o plano de execução do terraform:
# 
# $ terraform plan
# 
# Em seguida execute o comando abaixo para aplicar a configuração do terraform:
# 
# $ terraform apply


# Verifique a saída após a execução do comando "terraform init", conforme a seguir:
# 
# $ terraform init
# 
# Initializing the backend...
# 
# Initializing provider plugins...
# - Finding hashicorp/azurerm versions matching "2.72.0"...
# - Finding hashicorp/aws versions matching "3.59.0"...
# - Installing hashicorp/azurerm v2.72.0...
# - Installed hashicorp/azurerm v2.72.0 (signed by HashiCorp)
# - Installing hashicorp/aws v3.59.0...
# - Installed hashicorp/aws v3.59.0 (signed by HashiCorp)
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


# Verifique a versão do provider salvo localmente executando o comando abaixo:
# 
# $ ls -l .terraform/providers/registry.terraform.io/hashicorp/aws/
# total 4
# drwxr-xr-x 3 azureroot azureroot 4096 Oct 10 23:46 3.59.0


# Agora faça a atualização da versão do plugin do "aws" dentro do arquivo
# "~/terraform/lab03/exe01/main.tf", da seguinte forma:
# 
# terraform {
#   required_providers {
#     azurerm = "= 2.72.0"
#     aws = "~> 3.60.0"
#   }
# }
# 
# provider "azurerm" {
#   features {}
# }
# 
# provider "aws" {
#   region = "us-east-1"
# }


# Execute o comando "terraform init" para atualizar o provider e verifique a mensagem gerada abaixo:
# 
# $ terraform init
# 
# Initializing the backend...
# 
# Initializing provider plugins...
# - Reusing previous version of hashicorp/aws from the dependency lock file
# - Reusing previous version of hashicorp/azurerm from the dependency lock file
# - Using previously-installed hashicorp/azurerm v2.72.0
# ╷
# │ Error: Failed to query available provider packages
# │ 
# │ Could not retrieve the list of available versions for provider hashicorp/aws: locked provider registry.terraform.io/hashicorp/aws 3.59.0 does not
# │ match configured version constraint ~> 3.60.0; must use terraform init -upgrade to allow selection of new versions
# ╵
# 


# Esta mensagem indica que não foi possível fazer o download da nova versão do
# provider devido ao lock presente para a versão "3.59.0". O lock pode ser
# consultado no arquivo .terraform.lock.hcl, conforme abaixo:
# 
# $ cat .terraform.lock.hcl 
# # This file is maintained automatically by "terraform init".
# # Manual edits may be lost in future updates.
# 
# provider "registry.terraform.io/hashicorp/aws" {
#   version     = "3.59.0"
#   constraints = "3.59.0"
#   hashes = [
#     "h1:6JlihvRdEq02BzOZ7P7De2W5HH41ASVYg5I5Z2lAhIo=",
#     "zh:0b33154c805071af15839184f3faafeb1549d26a2f1fe721393461790c5ddb46",
#     "zh:1c5c6793cbec328394c6dda686298d9f6bb7b4c6a39e3dc48dc3035dea9aeda0",
#     "zh:20b590b9d9f0a18fdc9f0fb18bb2d9d5349b14039899ecf66e4ae5513606405b",
#     "zh:3e9010dbb0655b5d05e5e98bfe3e1e73cfa5ff6b364dfd73e8eeeb5e1e58c643",
#     "zh:47a46895d2592fbe7c904107ab6af25abbb17de230852859c06eee95ab282823",
#     "zh:615745b8c25b111cfe204d52553ea530d84abba7fb8be6b5b00476184407b556",
#     "zh:701e0f2e5191729601b6d7591e5c3f5d77439125a74116786cca3bc6d7abf0d9",
#     "zh:7217637b5726bfd09dc9b4f75aef643530e8b673f6de6e06f660a70f4d3170e2",
#     "zh:8097811557dd5fffcc77e921d3a49dfaa203d4640ac3859a64dcd927122ade8b",
#     "zh:9a23df54c62dcf74e88aa309700651a6e77e173429ef0307ee15aaa7ff2f47d0",
#     "zh:e5fa052b9285332a1ebb360ab14676bca88efdaac96cdd809207b23f8e732bb0",
#   ]
# }
# 
# provider "registry.terraform.io/hashicorp/azurerm" {
#   version     = "2.72.0"
#   constraints = "2.72.0"
#   hashes = [
#     "h1:it+syw/GK/2n4uIgpd2krsIwdGaMnYuU8M7kGd/jiEQ=",
#     "zh:02768cb4f7b1aa42b28a5fdede2d7ebe98c8b09938edfd9444072a8c86378b86",
#     "zh:0ec00c8d93f8f74bd755c5e3ab41c1faee243dd74199bb659203ba9f9735c71e",
#     "zh:21fb15059b756a680f36ce2f0c015b41aeb50e2c85edde74841f58959c6a12e5",
#     "zh:2469787cc7bc2a913e949295c2e9eef7300c655cf2a8c2bca5cf31b45b4fd730",
#     "zh:294425fa0823a91fad9f55d7f9c2b349f2b626f91e4210d70b56b330f3364e96",
#     "zh:41c9eb201be1a35b1bc66d9c4a2a29d018bf3e55a58c161c6105ab942036a43f",
#     "zh:7b262060da9a29f330a3e09744b076e3be3ea9c81a208731d1aa0588e09af6cc",
#     "zh:83153590ea2d49784d8faefd7df124b0b9ce68db8a40b75cd81903bdf265f2da",
#     "zh:837bac0fa0a5dbb22357ead8497704de44e44fca23d723207b28c6e9a8539c03",
#     "zh:b885ee745bb321acb2526c4beadd8f91b725b8ce7ed49f5f6a3613c270df8685",
#     "zh:f51ac1d32eae7d169a2df61e611b2f5e5f69e977522c8a86fcd1de7dc7323d3c",
#   ]
# }


# Para instruir o terraform a fazer o upgrade da versão, utilize o seguinte comando abaixo:
# 
# $ terraform init -upgrade
# 
# Initializing the backend...
# 
# Initializing provider plugins...
# - Finding hashicorp/azurerm versions matching "2.72.0"...
# - Finding hashicorp/aws versions matching "~> 3.60.0"...
# - Using previously-installed hashicorp/azurerm v2.72.0
# - Installing hashicorp/aws v3.60.0...
# - Installed hashicorp/aws v3.60.0 (signed by HashiCorp)
# 
# Terraform has made some changes to the provider dependency selections recorded
# in the .terraform.lock.hcl file. Review those changes and commit them to your
# version control system if they represent changes you intended to make.
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


# Verifique a versão do provider salvo localmente executando o comando abaixo:
# 
# $ ls -l .terraform/providers/registry.terraform.io/hashicorp/aws/
# total 8
# drwxr-xr-x 3 azureroot azureroot 4096 Oct 10 23:46 3.59.0
# drwxr-xr-x 3 azureroot azureroot 4096 Oct 11 00:03 3.60.0


# Verifique o conteúdo do arquivo de lock após o upgrade, utilizando o comando abaixo:
# 
# $ cat .terraform.lock.hcl 
# # This file is maintained automatically by "terraform init".
# # Manual edits may be lost in future updates.
# 
# provider "registry.terraform.io/hashicorp/aws" {
#   version     = "3.60.0"
#   constraints = "~> 3.60.0"
#   hashes = [
#     "h1:vwRjnpZOFwDlbFb2WX10JM2zNEEVyRLc8cBwkxCXlAE=",
#     "zh:01323eedb8f006c8f9fffdfc23b449625b1446c1e43b8454e4a40a7461193661",
#     "zh:03513ffdae205832be480b30d332b47a573e48623390e8f9f833141c8ceccb6a",
#     "zh:47611a8b361ced9a3b58b9868be2004677cf4ea0d04cfb5f54c6ae95e997e7c7",
#     "zh:9a7e80c2a2ed0f2e59b05e27374daaafd64785161546ed40f4db11048fbc78a7",
#     "zh:9e809746c4fdaa4214700e81a67b35f02afc1f2873591b0360c473cfd7193877",
#     "zh:a009d48e4ebcf78e24af9299c6a8664e0375411b4f16d5d0d7c7454b12052c10",
#     "zh:adc910f48f5ddc402e7653e70429d150d61bee5190aba7495575303aba6ca6c8",
#     "zh:b702e219532bc09be58f8a30cb3239626ffc9bc0e42b44497b0644f9ecc657b5",
#     "zh:bc50d787593e714acb54d65e8df026490a968e54d2184496efda7ba07c211836",
#     "zh:bd74e3b1c815d5a9c710cb5c55f2d5f6742471a23e63f924fd3a6493f384cd43",
#     "zh:fa7eb23bcf4c01f93d74c509c0e9b039148f43424c3b4ce64619af17ee12265c",
#   ]
# }
# 
# provider "registry.terraform.io/hashicorp/azurerm" {
#   version     = "2.72.0"
#   constraints = "2.72.0"
#   hashes = [
#     "h1:it+syw/GK/2n4uIgpd2krsIwdGaMnYuU8M7kGd/jiEQ=",
#     "zh:02768cb4f7b1aa42b28a5fdede2d7ebe98c8b09938edfd9444072a8c86378b86",
#     "zh:0ec00c8d93f8f74bd755c5e3ab41c1faee243dd74199bb659203ba9f9735c71e",
#     "zh:21fb15059b756a680f36ce2f0c015b41aeb50e2c85edde74841f58959c6a12e5",
#     "zh:2469787cc7bc2a913e949295c2e9eef7300c655cf2a8c2bca5cf31b45b4fd730",
#     "zh:294425fa0823a91fad9f55d7f9c2b349f2b626f91e4210d70b56b330f3364e96",
#     "zh:41c9eb201be1a35b1bc66d9c4a2a29d018bf3e55a58c161c6105ab942036a43f",
#     "zh:7b262060da9a29f330a3e09744b076e3be3ea9c81a208731d1aa0588e09af6cc",
#     "zh:83153590ea2d49784d8faefd7df124b0b9ce68db8a40b75cd81903bdf265f2da",
#     "zh:837bac0fa0a5dbb22357ead8497704de44e44fca23d723207b28c6e9a8539c03",
#     "zh:b885ee745bb321acb2526c4beadd8f91b725b8ce7ed49f5f6a3613c270df8685",
#     "zh:f51ac1d32eae7d169a2df61e611b2f5e5f69e977522c8a86fcd1de7dc7323d3c",
#   ]
# }

# Lab03
# Atividade 3.2.
# 
# Crie um arquivo de terraform para o carregamento do provider "azurerm" para duas
# configurações distintas. Deve ser carregada a última versão disponível do
# provider "azurerm".


# Crie um arquivo chamado "~/terraform/lab03/exe02/main.tf", com o seguinte conteúdo:


provider "azurerm" {
  features {}

  # Default provider
}

provider "azurerm" {
  features {}

  alias = "backup"
}


# Execute o comando abaixo para inicializar o diretório do terraform:
# 
# $ terraform init
# 
# Como não existe nenhum recurso definido não será necessário a execução dos demais
# comandos do terraform.


# Faça um teste comentando a opção "alias" no arquivo "~/terraform/lab03/exe02/main.tf"
# e verifique o resultado da saída do comando "terraform init", conforme abaixo:

# $ terraform init
# 
# Initializing the backend...
# Terraform encountered problems during initialisation, including problems
# with the configuration, described below.
# 
# The Terraform configuration must be valid before initialization so that
# Terraform can determine which modules and providers need to be installed.
# │
# │ Error: Duplicate provider configuration
# │
# │   on main.tf line 7:
# │    7: provider "azurerm" {
# │
# │ A default (non-aliased) provider configuration for "azurerm" was already given at main.tf:1,1-19. If multiple configurations are
# │ required, set the "alias" argument for alternative configurations.
# │
# 
# │
# │ Error: Duplicate provider configuration
# │
# │   on main.tf line 7:
# │    7: provider "azurerm" {
# │
# │ A default (non-aliased) provider configuration for "azurerm" was already given at main.tf:1,1-19. If multiple configurations are
# │ required, set the "alias" argument for alternative configurations.
# │
# 


# Caso não seja especificado o parâmetro "alias" não será possível fazer uso de mais
# de um provider do mesmo tipo dentro do terraform.

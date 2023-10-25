# Lab01
# Atividade 1.2.
# Criar uma automação no terraform para adicionar um provedor e executar uma análise dos processos.
# 
# A partir da máquina principal do laboratório executar a seguinte sequência de comandos para criar os arquivos de trabalho do terraform:
# 
# mkdir -p ~/terraform/lab01/exe02
# cd ~/terraform/lab01/exe02
# 
# Na sequência crie o arquivo "main.tf" dentro do diretório ~/terraform/lab01/exe02, com o seguinte conteúdo:


provider aws {
  region = "us-west-2"
}


# Execute o comando a seguir para inicializar o terraform:
#
# terraform init


# Verifique a saída do comando:
# 
# Initializing the backend...
# 
# Initializing provider plugins...
# - Finding latest version of hashicorp/aws...
# - Installing hashicorp/aws v5.22.0...
# - Installed hashicorp/aws v5.22.0 (signed by HashiCorp)
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


# Verifique o diretório .terraform que foi criado e seu conteúdo.
# 
# $ ls -lR .terraform
# .terraform:
# total 0
# drwxr-xr-x 3 root root 35 Oct 24 20:45 providers
# 
# .terraform/providers:
# total 0
# drwxr-xr-x 3 root root 23 Oct 24 20:45 registry.terraform.io
# 
# .terraform/providers/registry.terraform.io:
# total 0
# drwxr-xr-x 3 root root 17 Oct 24 20:45 hashicorp
# 
# .terraform/providers/registry.terraform.io/hashicorp:
# total 0
# drwxr-xr-x 3 root root 20 Oct 24 20:45 aws
# 
# .terraform/providers/registry.terraform.io/hashicorp/aws:
# total 0
# drwxr-xr-x 3 root root 25 Oct 24 20:45 5.22.0
# 
# .terraform/providers/registry.terraform.io/hashicorp/aws/5.22.0:
# total 0
# drwxr-xr-x 2 root root 47 Oct 24 20:45 linux_amd64
# 
# .terraform/providers/registry.terraform.io/hashicorp/aws/5.22.0/linux_amd64:
# total 346384
# -rwxr-xr-x 1 root root 354697216 Oct 24 20:45 terraform-provider-aws_v5.22.0_x5


# Verifique também o arquivo .terraform.lock.hcl e seu conteúdo.
# 
# $ cat .terraform.lock.hcl 
# # This file is maintained automatically by "terraform init".
# # Manual edits may be lost in future updates.
# 
# provider "registry.terraform.io/hashicorp/aws" {
#   version = "5.22.0"
#   hashes = [
#     "h1:s5D2g7z2dt8mqIwnQAjyE6NZWEirfRxt7kLsmslY5Ls=",
#     "zh:09b8475cd519c945423b1e1183b71a4209dd2927e0d289a88c5abeecb53c1753",
#     "zh:2448e0c3ce9b991a5dd70f6a42d842366a6a2460cf63b31fb9bc5d2cc92ced19",
#     "zh:3b9fc2bf6714a9a9ab25eae3e56cead3d3917bc1b6d8b9fb3111c4198a790c72",
#     "zh:4fbd28ad5380529a36c54d7a96c9768df1288c625d28b8fa3a50d4fc2176ef0f",
#     "zh:54d550f190702a7edc2d459952d025e259a8c0b0ff7df3f15bbcc148539214bf",
#     "zh:638f406d084ac96f3a0b0a5ce8aa71a5a2a781a56ba96e3a235d3982b89eef0d",
#     "zh:69d4c175b13b6916b5c9398172cc384e7af46cb737b45870ab9907f12e82a28a",
#     "zh:81edec181a67255d25caf5e7ffe6d5e8f9373849b9e8f5e0705f277640abb18e",
#     "zh:9b12af85486a96aedd8d7984b0ff811a4b42e3d88dad1a3fb4c0b580d04fa425",
#     "zh:a66efb2b3cf7be8116728ae5782d7550f23f3719da2ed3c10228d29c44b7dc84",
#     "zh:ae754478d0bfa42195d16cf46091fab7c1c075ebc965d919338e36aed45add78",
#     "zh:e0603ad0061c43aa1cb52740b1e700b8afb55667d7ee01c1cc1ceb6f983d4c9d",
#     "zh:e4cb701d0185884eed0492a66eff17251f5b4971d30e81acd5e0a55627059fc8",
#     "zh:f7db2fcf69679925dde1ae326526242fd61ba1f83f614b1f6d9d68c925417e51",
#     "zh:fef331b9b62bc26d900ae937cc662281ff30794edf48aebfe8997d0e16835f6d",
#   ]
# }


# Execute o plano, executando o seguinte comando abaixo e verifique o resultado:
# 
# $ terraform plan
# 
# No changes. Your infrastructure matches the configuration.
# 
# Terraform has compared your real infrastructure against your configuration and found no differences, so no changes are needed.


# Execute a aplicação das regras do terraform, utilizando o comando abaixo e verifique o resultado:
# 
# $ terraform apply
# 
# No changes. Your infrastructure matches the configuration.
# 
# Terraform has compared your real infrastructure against your configuration and found no differences, so no changes are needed.
# 
# Apply complete! Resources: 0 added, 0 changed, 0 destroyed.


# Verifique também o arquivo de estado terraform.tfstate e seu conteúdo.
# $ cat terraform.tfstate 
# {
#   "version": 4,
#   "terraform_version": "1.6.2",
#   "serial": 1,
#   "lineage": "9a7178f4-da6e-a0c5-9c97-005c6f903eac",
#   "outputs": {},
#   "resources": [],
#   "check_results": null
# }


# Execute a destruição do ambiente, utilizando o comando abaixo e verifique o resultado:
# 
# $ terraform destroy 
# 
# No changes. No objects need to be destroyed.
# 
# Either you have not created any objects yet or the existing objects were already deleted outside of Terraform.
# 
# Destroy complete! Resources: 0 destroyed.

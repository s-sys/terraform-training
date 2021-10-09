# Lab01
# Atividade 1.2.
# Criar uma automação no terraform para adicionar um provedor e executar uma análise dos processos.
# 
# A partir da máquina principal do laboratório executar a seguinte sequência de comandos para criar os arquivos de trabalho do terraform:
# 
# mkdir -p ~/terraform/lab01/exe02
# cd ~/terraform/lab01/exe02
# 
# Na sequência crie o arquivo "exe02.tf" dentro do diretório ~/terraform/lab01/exe02, com o seguinte conteúdo:


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
# - Installing hashicorp/aws v3.62.0...
# - Installed hashicorp/aws v3.62.0 (signed by HashiCorp)
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
# total 4
# drwxr-xr-x 3 azureroot azureroot 4096 Oct  9 14:20 providers
# 
# .terraform/providers:
# total 4
# drwxr-xr-x 3 azureroot azureroot 4096 Oct  9 14:20 registry.terraform.io
# 
# .terraform/providers/registry.terraform.io:
# total 4
# drwxr-xr-x 3 azureroot azureroot 4096 Oct  9 14:20 hashicorp
# 
# .terraform/providers/registry.terraform.io/hashicorp:
# total 4
# drwxr-xr-x 3 azureroot azureroot 4096 Oct  9 14:20 aws
# 
# .terraform/providers/registry.terraform.io/hashicorp/aws:
# total 4
# drwxr-xr-x 3 azureroot azureroot 4096 Oct  9 14:20 3.62.0
# 
# .terraform/providers/registry.terraform.io/hashicorp/aws/3.62.0:
# total 4
# drwxr-xr-x 2 azureroot azureroot 4096 Oct  9 14:20 linux_amd64
# 
# .terraform/providers/registry.terraform.io/hashicorp/aws/3.62.0/linux_amd64:
# total 189732
# -rwxr-xr-x 1 azureroot azureroot 194285568 Oct  9 14:20 terraform-provider-aws_v3.62.0_x5


# Verifique também o arquivo .terraform.lock.hcl e seu conteúdo.
# 
# $ cat .terraform.lock.hcl 
# # This file is maintained automatically by "terraform init".
# # Manual edits may be lost in future updates.
# 
# provider "registry.terraform.io/hashicorp/aws" {
#   version = "3.62.0"
#   hashes = [
#     "h1:OxJqmYKlCkE5iJK3/NoCP+9EQXQQD2ORdwnRIHaTlgs=",
#     "zh:08a94019e17304f5927d7c85b8f5dade6b9ffebeb7b06ec0643aaa1130c4c85d",
#     "zh:0e3709f6c1fed8c5119a5653bec7e3069258ddf91f62d851f8deeede10487fb8",
#     "zh:0ed32886abce5fee49f1ae49b84472558224366c31a638e51c63061c3126e7c2",
#     "zh:0f1ecbeddfa61d87701a3f3b463e508773171981bf6dad8b1313a9eafaffd5e1",
#     "zh:724cde4f27253b547714a606288ede17f5df67f430438478feed113d7acb5ac7",
#     "zh:81e6e751a168eab1a054230d4441b43c68693bfb6e0545536f2ea6dbb39fe9af",
#     "zh:84deaf1c6661ba0dbc07ac159109fb6746772476646d39854c755c8dfb7a8ac4",
#     "zh:909dcefc6c986c926ad856662ab5d38a3988b1906569387b5b58e7ddd89a155c",
#     "zh:d03886705e9f25d4bebeae115bb07e36adb14e778859cedb2bf3c3bed39f4d2b",
#     "zh:de9fc80c5a5d3be7535856242c823a92516eb7d5c16ae509fa10b92cd6b3fa9b",
#     "zh:e91dcd9eec8b779a9b089f2f8d45f1047f890cb7b9241490451da52c04cef63d",
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
#   "terraform_version": "1.0.8",
#   "serial": 1,
#   "lineage": "af619d3c-7166-ce5b-ab86-04c3bb324e24",
#   "outputs": {},
#   "resources": []
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

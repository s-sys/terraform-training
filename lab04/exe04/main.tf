# Lab04
# Atividade 4.4.
# 
# Crie uma playlist no Spotify de forma automatizada utilizando sua conta pessoal.


# Crie um arquivo chamado "~/terraform/lab04/exe04/main.tf", com o seguinte conteúdo:

terraform {
  required_providers {
    spotify = {
      source  = "conradludgate/spotify"
      version = "~> 0.2.0"
    }
  }
}

provider "spotify" {
  auth_server = "http://localhost:27228"
  api_key     = "crpjnn5KWgKx-H5nQOW2jrO5obpo-rL1kUyr0vkhANG0FQ9MfaWrL8l7qM-Dwa63"

}

resource "spotify_playlist" "terraform_playlist" {
  name        = "Terraform Training Playlist"
  description = "Playlist used in terraform training."
  public      = false

  tracks = flatten([
    data.spotify_track.toy_story_4_theme.id,
  ])
}

data "spotify_track" "toy_story_4_theme" {
  url = "https://open.spotify.com/track/0pUdOFWYSL4c7bFlpV68GG?si=cc1cfdd49d6f4e7d"
}


# Crie um arquivo chamado "~/terraform/lab04/exe04/spotify-proxy.sh", com o seguinte conteúdo:
# 
# #!/bin/bash
# export SPOTIFY_CLIENT_ID="SECRET_HERE"
# export SPOTIFY_CLIENT_SECRET="SECRET_HERE"
# export SPOTIFY_PROXY_API_KEY="crpjnn5KWgKx-H5nQOW2jrO5obpo-rL1kUyr0vkhANG0FQ9MfaWrL8l7qM-Dwa63"
# export SPOTIFY_CLIENT_REDIRECT_URI=http://localhost:27228/spotify_callback
# go install github.com/conradludgate/terraform-provider-spotify/spotify_auth_proxy@latest
# ~/go/bin/spotify_auth_proxy


# Acesse o site "https://developer.spotify.com/dashboard/applications/", faça o login com o seu usuário do Spotify e crie uma aplicação utilizando as seguintes informações:
# 
# App name: terraform-training
# App description: API used in terraform training.
# 
# Selecione a aplicação e anote o valor de "Client ID" e "Client Secret" e em seguida selecione a Opção "Edit Settings". Preencha os seguintes valores:
# 
# Redirect URIs: http://localhost:27228/spotify_callback
# 
# Clique em "Save".
# 
# Altere o arquivo "~/terraform/lab04/exe04/spotify-proxy.sh" incluindo os valores dos campos "Client ID" e "Client Secret" nas varíaveis adequadas.


# # Em um terminal separado execute o script "spotify-proxy.sh" da seguinte forma:
# 
# $ bash spotify-proxy.sh
# Auth URL: http://localhost:27228/authorize?token=1NaxKynd1787HkwkrXzMfYY7wMhInLjh_Odm3V8ZlK3nMsam6N9ktIoDERSLq74E
# 
# Copie o endereço acima gerado pela sua aplicação e cole em um navegador web na mesma máquina. Será solicitada a autenticação no Spotify para autorizar a aplicação a usar a sua conta do Spotify. Após a autorização será exibida uma mensagem no navegador dizendo "Authorization successful".


# Execute o comando abaixo para inicializar o diretório do terraform:
# 
# $ terraform init
# 
# Initializing the backend...
# 
# Initializing provider plugins...
# - Finding conradludgate/spotify versions matching "~> 0.2.0"...
# - Installing conradludgate/spotify v0.2.6...
# - Installed conradludgate/spotify v0.2.6 (self-signed, key ID B4E4E68AFAC5D89C)
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
# spotify_playlist.terraform_playlist: Refreshing state... [id=4eN90Q6jrOMoeqerpehueT]
# 
# Note: Objects have changed outside of Terraform
# 
# Terraform detected the following changes made outside of Terraform since the last "terraform apply":
# 
#   # spotify_playlist.terraform_playlist has been changed
#   ~ resource "spotify_playlist" "terraform_playlist" {
#         id          = "4eN90Q6jrOMoeqerpehueT"
#         name        = "Terraform Training Playlist"
#       ~ snapshot_id = "MyxkNTYwODlkYjRhNDAxNzhhYmViOTM2YzdlMzA0MGI0MTg0NDEwNWYz" -> "NCw1YzEzMjJjOTg3MGE4NmU4YmMxYjJjZDQxZWFhM2FjZjA2YjA0NzZh"
#         # (3 unchanged attributes hidden)
#     }
# 
# Unless you have made equivalent changes to your configuration, or ignored the relevant attributes using ignore_changes, the following plan may
# include actions to undo or respond to these changes.
# 
# ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
# 
# Changes to Outputs:
#   + playlist_url = "https://open.spotify.com/playlist/4eN90Q6jrOMoeqerpehueT"
# 
# You can apply this plan to save these new output values to the Terraform state, without changing any real infrastructure.
# 
# ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
# 
# Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.


# Em seguida execute o comando abaixo para aplicar a configuração do terraform:
# 
# $ terraform apply
# 
# spotify_playlist.terraform_playlist: Refreshing state... [id=4eN90Q6jrOMoeqerpehueT]
# 
# Note: Objects have changed outside of Terraform
# 
# Terraform detected the following changes made outside of Terraform since the last "terraform apply":
# 
#   # spotify_playlist.terraform_playlist has been changed
#   ~ resource "spotify_playlist" "terraform_playlist" {
#         id          = "4eN90Q6jrOMoeqerpehueT"
#         name        = "Terraform Training Playlist"
#       ~ snapshot_id = "MyxkNTYwODlkYjRhNDAxNzhhYmViOTM2YzdlMzA0MGI0MTg0NDEwNWYz" -> "NCw1YzEzMjJjOTg3MGE4NmU4YmMxYjJjZDQxZWFhM2FjZjA2YjA0NzZh"
#         # (3 unchanged attributes hidden)
#     }
# 
# Unless you have made equivalent changes to your configuration, or ignored the relevant attributes using ignore_changes, the following plan may
# include actions to undo or respond to these changes.
# 
# ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
# 
# Changes to Outputs:
#   + playlist_url = "https://open.spotify.com/playlist/4eN90Q6jrOMoeqerpehueT"
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
# playlist_url = "https://open.spotify.com/playlist/4eN90Q6jrOMoeqerpehueT"


# Verifique no aplicativo Spotify se a playlist foi criada. O endereço de acesso a playlist pode ser obtido executando o comando abaixo:
# 
# $ terraform output playlist_url


# Execute o comando "terraform destroy" para destruir o ambiente, conforme abaixo:
# 
# $ terraform destroy 
# 
# spotify_playlist.terraform_playlist: Refreshing state... [id=4eN90Q6jrOMoeqerpehueT]
# 
# Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
#   - destroy
# 
# Terraform will perform the following actions:
# 
#   # spotify_playlist.terraform_playlist will be destroyed
#   - resource "spotify_playlist" "terraform_playlist" {
#       - description = "Playlist used in terraform training." -> null
#       - id          = "4eN90Q6jrOMoeqerpehueT" -> null
#       - name        = "Terraform Training Playlist" -> null
#       - public      = false -> null
#       - snapshot_id = "NCw1YzEzMjJjOTg3MGE4NmU4YmMxYjJjZDQxZWFhM2FjZjA2YjA0NzZh" -> null
#       - tracks      = [
#           - "0pUdOFWYSL4c7bFlpV68GG",
#         ] -> null
#     }
# 
# Plan: 0 to add, 0 to change, 1 to destroy.
# 
# Changes to Outputs:
#   - playlist_url = "https://open.spotify.com/playlist/4eN90Q6jrOMoeqerpehueT" -> null
# 
# Do you really want to destroy all resources?
#   Terraform will destroy all your managed infrastructure, as shown above.
#   There is no undo. Only 'yes' will be accepted to confirm.
# 
#   Enter a value: yes
# 
# spotify_playlist.terraform_playlist: Destroying... [id=4eN90Q6jrOMoeqerpehueT]
# spotify_playlist.terraform_playlist: Destruction complete after 0s
# 
# Destroy complete! Resources: 1 destroyed.

# Lab03
# Atividade 3.8.
# 
# Utilize o terraform para automatizar a criação de um cluster Kubernetes
# para deploy de uma aplicação Nginx.

# Crie um arquivo chamado "~/terraform/lab03/exe08/main.tf", com o seguinte conteúdo:

terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.5.1"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_namespace" "namespace" {
  metadata {
    name = "nginx"
  }
}

resource "kubernetes_deployment" "deploy" {
  metadata {
    name      = "nginx"
    namespace = kubernetes_namespace.namespace.metadata.0.name
  }

  spec {
    replicas = 4

    selector {
      match_labels = {
        app = "MyApp"
      }

    }
    template {
      metadata {
        labels = {
          app = "MyApp"
        }
      }

      spec {
        container {
          image = "nginx"
          name  = "nginx-container"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "service" {
  metadata {
    name      = "nginx"
    namespace = kubernetes_namespace.namespace.metadata.0.name
  }

  spec {
    selector = {
      app = kubernetes_deployment.deploy.spec.0.template.0.metadata.0.labels.app
    }

    type = "NodePort"
    port {
      node_port   = 30080
      port        = 80
      target_port = 80
    }
  }
}

resource "null_resource" "kube_port_forward" {
  depends_on = [kubernetes_service.service]

  provisioner "local-exec" {
    command = "ssh root@192.168.1.12 'systemctl start kubectl-port-forward.service' "
  }

  provisioner "local-exec" {
    when    = destroy
    command = "ssh root@192.168.1.12 'systemctl stop kubectl-port-forward.service' "
  }
}


# Execute o comando abaixo para gerar um par de chaves SSH para utilizar na conexão com
# a máquina virtual, mas não defina nenhuma senha para as chaves:
# 
# $ ssh-keygen
# 
# Generating public/private rsa key pair.
# Enter file in which to save the key (/home/azureroot/.ssh/id_rsa):
# Enter passphrase (empty for no passphrase): 
# Enter same passphrase again: 
# Your identification has been saved in /home/azureroot/.ssh/id_rsa
# Your public key has been saved in /home/azureroot/.ssh/id_rsa.pub
# The key fingerprint is: 
# SHA256:Gv5QYe4VFfxeCMrYXGF4GVwJcMavKJ3jM5ZrH/TAWrY azureroot@terraform-01
# The key's randomart image is:
# +---[RSA 3072]----+
# |          .*XB.. |
# |          .=O .  |
# |        o=.+ + . |
# |       o..=o  + .| 
# |      . S..o*o . |
# |     . =..==.+.  | 
# |      + .o.oE .  |
# |       o  B  .   |
# |        .o.=.    |   
# +----[SHA256]-----+   


# Adicione a chave SSH do usuário azureroot disponível em "~/.ssh/id_rsa.pub"
# dentro do arquivo "/root/.ssh/authorized_keys" do usuário root do servidor
# minikube em 192.168.1.12. Esta etapa é importante para que não seja exigida
# senha durante o processo de execução do serviço "kubectl fort-forward" no
# servidor minikube.


# Execute o comando abaixo para inicializar o diretório do terraform e verifique
# a saída do comando:
#
# $ terraform init
# 
# Initializing the backend...
# 
# Initializing provider plugins...
# - Finding hashicorp/kubernetes versions matching "~> 2.5.1"...
# - Finding latest version of hashicorp/null...
# - Installing hashicorp/kubernetes v2.5.1...
# - Installed hashicorp/kubernetes v2.5.1 (signed by HashiCorp)
# - Installing hashicorp/null v3.1.0...
# - Installed hashicorp/null v3.1.0 (signed by HashiCorp)
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


# Em seguida execute o comando abaixo para aplicar a configuração do terraform:
# 
# $ terraform apply -auto-approve
# 
# Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
#   + create
# 
# Terraform will perform the following actions:
# 
#   # kubernetes_deployment.deploy will be created
#   + resource "kubernetes_deployment" "deploy" {
#       + id               = (known after apply)
#       + wait_for_rollout = true
# 
#       + metadata {
#           + generation       = (known after apply)
#           + name             = "nginx"
#           + namespace        = "nginx"
#           + resource_version = (known after apply)
#           + uid              = (known after apply)
#         }
# 
#       + spec {
#           + min_ready_seconds         = 0
#           + paused                    = false
#           + progress_deadline_seconds = 600
#           + replicas                  = "4"
#           + revision_history_limit    = 10
# 
#           + selector {
#               + match_labels = {
#                   + "app" = "MyApp"
#                 }
#             }
# 
#           + strategy {
#               + type = (known after apply)
# 
#               + rolling_update {
#                   + max_surge       = (known after apply)
#                   + max_unavailable = (known after apply)
#                 }
#             }
# 
#           + template {
#               + metadata {
#                   + generation       = (known after apply)
#                   + labels           = {
#                       + "app" = "MyApp"
#                     }
#                   + name             = (known after apply)
#                   + resource_version = (known after apply)
#                   + uid              = (known after apply)
#                 }
# 
#               + spec {
#                   + automount_service_account_token  = true
#                   + dns_policy                       = "ClusterFirst"
#                   + enable_service_links             = true
#                   + host_ipc                         = false
#                   + host_network                     = false
#                   + host_pid                         = false
#                   + hostname                         = (known after apply)
#                   + node_name                        = (known after apply)
#                   + restart_policy                   = "Always"
#                   + service_account_name             = (known after apply)
#                   + share_process_namespace          = false
#                   + termination_grace_period_seconds = 30
# 
#                   + container {
#                       + image                      = "nginx"
#                       + image_pull_policy          = (known after apply)
#                       + name                       = "nginx-container"
#                       + stdin                      = false
#                       + stdin_once                 = false
#                       + termination_message_path   = "/dev/termination-log"
#                       + termination_message_policy = (known after apply)
#                       + tty                        = false
# 
#                       + port {
#                           + container_port = 80
#                           + protocol       = "TCP"
#                         }
# 
#                       + resources {
#                           + limits   = (known after apply)
#                           + requests = (known after apply)
#                         }
#                     }
# 
#                   + image_pull_secrets {
#                       + name = (known after apply)
#                     }
# 
#                   + readiness_gate {
#                       + condition_type = (known after apply)
#                     }
# 
#                   + volume {
#                       + name = (known after apply)
# 
#                       + aws_elastic_block_store {
#                           + fs_type   = (known after apply)
#                           + partition = (known after apply)
#                           + read_only = (known after apply)
#                           + volume_id = (known after apply)
#                         }
# 
#                       + azure_disk {
#                           + caching_mode  = (known after apply)
#                           + data_disk_uri = (known after apply)
#                           + disk_name     = (known after apply)
#                           + fs_type       = (known after apply)
#                           + kind          = (known after apply)
#                           + read_only     = (known after apply)
#                         }
# 
#                       + azure_file {
#                           + read_only        = (known after apply)
#                           + secret_name      = (known after apply)
#                           + secret_namespace = (known after apply)
#                           + share_name       = (known after apply)
#                         }
# 
#                       + ceph_fs {
#                           + monitors    = (known after apply)
#                           + path        = (known after apply)
#                           + read_only   = (known after apply)
#                           + secret_file = (known after apply)
#                           + user        = (known after apply)
# 
#                           + secret_ref {
#                               + name      = (known after apply)
#                               + namespace = (known after apply)
#                             }
#                         }
# 
#                       + cinder {
#                           + fs_type   = (known after apply)
#                           + read_only = (known after apply)
#                           + volume_id = (known after apply)
#                         }
# 
#                       + config_map {
#                           + default_mode = (known after apply)
#                           + name         = (known after apply)
#                           + optional     = (known after apply)
# 
#                           + items {
#                               + key  = (known after apply)
#                               + mode = (known after apply)
#                               + path = (known after apply)
#                             }
#                         }
# 
#                       + csi {
#                           + driver            = (known after apply)
#                           + fs_type           = (known after apply)
#                           + read_only         = (known after apply)
#                           + volume_attributes = (known after apply)
#                           + volume_handle     = (known after apply)
# 
#                           + controller_expand_secret_ref {
#                               + name      = (known after apply)
#                               + namespace = (known after apply)
#                             }
# 
#                           + controller_publish_secret_ref {
#                               + name      = (known after apply)
#                               + namespace = (known after apply)
#                             }
# 
#                           + node_publish_secret_ref {
#                               + name      = (known after apply)
#                               + namespace = (known after apply)
#                             }
# 
#                           + node_stage_secret_ref {
#                               + name      = (known after apply)
#                               + namespace = (known after apply)
#                             }
#                         }
# 
#                       + downward_api {
#                           + default_mode = (known after apply)
# 
#                           + items {
#                               + mode = (known after apply)
#                               + path = (known after apply)
# 
#                               + field_ref {
#                                   + api_version = (known after apply)
#                                   + field_path  = (known after apply)
#                                 }
# 
#                               + resource_field_ref {
#                                   + container_name = (known after apply)
#                                   + divisor        = (known after apply)
#                                   + resource       = (known after apply)
#                                 }
#                             }
#                         }
# 
#                       + empty_dir {
#                           + medium     = (known after apply)
#                           + size_limit = (known after apply)
#                         }
# 
#                       + fc {
#                           + fs_type      = (known after apply)
#                           + lun          = (known after apply)
#                           + read_only    = (known after apply)
#                           + target_ww_ns = (known after apply)
#                         }
# 
#                       + flex_volume {
#                           + driver    = (known after apply)
#                           + fs_type   = (known after apply)
#                           + options   = (known after apply)
#                           + read_only = (known after apply)
# 
#                           + secret_ref {
#                               + name      = (known after apply)
#                               + namespace = (known after apply)
#                             }
#                         }
# 
#                       + flocker {
#                           + dataset_name = (known after apply)
#                           + dataset_uuid = (known after apply)
#                         }
# 
#                       + gce_persistent_disk {
#                           + fs_type   = (known after apply)
#                           + partition = (known after apply)
#                           + pd_name   = (known after apply)
#                           + read_only = (known after apply)
#                         }
# 
#                       + git_repo {
#                           + directory  = (known after apply)
#                           + repository = (known after apply)
#                           + revision   = (known after apply)
#                         }
# 
#                       + glusterfs {
#                           + endpoints_name = (known after apply)
#                           + path           = (known after apply)
#                           + read_only      = (known after apply)
#                         }
# 
#                       + host_path {
#                           + path = (known after apply)
#                           + type = (known after apply)
#                         }
# 
#                       + iscsi {
#                           + fs_type         = (known after apply)
#                           + iqn             = (known after apply)
#                           + iscsi_interface = (known after apply)
#                           + lun             = (known after apply)
#                           + read_only       = (known after apply)
#                           + target_portal   = (known after apply)
#                         }
# 
#                       + local {
#                           + path = (known after apply)
#                         }
# 
#                       + nfs {
#                           + path      = (known after apply)
#                           + read_only = (known after apply)
#                           + server    = (known after apply)
#                         }
# 
#                       + persistent_volume_claim {
#                           + claim_name = (known after apply)
#                           + read_only  = (known after apply)
#                         }
# 
#                       + photon_persistent_disk {
#                           + fs_type = (known after apply)
#                           + pd_id   = (known after apply)
#                         }
# 
#                       + projected {
#                           + default_mode = (known after apply)
# 
#                           + sources {
#                               + config_map {
#                                   + name     = (known after apply)
#                                   + optional = (known after apply)
# 
#                                   + items {
#                                       + key  = (known after apply)
#                                       + mode = (known after apply)
#                                       + path = (known after apply)
#                                     }
#                                 }
# 
#                               + downward_api {
#                                   + items {
#                                       + mode = (known after apply)
#                                       + path = (known after apply)
# 
#                                       + field_ref {
#                                           + api_version = (known after apply)
#                                           + field_path  = (known after apply)
#                                         }
# 
#                                       + resource_field_ref {
#                                           + container_name = (known after apply)
#                                           + divisor        = (known after apply)
#                                           + resource       = (known after apply)
#                                         }
#                                     }
#                                 }
# 
#                               + secret {
#                                   + name     = (known after apply)
#                                   + optional = (known after apply)
# 
#                                   + items {
#                                       + key  = (known after apply)
#                                       + mode = (known after apply)
#                                       + path = (known after apply)
#                                     }
#                                 }
# 
#                               + service_account_token {
#                                   + audience           = (known after apply)
#                                   + expiration_seconds = (known after apply)
#                                   + path               = (known after apply)
#                                 }
#                             }
#                         }
# 
#                       + quobyte {
#                           + group     = (known after apply)
#                           + read_only = (known after apply)
#                           + registry  = (known after apply)
#                           + user      = (known after apply)
#                           + volume    = (known after apply)
#                         }
# 
#                       + rbd {
#                           + ceph_monitors = (known after apply)
#                           + fs_type       = (known after apply)
#                           + keyring       = (known after apply)
#                           + rados_user    = (known after apply)
#                           + rbd_image     = (known after apply)
#                           + rbd_pool      = (known after apply)
#                           + read_only     = (known after apply)
# 
#                           + secret_ref {
#                               + name      = (known after apply)
#                               + namespace = (known after apply)
#                             }
#                         }
# 
#                       + secret {
#                           + default_mode = (known after apply)
#                           + optional     = (known after apply)
#                           + secret_name  = (known after apply)
# 
#                           + items {
#                               + key  = (known after apply)
#                               + mode = (known after apply)
#                               + path = (known after apply)
#                             }
#                         }
# 
#                       + vsphere_volume {
#                           + fs_type     = (known after apply)
#                           + volume_path = (known after apply)
#                         }
#                     }
#                 }
#             }
#         }
#     }
# 
#   # kubernetes_namespace.namespace will be created
#   + resource "kubernetes_namespace" "namespace" {
#       + id = (known after apply)
# 
#       + metadata {
#           + generation       = (known after apply)
#           + name             = "nginx"
#           + resource_version = (known after apply)
#           + uid              = (known after apply)
#         }
#     }
# 
#   # kubernetes_service.service will be created
#   + resource "kubernetes_service" "service" {
#       + id                     = (known after apply)
#       + status                 = (known after apply)
#       + wait_for_load_balancer = true
# 
#       + metadata {
#           + generation       = (known after apply)
#           + name             = "nginx"
#           + namespace        = "nginx"
#           + resource_version = (known after apply)
#           + uid              = (known after apply)
#         }
# 
#       + spec {
#           + cluster_ip                  = (known after apply)
#           + external_traffic_policy     = (known after apply)
#           + health_check_node_port      = (known after apply)
#           + publish_not_ready_addresses = false
#           + selector                    = {
#               + "app" = "MyApp"
#             }
#           + session_affinity            = "None"
#           + type                        = "NodePort"
# 
#           + port {
#               + node_port   = 30080
#               + port        = 80
#               + protocol    = "TCP"
#               + target_port = "80"
#             }
#         }
#     }
# 
#   # null_resource.kube_port_forward will be created
#   + resource "null_resource" "kube_port_forward" {
#       + id = (known after apply)
#     }
# 
# Plan: 4 to add, 0 to change, 0 to destroy.
# kubernetes_namespace.namespace: Creating...
# kubernetes_namespace.namespace: Creation complete after 0s [id=nginx]
# kubernetes_deployment.deploy: Creating...
# kubernetes_deployment.deploy: Still creating... [10s elapsed]
# kubernetes_deployment.deploy: Creation complete after 15s [id=nginx/nginx]
# kubernetes_service.service: Creating...
# kubernetes_service.service: Creation complete after 0s [id=nginx/nginx]
# null_resource.kube_port_forward: Creating...
# null_resource.kube_port_forward: Provisioning with 'local-exec'...
# null_resource.kube_port_forward (local-exec): Executing: ["/bin/sh" "-c" "ssh root@192.168.1.12 'systemctl start kubectl-port-forward.service' "]
# root@192.168.1.12's password: 
# null_resource.kube_port_forward: Creation complete after 9s [id=5783550681831335722]
# 
# Apply complete! Resources: 4 added, 0 changed, 0 destroyed.


# Verifique se os pods do Kubernetes foram criados, executando o comando abaixo:
# 
# $ kubectl get pods -n nginx
# NAME                     READY   STATUS    RESTARTS   AGE
# nginx-56598658c8-dcmdp   1/1     Running   0          5m56s
# nginx-56598658c8-g2dv7   1/1     Running   0          5m56s
# nginx-56598658c8-kz464   1/1     Running   0          5m56s
# nginx-56598658c8-qqz7f   1/1     Running   0          5m56s


# Teste a conectividade com a aplicação executando o comando abaixo:
# 
# $ curl 192.168.1.12:30080
# <!DOCTYPE html>
# <html>
# <head>
# <title>Welcome to nginx!</title>
# <style>
# html { color-scheme: light dark; }
# body { width: 35em; margin: 0 auto;
# font-family: Tahoma, Verdana, Arial, sans-serif; }
# </style>
# </head>
# <body>
# <h1>Welcome to nginx!</h1>
# <p>If you see this page, the nginx web server is successfully installed and
# working. Further configuration is required.</p>
# 
# <p>For online documentation and support please refer to
# <a href="http://nginx.org/">nginx.org</a>.<br/>
# Commercial support is available at
# <a href="http://nginx.com/">nginx.com</a>.</p>
# 
# <p><em>Thank you for using nginx.</em></p>
# </body>
# </html>


# Execute o comando "terraform destroy" para destruir o ambiente, conforme abaixo:
# 
# $ terraform apply -auto-approve -destroy
# kubernetes_namespace.namespace: Refreshing state... [id=nginx]
# kubernetes_deployment.deploy: Refreshing state... [id=nginx/nginx]
# kubernetes_service.service: Refreshing state... [id=nginx/nginx]
# null_resource.kube_port_forward: Refreshing state... [id=5783550681831335722]
# 
# Note: Objects have changed outside of Terraform
# 
# Terraform detected the following changes made outside of Terraform since the last "terraform apply":
# 
#   # kubernetes_deployment.deploy has been changed
#   ~ resource "kubernetes_deployment" "deploy" {
#         id               = "nginx/nginx"
#         # (1 unchanged attribute hidden)
# 
#       ~ metadata {
#           + annotations      = {}
#           + labels           = {}
#             name             = "nginx"
#             # (4 unchanged attributes hidden)
#         }
# 
#       ~ spec {
#             # (5 unchanged attributes hidden)
# 
# 
# 
#           ~ template {
#               ~ metadata {
#                   + annotations = {}
#                     # (2 unchanged attributes hidden)
#                 }
# 
#               ~ spec {
#                   + node_selector                    = {}
#                     # (10 unchanged attributes hidden)
# 
#                   ~ container {
#                       + args                       = []
#                       + command                    = []
#                         name                       = "nginx-container"
#                         # (7 unchanged attributes hidden)
# 
# 
#                         # (2 unchanged blocks hidden)
#                     }
#                 }
#             }
#             # (2 unchanged blocks hidden)
#         }
#     }
#   # kubernetes_namespace.namespace has been changed
#   ~ resource "kubernetes_namespace" "namespace" {
#         id = "nginx"
# 
#       ~ metadata {
#           + annotations      = {}
#           + labels           = {}
#             name             = "nginx"
#             # (3 unchanged attributes hidden)
#         }
#     }
#   # kubernetes_service.service has been changed
#   ~ resource "kubernetes_service" "service" {
#         id                     = "nginx/nginx"
#         # (2 unchanged attributes hidden)
# 
#       ~ metadata {
#           + annotations      = {}
#           + labels           = {}
#             name             = "nginx"
#             # (4 unchanged attributes hidden)
#         }
# 
#       ~ spec {
#           + external_ips                = []
#           + load_balancer_source_ranges = []
#             # (7 unchanged attributes hidden)
# 
#             # (1 unchanged block hidden)
#         }
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
#   # kubernetes_deployment.deploy will be destroyed
#   - resource "kubernetes_deployment" "deploy" {
#       - id               = "nginx/nginx" -> null
#       - wait_for_rollout = true -> null
# 
#       - metadata {
#           - annotations      = {} -> null
#           - generation       = 1 -> null
#           - labels           = {} -> null
#           - name             = "nginx" -> null
#           - namespace        = "nginx" -> null
#           - resource_version = "3069" -> null
#           - uid              = "4e5d612d-ff53-4991-b2d6-2326ef8fd175" -> null
#         }
# 
#       - spec {
#           - min_ready_seconds         = 0 -> null
#           - paused                    = false -> null
#           - progress_deadline_seconds = 600 -> null
#           - replicas                  = "4" -> null
#           - revision_history_limit    = 10 -> null
# 
#           - selector {
#               - match_labels = {
#                   - "app" = "MyApp"
#                 } -> null
#             }
# 
#           - strategy {
#               - type = "RollingUpdate" -> null
# 
#               - rolling_update {
#                   - max_surge       = "25%" -> null
#                   - max_unavailable = "25%" -> null
#                 }
#             }
# 
#           - template {
#               - metadata {
#                   - annotations = {} -> null
#                   - generation  = 0 -> null
#                   - labels      = {
#                       - "app" = "MyApp"
#                     } -> null
#                 }
# 
#               - spec {
#                   - active_deadline_seconds          = 0 -> null
#                   - automount_service_account_token  = true -> null
#                   - dns_policy                       = "ClusterFirst" -> null
#                   - enable_service_links             = true -> null
#                   - host_ipc                         = false -> null
#                   - host_network                     = false -> null
#                   - host_pid                         = false -> null
#                   - node_selector                    = {} -> null
#                   - restart_policy                   = "Always" -> null
#                   - share_process_namespace          = false -> null
#                   - termination_grace_period_seconds = 30 -> null
# 
#                   - container {
#                       - args                       = [] -> null
#                       - command                    = [] -> null
#                       - image                      = "nginx" -> null
#                       - image_pull_policy          = "Always" -> null
#                       - name                       = "nginx-container" -> null
#                       - stdin                      = false -> null
#                       - stdin_once                 = false -> null
#                       - termination_message_path   = "/dev/termination-log" -> null
#                       - termination_message_policy = "File" -> null
#                       - tty                        = false -> null
# 
#                       - port {
#                           - container_port = 80 -> null
#                           - host_port      = 0 -> null
#                           - protocol       = "TCP" -> null
#                         }
# 
#                       - resources {}
#                     }
#                 }
#             }
#         }
#     }
# 
#   # kubernetes_namespace.namespace will be destroyed
#   - resource "kubernetes_namespace" "namespace" {
#       - id = "nginx" -> null
# 
#       - metadata {
#           - annotations      = {} -> null
#           - generation       = 0 -> null
#           - labels           = {} -> null
#           - name             = "nginx" -> null
#           - resource_version = "2998" -> null
#           - uid              = "762fa6e4-d225-44c1-8169-35d427b7b5cc" -> null
#         }
#     }
# 
#   # kubernetes_service.service will be destroyed
#   - resource "kubernetes_service" "service" {
#       - id                     = "nginx/nginx" -> null
#       - status                 = [
#           - {
#               - load_balancer = [
#                   - {
#                       - ingress = []
#                     },
#                 ]
#             },
#         ] -> null
#       - wait_for_load_balancer = true -> null
# 
#       - metadata {
#           - annotations      = {} -> null
#           - generation       = 0 -> null
#           - labels           = {} -> null
#           - name             = "nginx" -> null
#           - namespace        = "nginx" -> null
#           - resource_version = "3072" -> null
#           - uid              = "f6e8b2b5-211d-4b9b-9de7-48cd14707c9c" -> null
#         }
# 
#       - spec {
#           - cluster_ip                  = "10.96.21.2" -> null
#           - external_ips                = [] -> null
#           - external_traffic_policy     = "Cluster" -> null
#           - health_check_node_port      = 0 -> null
#           - load_balancer_source_ranges = [] -> null
#           - publish_not_ready_addresses = false -> null
#           - selector                    = {
#               - "app" = "MyApp"
#             } -> null
#           - session_affinity            = "None" -> null
#           - type                        = "NodePort" -> null
# 
#           - port {
#               - node_port   = 30080 -> null
#               - port        = 80 -> null
#               - protocol    = "TCP" -> null
#               - target_port = "80" -> null
#             }
#         }
#     }
# 
#   # null_resource.kube_port_forward will be destroyed
#   - resource "null_resource" "kube_port_forward" {
#       - id = "5783550681831335722" -> null
#     }
# 
# Plan: 0 to add, 0 to change, 4 to destroy.
# null_resource.kube_port_forward: Destroying... [id=5783550681831335722]
# null_resource.kube_port_forward: Provisioning with 'local-exec'...
# null_resource.kube_port_forward (local-exec): Executing: ["/bin/sh" "-c" "ssh root@192.168.1.12 'systemctl stop kubectl-port-forward.service' "]
# root@192.168.1.12's password: 
# null_resource.kube_port_forward: Destruction complete after 4s
# kubernetes_service.service: Destroying... [id=nginx/nginx]
# kubernetes_service.service: Destruction complete after 0s
# kubernetes_deployment.deploy: Destroying... [id=nginx/nginx]
# kubernetes_deployment.deploy: Destruction complete after 0s
# kubernetes_namespace.namespace: Destroying... [id=nginx]
# kubernetes_namespace.namespace: Destruction complete after 6s
# 
# Apply complete! Resources: 0 added, 0 changed, 4 destroyed.

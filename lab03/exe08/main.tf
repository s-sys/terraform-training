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
      version = "~> 2.23.0"
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
# SHA256:VHtKtxfT23tzVSM4iLFaFYyJpEo/3+RQwUk10Ze0QNU azureroot@t01-tf201
# The key's randomart image is:
# +---[RSA 3072]----+
# |    ..++***oooo  |
# |    .. =*ooooo.E |
# | . .   =..oo+oo.o|
# |. o   +. . +...o=|
# | . o o .S . . ..o|
# |    o =      .  o|
# |     . o       oo|
# |                +|
# |                 |
# +----[SHA256]-----+


# Adicione a chave SSH do usuário azureroot disponível em "~/.ssh/id_rsa.pub"
# dentro do arquivo "/root/.ssh/authorized_keys" do usuário root do servidor
# k8s em 192.168.1.12. Esta etapa é importante para que não seja exigida
# senha durante o processo de execução do serviço "kubectl fort-forward" no
# servidor minikube. O comando abaixo realizará está função:

# ssh-copy-id -i ~/.ssh/id_rsa.pub root@k8s


# Execute o comando abaixo para inicializar o diretório do terraform e verifique
# a saída do comando:
#
# $ terraform init
# 
# Initializing the backend...
# 
# Initializing provider plugins...
# - Finding latest version of hashicorp/null...
# - Finding hashicorp/kubernetes versions matching "~> 2.23.0"...
# - Installing hashicorp/kubernetes v2.23.0...
# - Installed hashicorp/kubernetes v2.23.0 (signed by HashiCorp)
# - Installing hashicorp/null v3.2.1...
# - Installed hashicorp/null v3.2.1 (signed by HashiCorp)
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
# Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following
# symbols:
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
#                   + scheduler_name                   = (known after apply)
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
#                     }
#                 }
#             }
#         }
#     }
# 
#   # kubernetes_namespace.namespace will be created
#   + resource "kubernetes_namespace" "namespace" {
#       + id                               = (known after apply)
#       + wait_for_default_service_account = false
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
#           + allocate_load_balancer_node_ports = true
#           + cluster_ip                        = (known after apply)
#           + cluster_ips                       = (known after apply)
#           + external_traffic_policy           = (known after apply)
#           + health_check_node_port            = (known after apply)
#           + internal_traffic_policy           = (known after apply)
#           + ip_families                       = (known after apply)
#           + ip_family_policy                  = (known after apply)
#           + publish_not_ready_addresses       = false
#           + selector                          = {
#               + "app" = "MyApp"
#             }
#           + session_affinity                  = "None"
#           + type                              = "NodePort"
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
# kubernetes_deployment.deploy: Creation complete after 7s [id=nginx/nginx]
# kubernetes_service.service: Creating...
# kubernetes_service.service: Creation complete after 0s [id=nginx/nginx]
# null_resource.kube_port_forward: Creating...
# null_resource.kube_port_forward: Provisioning with 'local-exec'...
# null_resource.kube_port_forward (local-exec): Executing: ["/bin/sh" "-c" "ssh root@192.168.1.12 'systemctl start kubectl-port-forward.service' "]
# null_resource.kube_port_forward: Creation complete after 1s [id=83889128003913616]
# 
# Apply complete! Resources: 4 added, 0 changed, 0 destroyed.


# Verifique se os pods do Kubernetes foram criados, executando o comando abaixo:
# 
# $ kubectl get pods -n nginx
# NAME                    READY   STATUS    RESTARTS   AGE
# nginx-f66bbc6cf-bkk7h   1/1     Running   0          94s
# nginx-f66bbc6cf-cmsfb   1/1     Running   0          94s
# nginx-f66bbc6cf-kpgnp   1/1     Running   0          94s
# nginx-f66bbc6cf-vnmrd   1/1     Running   0          94s


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
# null_resource.kube_port_forward: Refreshing state... [id=83889128003913616]
# 
# Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following
# symbols:
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
#           - resource_version = "13850" -> null
#           - uid              = "cd682744-c0b5-47e7-be59-784efefd94f4" -> null
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
#                   - scheduler_name                   = "default-scheduler" -> null
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
#                       - resources {
#                           - limits   = {} -> null
#                           - requests = {} -> null
#                         }
#                     }
#                 }
#             }
#         }
#     }
# 
#   # kubernetes_namespace.namespace will be destroyed
#   - resource "kubernetes_namespace" "namespace" {
#       - id                               = "nginx" -> null
#       - wait_for_default_service_account = false -> null
# 
#       - metadata {
#           - annotations      = {} -> null
#           - generation       = 0 -> null
#           - labels           = {} -> null
#           - name             = "nginx" -> null
#           - resource_version = "13789" -> null
#           - uid              = "a36a78ee-1c18-4fbd-857b-53844a0c893c" -> null
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
#           - resource_version = "13856" -> null
#           - uid              = "1ef7b813-333c-4aba-9a1c-15e049513047" -> null
#         }
# 
#       - spec {
#           - allocate_load_balancer_node_ports = true -> null
#           - cluster_ip                        = "10.100.111.29" -> null
#           - cluster_ips                       = [
#               - "10.100.111.29",
#             ] -> null
#           - external_ips                      = [] -> null
#           - external_traffic_policy           = "Cluster" -> null
#           - health_check_node_port            = 0 -> null
#           - internal_traffic_policy           = "Cluster" -> null
#           - ip_families                       = [
#               - "IPv4",
#             ] -> null
#           - ip_family_policy                  = "SingleStack" -> null
#           - load_balancer_source_ranges       = [] -> null
#           - publish_not_ready_addresses       = false -> null
#           - selector                          = {
#               - "app" = "MyApp"
#             } -> null
#           - session_affinity                  = "None" -> null
#           - type                              = "NodePort" -> null
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
#       - id = "83889128003913616" -> null
#     }
# 
# Plan: 0 to add, 0 to change, 4 to destroy.
# null_resource.kube_port_forward: Destroying... [id=83889128003913616]
# null_resource.kube_port_forward: Provisioning with 'local-exec'...
# null_resource.kube_port_forward (local-exec): Executing: ["/bin/sh" "-c" "ssh root@192.168.1.12 'systemctl stop kubectl-port-forward.service' "]
# null_resource.kube_port_forward: Destruction complete after 1s
# kubernetes_service.service: Destroying... [id=nginx/nginx]
# kubernetes_service.service: Destruction complete after 0s
# kubernetes_deployment.deploy: Destroying... [id=nginx/nginx]
# kubernetes_deployment.deploy: Destruction complete after 0s
# kubernetes_namespace.namespace: Destroying... [id=nginx]
# kubernetes_namespace.namespace: Destruction complete after 6s
# 
# Destroy complete! Resources: 4 destroyed.

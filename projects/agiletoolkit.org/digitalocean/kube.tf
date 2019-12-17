resource "digitalocean_kubernetes_cluster" "atk" {
  name = "atk"
  region = "lon1"
  version = "1.16.2-do.1"
  tags = ["production"]
  //noinspection MissingProperty
  node_pool {
    name = "worker-pool"
    size = "s-1vcpu-2gb"
    # node_count = 1
    auto_scale = true
    min_nodes = 1
    max_nodes = 2
  }
}

provider "kubernetes" {
  host  = digitalocean_kubernetes_cluster.atk.endpoint
  token = digitalocean_kubernetes_cluster.atk.kube_config[0].token
  cluster_ca_certificate = base64decode(
    digitalocean_kubernetes_cluster.atk.kube_config[0].cluster_ca_certificate
  )
}

module "tiller_namespace" {
  source = "git::https://github.com/gruntwork-io/terraform-kubernetes-helm.git//modules/k8s-namespace?ref=v0.3.0"
  name = "tiller"
}

module "resource_namespace" {
  source = "git::https://github.com/gruntwork-io/terraform-kubernetes-helm.git//modules/k8s-namespace"
  name = "resources"
}

module "tiller_service_account" {
  source = "git::https://github.com/gruntwork-io/terraform-kubernetes-helm.git//modules/k8s-service-account"

  name           = "tiller"
  namespace      = module.tiller_namespace.name
  num_rbac_roles = 2

  rbac_roles = [
    {
      name      = module.tiller_namespace.rbac_tiller_metadata_access_role
      namespace = module.tiller_namespace.name
    },
    {
      name      = module.resource_namespace.rbac_tiller_resource_access_role
      namespace = module.resource_namespace.name
    },
  ]

  labels = {
    app = "tiller"
  }
}

variable "tls_subject" {
  type        = map(string)
  default = {
    common_name = "tiller"
    org         = "Gruntwork"
  }
}

variable "client_tls_subject" {
  type        = map(string)
  default = {
    common_name = "admin"
    org         = "Gruntwork"
  }
}
variable "tiller_version" {
  description = "The version of Tiller to deploy."
  type        = string
  default     = "v2.11.0"
}
module "tiller" {
  source = "git::https://github.com/gruntwork-io/terraform-kubernetes-helm.git//modules/k8s-tiller"

  tiller_service_account_name              = module.tiller_service_account.name
  tiller_service_account_token_secret_name = module.tiller_service_account.token_secret_name
  namespace                                = module.tiller_namespace.name
  tiller_image_version                     = var.tiller_version

  #tiller_tls_gen_method   = "kubergrunt"
  #tiller_tls_subject      = var.tls_subject
  #private_key_algorithm   = var.private_key_algorithm
  #private_key_ecdsa_curve = var.private_key_ecdsa_curve
  #private_key_rsa_bits    = var.private_key_rsa_bits

  #kubectl_config_context_name = var.kubectl_config_context_name
  #kubectl_config_path         = var.kubectl_config_path
  tiller_tls_secret_name = ""
}




/*
provider helm {

  service_account = "tiller"
  namespace = "kube-system"
  install_tiller = false
  debug = true
  insecure = true
  tiller_image    = "gcr.io/kubernetes-helm/tiller:v2.11.0"

  kubernetes {
    load_config_file = false

    host  = digitalocean_kubernetes_cluster.atk.endpoint
    token = digitalocean_kubernetes_cluster.atk.kube_config[0].token
    cluster_ca_certificate = base64decode(
      digitalocean_kubernetes_cluster.atk.kube_config[0].cluster_ca_certificate
    )
  }
}
*/
module "kube" {
  source = "./kube"
}

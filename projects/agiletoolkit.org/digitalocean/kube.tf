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

variable "GITHUB_OAUTH" {}
variable "TFE_ORG" {}

module "atk4-kube" {
  source = "../../../root/workspace"
  name = "atk4-kube"
  path = "projects/agiletoolkit.org/kube"
  github_oauth = var.GITHUB_OAUTH
  tfe_org = var.TFE_ORG

  env = {
  }

}

/*
provider "kubernetes" {
  host  = digitalocean_kubernetes_cluster.atk.endpoint
  token = digitalocean_kubernetes_cluster.atk.kube_config[0].token
  cluster_ca_certificate = base64decode(
    digitalocean_kubernetes_cluster.atk.kube_config[0].cluster_ca_certificate
  )
}

module "tiller" {
  source = "git::https://github.com/iplabs/terraform-kubernetes-tiller"

}



provider helm {

  install_tiller = false
  debug = true
  insecure = true

  kubernetes {
    load_config_file = false

    host  = "https://${digitalocean_kubernetes_cluster.atk.endpoint}"
    token = digitalocean_kubernetes_cluster.atk.kube_config[0].token
    cluster_ca_certificate = base64decode(
      digitalocean_kubernetes_cluster.atk.kube_config[0].cluster_ca_certificate
    )
  }
}
module "kube" {
  source = "./kube"
}
*/

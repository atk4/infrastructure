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

module "tiller" {
  source  = "github.com/sagikazarmark/terraform-tiller"
  version = "~> 0.1.0"
}

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

module "kube" {
  source = "./kube"
}

data "digitalocean_kubernetes_versions" "example" {}

resource "digitalocean_kubernetes_cluster" "atk" {
  lifecycle {
    ignore_changes = ["version"]
  }
  name = "atk"
  region = "lon1"
  version = data.digitalocean_kubernetes_versions.example.latest_version
  #version = "1.16.6-do.2"
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
resource "digitalocean_project_resources" "barfoo" {
  project = digitalocean_project.atk.id
  resources = [
    "do:kubernetes:${digitalocean_kubernetes_cluster.atk.id}"
  ]
}


variable "GITHUB_OAUTH" {}
variable "TFE_ORG" {}
variable "DIGITALOCEAN_TOKEN" {}

module "atk4-kube" {
  source = "../../../root/workspace"
  name = "atk4-kube"
  path = "projects/agiletoolkit.org/kube"
  github_oauth = var.GITHUB_OAUTH
  tfe_org = var.TFE_ORG

  env = {
    TF_VAR_KUBE_HOST: digitalocean_kubernetes_cluster.atk.endpoint
    TF_VAR_KUBE_TOKEN: digitalocean_kubernetes_cluster.atk.kube_config[0].token
    TF_VAR_KUBE_CERT: digitalocean_kubernetes_cluster.atk.kube_config[0].cluster_ca_certificate

    TF_VAR_DIGITALOCEAN_TOKEN: var.DIGITALOCEAN_TOKEN
    DIGITALOCEAN_TOKEN: var.DIGITALOCEAN_TOKEN
  }
}


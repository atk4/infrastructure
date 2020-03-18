variable "KUBE_HOST" {}
variable "KUBE_TOKEN" {}
variable "KUBE_CERT" {}
variable "DIGITALOCEAN_TOKEN" {}


provider "kubernetes" {
  host  = var.KUBE_HOST
  token = var.KUBE_TOKEN
  cluster_ca_certificate = base64decode(var.KUBE_CERT)
}

/*
provider helm {

  install_tiller = false
  debug = true
  insecure = true

  kubernetes {
    load_config_file = false

    host  = var.KUBE_HOST
    token = var.KUBE_TOKEN
    cluster_ca_certificate = base64decode(var.KUBE_CERT)

  }
}
*/

variable "KUBE_HOST" {}
variable "KUBE_TOKEN" {}
variable "KUBE_CERT" {}

provider "kubernetes" {
  load_config_file = false
  host  = var.KUBE_HOST
  token = var.KUBE_TOKEN
  cluster_ca_certificate = base64decode(var.KUBE_CERT)
}

# provider mysql

variable "name" {}

resource "kubernetes_namespace" "apps" {
  metadata {
    name = var.name
  }
}

variable "creds" {
}

resource "kubernetes_secret" "example" {

  metadata {
    name = "docker-cfg"
    namespace = var.name
  }

  data = {
    ".dockerconfigjson" = var.creds
  }

  type = "kubernetes.io/dockerconfigjson"
}



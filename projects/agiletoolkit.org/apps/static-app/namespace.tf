# provider mysql

variable "name" {}

resource "kubernetes_namespace" "apps" {
  metadata {
    name = var.name
  }
}

variable "creds" {
  default = ""
}

resource "kubernetes_secret" "example" {
  count = var.creds == ""?0:1

  metadata {
    name = "docker-cfg"
    namespace = var.name
  }

  data = {
    ".dockerconfigjson" = var.creds
  }

  type = "kubernetes.io/dockerconfigjson"
}



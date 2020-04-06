# provider mysql

variable "name" {}

resource "kubernetes_namespace" "apps" {
  metadata {
    name = var.name
  }
}


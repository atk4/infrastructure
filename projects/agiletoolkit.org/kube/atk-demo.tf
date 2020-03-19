# Provision space for atk-ui

resource "kubernetes_namespace" "db" {
  metadata {
    name = "atk-ui"
  }
}

# Provision space for atk-ui

resource "kubernetes_namespace" "atk-ui" {
  metadata {
    name = "atk-demo"
  }
}

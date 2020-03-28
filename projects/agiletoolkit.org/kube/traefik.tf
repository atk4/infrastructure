# Will install traefik here
resource "kubernetes_namespace" "traefik" {
  metadata {
    name = "traefik"
  }
}


# Will install traefik here
resource "kubernetes_namespace" "argo" {
  metadata {
    name = "argocd"
  }
}


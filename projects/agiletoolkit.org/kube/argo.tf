resource "kubernetes_namespace" "argo" {
  metadata {
    name = "argo"
  }
}

data "helm_repository" "argocd" {
  name = "argo"
  url = "https://argoproj.github.io/argo-helm"
}

resource "helm_release" "argocd" {
  chart = "argo-cd"
  name = "argo"
  namespace = "argo"
  repository = data.helm_repository.argocd.url
}

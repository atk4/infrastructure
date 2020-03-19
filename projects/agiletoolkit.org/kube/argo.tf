resource "kubernetes_namespace" "argo" {
  metadata {
    name = "argocd"
  }
}

data "helm_repository" "argocd" {
  name = "argo"
  url = "https://argoproj.github.io/argo-helm"
}

resource "helm_release" "argocd" {
  chart = "argo-cd"
  name = "argo"
  namespace = "argocd"
  repository = data.helm_repository.argocd.url
}

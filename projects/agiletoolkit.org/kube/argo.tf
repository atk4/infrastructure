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


  set {
    name="server.ingress.enabled"
    value="true"
  }

}

resource "kubernetes_cluster_role_binding" "argo-role-binding" {
  metadata {
    name = "argo-role-binding"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind = "ClusterRole"
    name = "cluster-admin"
  }
  subject {
    kind = "User"
    name = "me@nearly.guru"
  }
}

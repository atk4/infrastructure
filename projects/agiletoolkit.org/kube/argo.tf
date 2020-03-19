resource "kubernetes_namespace" "argo" {
  metadata {
    name = "argocd"
  }
}

resource "random_password" "argo" {
  length = 10
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
  set {
    name="server.service.type"
    value="LoadBalancer"
  }
  set {
    name = "configs.secret.argocdServerAdminPassword"
    value = bcrypt(random_password.argo.result)
  }

  lifecycle {
    ignore_changes = [
      values
      # password value seems to always change
    ]
  }
}

output "argo-password" {
  value = random_password.argo.result
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

resource "kubernetes_namespace" "argo" {
  metadata {
    name = "argocd"
  }
}

resource "random_password" "argo" {
  length = 10
}

resource "helm_release" "argocd" {
  repository = "https://argoproj.github.io/argo-helm"
  chart = "argo-cd"
  version = "2.7.0"
  name = "argo"
  namespace = "argocd"


  set {
    name="server.ingress.enabled"
    value="true"
  }
  set {
    name="server.service.type"
    value="ClusterIP"
  }
  set {
    name = "configs.secret.argocdServerAdminPassword"
    value = bcrypt(random_password.argo.result)
  }


  values = [
    <<YAML
server:
  ingress:
    enabled: true
    annotations:
      kubernetes.io/ingress.class: traefik
    hosts: ["argocd.agiletoolkit.org"]
  extraArgs: [ "--insecure" ]
YAML
  ]

  lifecycle {
    ignore_changes = [
      set
      # password value seems to always change
    ]
  }
}

//data "kubernetes_service" "argocd" {
//  depends_on = [helm_release.argocd]
//  metadata {
//    namespace = "argocd"
//    name = "argo-argocd-server"
//  }
//}
//
//output "ip" {
//  value = data.kubernetes_service.argocd.load_balancer_ingress.0.ip
//}
//
//resource "digitalocean_record" "argocd" {
//  domain = "agiletoolkit.org"
//  type = "A"
//  name = "argocd"
//  ttl = 60
//  value = data.kubernetes_service.argocd.load_balancer_ingress.0.ip
//}

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


resource "digitalocean_record" "argocd" {
  domain = "agiletoolkit.org"
  type = "CNAME"
  name = "argocd"
  value = "trefik.agiletoolkit.org."
}

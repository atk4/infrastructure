resource "helm_release" "cilium" {
  chart = "cilium"
  version = "1.9.1"
  name = "cilium"
  namespace = "kube-system"
  repository = "https://helm.cilium.io/"
}



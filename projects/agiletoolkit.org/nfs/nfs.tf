resource "kubernetes_namespace" "ns" {
  metadata {
    name = "nfs-server"
  }
}
data "helm_repository" "storage-charts" {
  name = "argo"
  url = "https://kubernetes-charts.storage.googleapis.com/"
}

resource "helm_release" "nfs-server" {
  chart = "nfs-server-provisioner"
  version = "1.0.0"
  name = "nfs-server"
  namespace = "nfs-server"
  repository = data.helm_repository.storage-charts.url


  set {
    name="persistence.enabled"
    value="true"
  }
  set {
    name="persistence.storageClass"
    value="do-block-storage"
  }
  set {
    name = "persistence.size"
    value = "200Gi"
  }
  set {
    name = "storageClass.create"
    value = "false"
  }
  set {
    name = "storageClass.provisionerName"
    value = "atk-storage"
  }
  set {
    name = "storageClass.reclaimPolicy"
    value = "Retain"
  }
}

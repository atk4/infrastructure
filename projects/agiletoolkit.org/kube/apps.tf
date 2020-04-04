resource "kubernetes_namespace" "apps" {
  metadata {
    name = "apps"
  }
}

resource "kubernetes_cluster_role" "codefresh" {
  metadata {
    name = "codefresh-role"
  }
  rule {
    api_groups = ["apps"]
    resources = ["deployments"]
    verbs = ["get", "patch"]
  }
}

// system:serviceaccount:kube-system:codefresh-user"
// cannot list resource "namespaces" in API group "" at
// the cluster scope: RBAC: clusterrole.rbac.authorization.k8s.io "codefresh-role" not found

resource "kubernetes_service_account" "codefresh" {
  metadata {
    namespace = "kube-system"
    name = "codefresh-user"
  }
}

resource "kubernetes_cluster_role_binding" "codefresh" {
  metadata {
    name = "codefresh-binding"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind = "ClusterRole"
    name = "codefresh-role"
  }
  subject {
    kind = "ServiceAccount"
    namespace = "kube-system"
    name = "codefresh-user"
  }
}



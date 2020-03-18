# Create namespace "db" in kubernetes, launch mysql there and record root password into "kube-system" namespace

resource "kubernetes_namespace" "test" {
  metadata {
    name = "db"
  }
}

resource "random_password" "root" {
  length = 10
}

resource "kubernetes_secret" "db-password" {
  metadata {
    name = "db-password"
    namespace = "kube-system"
  }

  data = {
    MYSQL_PASSWORD=random_password.root.result
  }
}

resource "helm_release" "db" {
  chart = "bitnami/mariadb"
  #repository = helm_repository.bitnami.name
  name = "db"
  namespace = "db"

  values = [
    "${file("mariadb.yaml")}"
  ]

  set { name="db.name" value="saasty" }
  set { name="db.user" value="saasty" }
  set { name="db.password" value=random_password.root.result }
}


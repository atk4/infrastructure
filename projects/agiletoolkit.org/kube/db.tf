# Create namespace "db" in kubernetes, launch mysql there and record root password into "kube-system" namespace


/*
resource "helm_release" "db" {
  chart = "bitnami/mariadb"
  #repository = helm_repository.bitnami.name
  name = "db"
  namespace = "db"

  values = [
    "${file("mariadb.yaml")}"
  ]

  set {
    name="db.name"
    value="saasty"
  }
  set {
    name="db.user"
    value="saasty"
  }
  set {
    name="db.password"
    value=random_password.root.result
  }
}
*/

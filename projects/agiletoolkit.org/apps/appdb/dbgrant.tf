# provider mysql

variable "name" {}

variable "host" {}

resource "mysql_database" "atk-demo" {
  name = "ui.agiletoolkit.org"
}

resource "random_password" "atk-demo" {
  length = 10
}

resource "mysql_user" "atk-demo" {
  user = var.name
  host = "%"
  plaintext_password = random_password.atk-demo.result
}

resource "mysql_grant" "atk-demo" {
  user = mysql_user.atk-demo.user
  host = mysql_user.atk-demo.host
  database = mysql_database.atk-demo.name
  privileges = ["all privileges"]
}

output "up" {
  value = "${var.name}:${random_password.atk-demo.result}"
}


resource "kubernetes_secret" "this_tls" {

  metadata {
    name      = "db-connection"
    namespace = var.name

    /*
    labels = {
      "app.kubernetes.io/name"       = "helm"
      "app.kubernetes.io/component"  = "tiller"
      "app.kubernetes.io/managed-by" = "terraform"
    }
    */
  }

  data = {
    "dsn" = "mysql://${var.name}:${random_password.atk-demo.result}@${var.host}"
    "tls.crt" = var.tiller_tls.cert_pem
    "ca.crt"  = var.tiller_tls.ca_cert_pem
  }
}

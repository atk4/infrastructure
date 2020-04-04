# provider mysql

variable "name" {}

variable "host" {}

resource "mysql_database" "atk-demo" {
  name = "ui.agiletoolkit.org"
}

resource "random_password" "atk-demo" {
  length = 10
}
resource "random_password" "atk-demo-ro" {
  length = 10
}

resource "mysql_user" "atk-demo" {
  user = var.name
  host = "%"
  plaintext_password = random_password.atk-demo.result
}
resource "mysql_user" "atk-demo-ro" {
  user = var.name
  host = "%"
  plaintext_password = random_password.atk-demo.result
}

resource "mysql_grant" "atk-demo-ro" {
  user = mysql_user.atk-demo-ro.user
  host = mysql_user.atk-demo.host
  database = mysql_database.atk-demo.name
  privileges = ["SELECT"]
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

resource "kubernetes_namespace" "apps" {
  metadata {
    name = var.name
  }
}

resource "kubernetes_secret" "app-dns" {

  metadata {
    name      = "db-connection"
    namespace = var.name
  }

  data = {
    "admin_dsn" = "mysql://${var.name}:${random_password.atk-demo.result}@${var.host}/${var.name}"
    "ro_dsn" = "mysql://${var.name}:${random_password.atk-demo.result}@${var.host}/${var.name}"
  }
}

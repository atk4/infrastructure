# provider mysql

variable "name" {}

variable "host" {}

variable "permissions" {
  type = map(string)
}

resource "mysql_database" "atk-demo" {
  name = "ui.agiletoolkit.org"
}

resource "random_password" "atk-demo" {
  for_each = var.permissions

  length = 10
}

resource "mysql_user" "atk-demo" {
  for_each = var.permissions

  user = "${var.name}-${each.key}"
  plaintext_password = random_password.atk-demo[each.key].result
}

resource "mysql_grant" "atk-demo" {
  for_each = var.permissions

  user = mysql_user.atk-demo[each.key].user
  host = mysql_user.atk-demo.host
  database = mysql_database.atk-demo.name
  privileges = [each.value]
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
    for p in var.permissions:

    "${p}_dsn" => "mysql://${var.name}-${p}:${random_password.atk-demo.result}@${var.host}/${var.name}"
  }
}

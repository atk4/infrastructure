# provider mysql

variable "name" {
}

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

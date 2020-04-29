
provider "mysql" {}

variable "MYSQL_ENDPOINT" {}
variable "MYSQL_USERNAME" {}
variable "MYSQL_PASSWORD" {}



# Regular full-access mysql grant
module "atk-demo" {
  source = "./basic-app"

  host = var.MYSQL_ENDPOINT
  name = "atk-demo"

  permissions = {
    "admin": "all privileges"
    "ro": "select"
  }
}

# Saasty preview app context
module "saasty-preview" {
  source = "./static-app"
  name = "saasty-preview"
}
resource "mysql_database" "atk-demo" {
  name = "saasty-preview"
}
resource "kubernetes_secret" "app-extra-dsn" {
  metadata {
    name      = "admin-connection"
    namespace = "saasty-preview"
  }
  data = {
    "admin_dsn": "mysql://${var.MYSQL_USERNAME}:${var.MYSQL_PASSWORD}@${var.MYSQL_ENDPOINT}/saasty-preview"
  }
}



module "saasty-landing" {
  source = "./static-app"

  name = "saasty-landing"
}

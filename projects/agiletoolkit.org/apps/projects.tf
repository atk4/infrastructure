
provider "mysql" {}

variable "MYSQL_ENDPOINT" {}
variable "MYSQL_USERNAME" {}
variable "MYSQL_PASSWORD" {}
variable "DOCKER_CREDS" {}

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

# Regular full-access mysql grant
module "atk-demo-develop" {
  source = "./basic-app"

  host = var.MYSQL_ENDPOINT
  name = "atk-demo-develop"

  permissions = {
    "admin": "all privileges"
    "ro": "select"
  }
}

# Regular full-access mysql grant
module "agiletoolkit-org" {
  source = "./basic-app"

  host = var.MYSQL_ENDPOINT
  name = "agiletoolkit-org"

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
  lifecycle {
    prevent_destroy = true
  }
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
module "nearly-guru" {
  source = "./static-app"

  name = "nearly-guru"
  creds = var.DOCKER_CREDS
}

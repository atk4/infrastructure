
provider "mysql" {}

variable "MYSQL_ENDPOINT" {}



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
  source = "./basic-app"

  host = var.MYSQL_ENDPOINT
  name = "saasty-preview"

  permissions = {
    "admin": "all privileges"
    "ro": "select"
  }
}

module "saasty-landing" {
  source = "./static-app"

  name = "saasty-landing"
}

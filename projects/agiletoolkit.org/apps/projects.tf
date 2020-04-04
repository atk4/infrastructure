
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

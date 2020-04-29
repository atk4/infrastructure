
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

#explicitly allow saasty preview admin to access saasty_* databases
resource "mysql_grant" "atk-demo" {
  user = "saasty-preview-admin"
  host = "%"
  database = "saasty_%"
  privileges = ["all privileges"]
  grant = true
}


module "saasty-landing" {
  source = "./static-app"

  name = "saasty-landing"
}

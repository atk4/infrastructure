
provider "mysql" {}

variable "MYSQL_ENDPOINT" {}



# Regular full-access mysql grant
module "atk-demo" {
  source = "./appdb"

  name = "atk-demo"
}

output "atk-demo" {
  value = "mysql://${module.atk-demo.up}@${var.MYSQL_ENDPOINT}:/atk-demo"
}
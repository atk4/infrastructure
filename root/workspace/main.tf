variable "org" {
  default = "atk4"
}
variable "name" {}
resource "tfe_workspace" "wks" {
  name = var.name
  organization = var.org
}
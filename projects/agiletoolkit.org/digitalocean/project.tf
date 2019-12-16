resource "digitalocean_project" "atk" {
  name = "atk4"
  description = "Agile Toolkit Resources"
  purpose = "Web Application"
  environment = "Production"
}
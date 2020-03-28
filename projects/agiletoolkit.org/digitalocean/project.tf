resource "digitalocean_project" "atk" {
  name = "atk"
  description = "Agile Toolkit Resources"
  purpose = "Web Application"
  environment = "Production"
}
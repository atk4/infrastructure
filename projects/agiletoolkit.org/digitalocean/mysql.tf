resource "digitalocean_database_cluster" "db" {
  engine = "mysql"
  name = "atk"
  node_count = 1
  region = "lon1"
  size = "db-s-1vcpu-1gb"
  version = "8"
}
resource "digitalocean_project_resources" "db_atk" {
  project = digitalocean_project.atk.id
  resources = [ digitalocean_database_cluster.db.urn ]
}

output "db_database" {
  value = digitalocean_database_cluster.db.database
}
output "db_user" {
  value = digitalocean_database_cluster.db.user
}
output "db_password" {
  value = digitalocean_database_cluster.db.password
}

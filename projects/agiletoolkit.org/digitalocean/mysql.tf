resource "digitalocean_database_cluster" "db" {
  engine = "mysql"
  name = "atk"
  node_count = 1
  region = "lon1"
  size = "50"
}
resource "digitalocean_project_resources" "db_atk" {
  project = digitalocean_project.atk.id
  resources = [ digitalocean_database_cluster.db.urn ]
}

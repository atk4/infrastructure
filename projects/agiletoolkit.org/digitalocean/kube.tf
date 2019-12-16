resource "digitalocean_kubernetes_cluster" "atk" {
  name = "atk4"
  region = "lon1"
  version = "1.16.2-do.1"
  tags = ["production"]
  node_pool {
    name = "worker-pool"
    size = "s-1vcpu-2gb"
    # node_count = 1
    auto_scale = true
    min_nodes = 1
    max_nodes = 2
  }
}
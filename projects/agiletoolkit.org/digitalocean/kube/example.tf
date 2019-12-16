
resource "kubernetes_service" "example" {
  metadata {
    name = "example"
  }
  spec {
    type = "LoadBalancer"
    selector {
      app: example
    }
    port {
      port = 80
      protocol = "TCP"
      target_port = 80
    }
  }
}

resource "kubernetes_deployment" "example" {
  metadata {
    name = "example"
  }
  spec {
    replicas = 2
    selector {
      match_labels {
        app: example
      }
    }
    template {
      metadata {
        labels {
          app: example
        }
      }
      spec {
        container {
          name = "nginx"
          image = "digitalocean/doks-example"
          port {
            container_port = 80
            protocol = "TCP"
          }
        }
      }
    }
  }
}
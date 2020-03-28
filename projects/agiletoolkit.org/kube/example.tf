resource "kubernetes_namespace" "test" {
  metadata {
    name = "test"
  }
}




/*
resource "kubernetes_namespace" "example" {
  metadata {
    name = "example"
  }
}


resource "kubernetes_service" "example" {
  lifecycle {
    //noinspection HILUnresolvedReference
    ignore_changes = [metadata[0].annotations]
  }
  metadata {
    name = "example"
    namespace = "example"
  }
  spec {
    type = "LoadBalancer"
    selector = {
      app = "example"
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
    namespace = "example"
  }
  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "example"
      }
    }
    template {
      metadata {
        labels = {
          app = "example"
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
*/


data "helm_repository" "bitnami" {
  name = "bitnami"
  url = "https://charts.bitnami.com/bitnami"
}

/*
resource "helm_release" "traefik" {
  chart = "stable/traefik"
  name = "traefik"
  namespace = "kube-system"

  values = [ "${file("helm/traefik.yaml")}" ]

}
*/

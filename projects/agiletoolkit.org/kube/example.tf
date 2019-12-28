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

resource "kubernetes_secret" "do-token" {
  metadata {
    name = "acme-dnsprovider-config"
    namespace = "kube-system"
  }

  data = {
    DO_AUTH_TOKEN=var.DIGITALOCEAN_TOKEN
  }

}

resource "random_password" "db_password" {
  length = 10
}

resource "helm_release" "db" {
  chart = "stable/mariadb"
  name = "db"

  set {
    name  = "mariadbUser"
    value = "atk4"
  }

  set {
    name = "mariadbPassword"
    value = random_password.db_password.result
  }

  set_string {
    name = "image.tags"
    value = "registry\\.io/terraform-provider-helm\\,example\\.io/terraform-provider-helm"
  }
}

/*
resource "helm_release" "traefik" {
  chart = "stable/traefik"
  name = "traefik"
  namespace = "kube-system"

  values = [ "${file("helm/traefik.yaml")}" ]

}
*/
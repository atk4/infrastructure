terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
    mysql = {
      source = "terraform-providers/mysql"
    }
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
  }
  required_version = ">= 0.13"
}

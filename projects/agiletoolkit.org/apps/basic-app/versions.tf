terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
    mysql = {
      source = "terraform-providers/mysql"
    }
    random = {
      source = "hashicorp/random"
    }
  }
  required_version = ">= 0.13"
}

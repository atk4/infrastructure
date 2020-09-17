terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
    mysql = {
      source = "terraform-providers/mysql"
    }
  }
  required_version = ">= 0.13"
}

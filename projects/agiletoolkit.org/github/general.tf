terraform {
  backend "remote" {
    organization = "atk4"
    workspaces {
      name = "atk4-github"
    }
  }
  required_providers {
    github = {
      source = "hashicorp/github"
      version = "~> 3.1"
    }
  }
}

terraform {
  backend "remote" {
    organization = "atk4"
    workspaces {
      name = "atk4-github"
    }
  }
  required_providers {
    github = "~> 3.1"
  }
}

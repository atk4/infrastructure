terraform {
  backend "remote" {
    organization = "atk4"
    workspaces {
      name = "atk4-digitalocean"
    }
  }
  providers {
    k8s = "https://github.com/banzaicloud/terraform-provider-k8s.git"
  }
}

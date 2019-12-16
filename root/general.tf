terraform {
  backend "remote" {
    organization = "atk4"
    workspaces {
      name = "atk4-root"
    }
  }
}

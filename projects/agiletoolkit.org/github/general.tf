terraform {
  backend "remote" {
    organization = "atk4"
    workspaces {
      name = "agiletoolkit_org_github"
    }
  }
}

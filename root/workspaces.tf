variable "GITHUB_OAUTH" {}
variable "GITHUB_TOKEN" {}
variable "TFE_ORG" {}
variable "DIGITALOCEAN_TOKEN" {}


module "agiletoolkit_org_github" {
  source = "./workspace"
  name = "atk4-github"
  path = "projects/agiletoolkit.org/github"
  github_oauth = var.GITHUB_OAUTH
  tfe_org = var.TFE_ORG

  env = {
    GITHUB_TOKEN: var.GITHUB_TOKEN
  }

}

/*
module "agiletoolkit_org_github" {
  source = "./workspace"
  name = "agiletoolkit_org_digitalocean"
  path = "projects/agiletoolkit.org/digitalocean"
  github_oauth = var.GITHUB_OAUTH
  tfe_org = var.TFE_ORG

  env = {
    DIGITALOCEAN_TOKEN: var.DIGITALOCEAN_TOKEN
  }

}
*/

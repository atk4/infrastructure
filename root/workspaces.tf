variable "GITHUB_OAUTH" {}
variable "GITHUB_TOKEN" {}
variable "TFE_ORG" {}
variable "DIGITALOCEAN_TOKEN" {}


module "agiletoolkit_org_github" {
  source = "./workspace"
  name = "agiletoolkit_org_github"
  path = "projects/agiletoolkit.org/github"
  github_oauth = var.GITHUB_OAUTH
  tfe_org = var.TFE_ORG

  env = {
    DIGITALOCEAN_TOKEN: var.DIGITALOCEAN_TOKEN
    GITHUB_TOKEN: var.GITHUB_TOKEN
  }

}



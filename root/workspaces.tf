variable "GITHUB_OAUTH" {}
variable "GITHUB_TOKEN" {}
variable "TFE_ORG" {}
variable "DIGITALOCEAN_TOKEN" {}
variable "TFE_TOKEN" {}


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

module "atk4-digitalocean" {
  source = "./workspace"
  name = "atk4-digitalocean"
  path = "projects/agiletoolkit.org/digitalocean"
  github_oauth = var.GITHUB_OAUTH
  tfe_org = var.TFE_ORG

  env = {
    DIGITALOCEAN_TOKEN: var.DIGITALOCEAN_TOKEN
    TFE_TOKEN: var.TFE_TOKEN
    TF_VAR_GITHUB_OAUTH: var.GITHUB_OAUTH
    TF_VAR_TFE_ORG: var.TFE_ORG
  }
}

/*
module "atk4-kube" {
  source = "./workspace"
  name = "atk4-kube"
  path = "projects/agiletoolkit.org/kube"
  github_oauth = var.GITHUB_OAUTH
  tfe_org = var.TFE_ORG

  env = {
    #TFE_TOKEN: var.TFE_TOKEN
  }
}
*/

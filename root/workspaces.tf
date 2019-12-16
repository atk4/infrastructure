variable "GITHUB_OAUTH" {}
variable "TFE_ORG" {}


module "agiletoolkit_org_github" {
  source = "./workspace"
  name = "agiletoolkit.org-github"
  path = "projects/agiletoolkit.org/github"
  github_oauth = var.GITHUB_OAUTH
  tfe_org = var.TFE_ORG
}

/*
*/

variable "GITHUB_OAUTH" {}
variable "TFE_ORG" {}


module "agiletoolkit.org.github" {
  source = "./workspace"
  name = "agiletoolkit.org-github"
  path = "projects/agiletoolkit.org/github"
  github_oauth = var.GITHUB_OAUTH
  tfe_org = var.TFE_ORG
}

/*
resource "tfe_workspace" "tfe" {
  name = "${var.b-infra}-root"
  organization = tfe_organization.org.id
  working_directory = "root"
  trigger_prefixes = ["/modules"]
  auto_apply = true
  queue_all_runs = false
  vcs_repo {
    identifier = "atk4/infrastructure"
    oauth_token_id = tfe_oauth_client.oauth.oauth_token_id
  }
}
*/

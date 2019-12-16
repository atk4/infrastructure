
variable "tfe_org" {}
variable "github_oauth" {}
variable "name" {}
variable "path" {}

resource "tfe_workspace" "tfe" {
  name = var.name
  organization = var.tfe_org
  working_directory = var.path
  trigger_prefixes = ["/modules"]
  auto_apply = true
  queue_all_runs = false
  vcs_repo {
    identifier = "atk4/infrastructure"
    oauth_token_id = var.github_oauth
  }
}

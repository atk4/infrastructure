
variable "tfe_org" {}
variable "github_oauth" {}
variable "name" {}
variable "path" {}

variable "env" {
  type = map(string)
}

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


resource "tfe_variable" "tfe_var" {
  for_each = var.env
  workspace_id = tfe_workspace.tfe.id
  category = "env"
  key = each.key
  value = each.value
  sensitive = true
}

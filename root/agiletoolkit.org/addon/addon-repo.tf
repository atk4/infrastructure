variable "name" { }
variable "description" { }
variable "topics" {
  default = []
}
variable maintainer_team_id {}
variable contributor_team_id {}

resource "github_repository" "addon" {
  name = var.name
  description = var.description
  lifecycle {
    prevent_destroy = true
  }


  homepage_url = "https://agiletoolkit.org/"
  has_wiki = true
  has_projects = true
  has_issues = true
  has_downloads = false
  topics = concat(["agile","atk4","php"], var.topics)
}

resource "github_team_repository" "maintainer_team" {
  repository = github_repository.addon.name
  team_id = var.maintainer_team_id
  permission = "admin"
}

resource "github_team_repository" "collaborator_team" {
  repository = github_repository.addon.name
  team_id = var.contributor_team_id
  permission = "push"
}

resource "github_branch_protection" "addon-develop" {
  branch = "develop"
  repository = github_repository.addon.name
}

resource "github_branch_protection" "addon-develop" {
  branch = "master"
  repository = github_repository.addon.name
}

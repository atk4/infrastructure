variable "name" {}
variable "description" {}
variable "topics" {
  default = []
}

variable "access" {
  type = object({
    owner_team_id = string
    maintainers   = list(string)
    contributors  = list(string)
  })
}

locals {
  labels = {
    "PHP7.3+" : { c: "FF0000", d: "This can only run on PHP 7.3 and higher" }
  }
}

variable "has_projects" {
  type    = bool
  default = false
}

variable "has_wiki" {
  type    = bool
  default = false
}

variable "protect_develop" {
  type    = bool
  default = true
}

variable "protect_master" {
  type    = bool
  default = true
}

resource "github_repository" "addon" {
  name        = var.name
  description = var.description
  lifecycle {
    prevent_destroy = true
  }

  allow_merge_commit = false
  allow_rebase_merge = false


  homepage_url  = "https://agiletoolkit.org/"
  has_wiki      = var.has_projects
  has_projects  = var.has_projects
  has_issues    = true
  has_downloads = false
  topics        = concat(["agile", "atk4", "php"], var.topics)
}

resource "github_issue_label" "test_repo" {
  for_each   = local.labels
  repository = github_repository.addon.name
  name       = each.key
  color      = each.value.c
  description= each.value.d
  lifecycle {
    prevent_destroy = true
  }
}

resource "github_team_repository" "owner_team" {
  repository = github_repository.addon.name
  team_id    = var.access.owner_team_id
  permission = "admin"
}

resource "github_repository_collaborator" "maintainer" {
  for_each   = toset(var.access.maintainers)
  repository = github_repository.addon.name
  username   = each.value
  permission = "admin"
}

resource "github_repository_collaborator" "contributor" {
  for_each   = toset(var.access.contributors)
  repository = github_repository.addon.name
  username   = each.value
  permission = "push"
}



resource "github_branch_protection" "addon-develop" {
  count = var.protect_develop ? 1 : 0

  branch     = "develop"
  repository = github_repository.addon.name
  required_status_checks {}
  required_pull_request_reviews {
    required_approving_review_count = 1
  }
}

resource "github_branch_protection" "addon-master" {
  count = var.protect_master ? 1 : 0

  branch     = "master"
  repository = github_repository.addon.name
}

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
    "PHP7.3+" : { c: "ff0000", d: "Requires PHP 7.3 or higher" },
    "PHP7.4+" : { c: "ff0000", d: "Requires PHP 7.4 or higher" },
    "PHP8.0+" : { c: "ff0000", d: "Requires PHP 8.0 or higher" },
    "question" : { c: "cc317c", d: "" },
    "BC-break" : { c: "b60205", d: "" },
    "help wanted" : { c: "128a0c", d: "" },
    "has PR" : { c: "a3f7d0", d: "" },
    "sponsored :moneybag:" : { c: "f8d74a", d: "" },
    "MAJOR" : { c: "b60205", d: "" },
    "wontfix" : { c: "e0e0e0", d: "" },
    "waiting for author" : { c: "162d93", d: "" }
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
  delete_branch_on_merge = true
  vulnerability_alerts = true
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
  permission = "maintain"
  lifecycle {
    ignore_changes = [permission]
  }
}

resource "github_repository_collaborator" "contributor" {
  for_each   = toset(var.access.contributors)
  repository = github_repository.addon.name
  username   = each.value
  permission = "push"
  lifecycle {
    ignore_changes = [permission]
  }
}



resource "github_branch_protection" "addon-develop" {
  count = var.protect_develop ? 1 : 0

  pattern     = "develop"
  repository_id = github_repository.addon.node_id
  required_status_checks {}
  required_pull_request_reviews {
    required_approving_review_count = 1
  }
}

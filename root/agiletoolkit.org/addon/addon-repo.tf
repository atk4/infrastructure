variable "name" { }
variable "description" { }
variable "topics" {
  default = []
}

variable "access" {
  type = object({
    owner_team_id = string
    maintainers = list(string)
    contributors = list(string)
  })
}

resource "github_repository" "addon" {
  name = var.name
  description = var.description
  lifecycle {
    prevent_destroy = true
  }


  homepage_url = "https://agiletoolkit.org/"
  has_wiki = false
  has_projects = false
  has_issues = true
  has_downloads = false
  topics = concat(["agile","atk4","php"], var.topics)
}

resource "github_team_repository" "owner_team" {
  repository = github_repository.addon.name
  team_id = var.access.owner_team_id
  permission = "admin"
}

resource "github_repository_collaborator" "maintainer" {
  for_each = toset(var.access.maintainers)
  repository = github_repository.addon.name
  username = each.value
  permission = "admin"
}

resource "github_repository_collaborator" "contributor" {
  for_each = toset(var.access.contributors)
  repository = github_repository.addon.name
  username = each.value
  permission = "push"
}



resource "github_branch_protection" "addon-develop" {
  branch = "develop"
  repository = github_repository.addon.name
  required_pull_request_reviews {
    required_approving_review_count = 1
  }
}

resource "github_branch_protection" "addon-master" {
  branch = "master"
  repository = github_repository.addon.name
}

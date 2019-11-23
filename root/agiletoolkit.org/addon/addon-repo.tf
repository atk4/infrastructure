variable "name" { }
variable "description" { }
variable "topics" {
  default = []
}

resource "github_repository" "addon" {
  name = var.name
  description = var.description

  homepage_url = "https://agiletoolkit.org/"
  has_wiki = true
  has_projects = true
  has_issues = true
  has_downloads = false
  topics = concat(["agile","atk4","php"], var.topics)
}
resource "github_repository" "addon" {
  name = "image"
  description = "Dokker build image for ATK pipelines"
  lifecycle {
    prevent_destroy = true
  }

  allow_merge_commit = false
  allow_rebase_merge = false

  homepage_url = "https://agiletoolkit.org/"
  has_wiki = false
  has_projects = false
  has_issues = true
  has_downloads = false
  topics = ["agile","atk4","php","docker"]
}

module "atk4-login" {
  source = "./addon"
  name = "login"
  description = "Add-on implementing User Login, Registration, Management and Password (www.agiletoolkit.org)"
  topics = ["authentication", "login"]

  maintainer_team_id = github_team.atk4_maintainers.id
  contributor_team_id = github_team.atk4_contributors.id
}
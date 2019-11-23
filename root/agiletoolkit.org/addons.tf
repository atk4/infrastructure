module "atk4-login" {
  source = "./addon"
  name = "login"
  description = "Add-on implementing User Login, Registration, Management and Password (www.agiletoolkit.org)"
  topics = ["authentication", "login"]

  owner_team_id = github_team.atk4_owners.id
  maintainers = local.github_contributors
  contributors = local.github_contributors
}
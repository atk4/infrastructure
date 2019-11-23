locals {
  addon = {
    owner_team_id = github_team.atk4_owners.id
    maintainers = local.github_maintainers
    contributors = local.github_contributors
  }
}


module "atk4-login" {
  source = "./addon"
  name = "login"
  description = "Add-on implementing User Login, Registration, Management and Password (www.agiletoolkit.org)"
  topics = ["authentication", "login"]

  access = local.addon
}

module "atk4-chart" {
  source = "./addon"
  name = "chart"
  description = "Chart add-on for Agile Toolkit",
  topics = ["chart", "graph"]

  access = local.addon
}

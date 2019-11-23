locals {
  core = {
    owner_team_id = github_team.atk4_owners.id
    maintainers = local.github_maintainers
    contributors = local.github_contributors
  }
}


module "atk4-core" {
  source = "./addon"
  name = "core"
  description = "Core Object Traits for Agile Toolkit"
  topics = ["core", "traits"]

  access = local.addon
}


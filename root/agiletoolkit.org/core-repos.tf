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


module "atk4-data" {
  source = "./addon"
  name = "data"
  description = "ATK Data - Data Access Framework for high-latency databases (Cloud SQL/NoSQL)."
  topics = ["sql", "orm", "persistence", "nosql"]

  has_projects = true
  has_wiki = true

  access = local.addon
}

module "atk4-ui" {
  source = "./addon"
  name = "ui"
  description = "Build beautiful dynamic and interactive web UI in PHP"
  topics = ["ui", "ui-components", "crud", "grid"]

  has_projects = true
  has_wiki = true

  access = local.addon
}


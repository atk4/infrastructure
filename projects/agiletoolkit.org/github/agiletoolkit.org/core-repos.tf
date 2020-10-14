locals {
  core = {
    owner_team_id = github_team.atk4_owners.id
    maintainers = local.github_maintainers
    contributors = local.github_contributors
  }
}

# After adding new repo, run:
# terraform import module.agiletoolkit.module.atk4-dsql.github_repository.addon dsql

module "atk4-core" {
  source = "./addon"
  name = "core"
  description = "Core Object Traits for Agile Toolkit"
  topics = ["core", "traits"]

  access = local.addon
}

module "atk4-dsql" {
  source = "./addon"
  name = "dsql"
  description = "Object-Oriented SQL Query Builder"
  topics = ["sql", "dsql", "query"]

  has_wiki = true

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
  description = "Low-code Framework for Web Apps in PHP"
  topics = ["ui", "ui-components", "crud", "grid"]

  has_projects = true
  has_wiki = true

  access = local.addon
}


module "atk4-release-test" {
  source = "./addon"
  name = "release-test"
  description = "Release tests"
  topics = ["release", "test"]

  access = local.addon
}

module "atk4-api" {
  source = "./addon"
  name = "api"
  description = "Implementation of RestAPI for Agile Data"
  topics = ["api", "rest", "data"]

  access = local.addon
}

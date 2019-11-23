provider "github" {
  organization = "atk4"
}

locals {
  github_owners = [
    "ibelar",
    "DarkSide666",
    "KraKraDooh"
  ]

  github_maintainers = [
    "abbadon1334",
    "acicovic",
    "PhilippGrashoff",
  ]
  collaborators = [
    "gowrav-vishwakarma",
    "jancha",
    "skondakov"
  ]
}

resource "github_membership" "atk4_owners" {
  for_each = toset(local.github_owners)
  username = each.value
  role = "member"
}

####### OWNERS
resource "github_team" "atk4_owners" {
  name = "Agile Toolkit Owners"
  description = "Administrator rights for ATK repositories"
  privacy = "closed"
}

resource "github_team_membership" "atk4_owner_member" {
  for_each = toset(local.github_owners)
  team_id = github_team.atk4_owners.id
  username = each.value
  role = "member"
}

####### MAINTAINERS, managed by owners
resource "github_team" "atk4_maintainers" {
  name = "Agile Toolkit Maintainers"
  description = "Approval rights for all ATK repositories"
  privacy = "closed"
}

resource "github_team_membership" "atk4_maintainer_owner" {
  for_each = toset(local.github_owners)
  team_id = github_team.atk4_owners.id
  username = each.value
  role = "maintainer"
}

resource "github_team_membership" "atk4_maintainer_member" {
  for_each = toset(local.github_maintainers)
  team_id = github_team.atk4_maintainers.id
  username = each.value
  role = "member"
}

####### CONTRIBUTORS, managed by maintainers
resource "github_team" "atk4_contributors" {
  name = "Agile Toolkit Regular Contributor"
  description = "Creating branches and pull requests in ATK repositories"
}

resource "github_team_membership" "atk4_contributor_maintainer" {
  for_each = toset(local.github_maintainers)
  team_id = github_team.atk4_maintainers.id
  username = each.value
  role = "maintainer"
}

resource "github_team_membership" "atk4_contributor_member" {
  for_each = toset(local.github_maintainers)
  team_id = github_team.atk4_contributors.id
  username = each.value
  role = "member"
}


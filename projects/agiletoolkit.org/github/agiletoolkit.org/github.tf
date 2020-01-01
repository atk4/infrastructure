provider "github" {
  organization = "atk4"
}

locals {
  github_owners = [
    "ibelar",
    "DarkSide666",
  ]

  github_maintainers = [
    "abbadon1334",
    "acicovic",
    "PhilippGrashoff",
    "skondakov",
  ]
  github_contributors = [
    "gowrav-vishwakarma",
    "jancha",
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

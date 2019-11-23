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

resource "github_team" "atk4_maintainers" {
  name = "Agile Toolkit Maintainers"
  description = "Approval rights for all ATK repositories"
}


resource "github_team" "atk4_contributors" {
  name = "Agile Toolkit Regular Contributor"
  description = "Creating branches and pull requests in ATK repositories"
}

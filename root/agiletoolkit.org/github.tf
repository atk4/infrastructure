provider "github" {
  organization = "atk4"
}

locals {
  github_owners = [
    "romaninsh",
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
}
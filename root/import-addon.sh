#!/usr/bin/env bash

cat >> ./agiletoolkit.org/addon-repos.tf <<EOF
module "atk4-$1" {
  source = "./addon"
  name = "$1"
  description = "$2"
  topics = ["$1"]

  access = local.addon
}

EOF

terraform init
terraform import module.agiletoolkit.module.atk4-$1.github_repository.addon $1

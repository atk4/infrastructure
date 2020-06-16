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
  description = "Chart add-on for Agile Toolkit"
  topics = ["chart", "graph"]

  access = local.addon
}

# terraform import module.agiletoolkit.module.atk4-report.github_repository.addon report

module "atk4-report" {
  source = "./addon"
  name = "report"
  description = "Reporting extension for Agile Data"
  topics = ["report"]

  access = local.addon
}

module "atk4-filestore" {
  source = "./addon"
  name = "filestore"
  description = "Implements integration between ATK UI and FlySystem"
  topics = ["filestore"]

  protect_develop = false

  access = local.addon
}

module "atk4-audit" {
  source = "./addon"
  name = "audit"
  description = "Transparent audit implementation for Agile Data"
  topics = ["audit"]

  access = local.addon
}

module "atk4-invoice" {
  source = "./addon"
  name = "invoice"
  description = "UI for entering and displaying invoices"
  topics = ["invoice"]

  access = local.addon
}

module "atk4-schema" {
  source = "./addon"
  name = "schema"
  description = "Few classes built on top of Agile Data that can take care of your SQL database schema"
  topics = ["schema"]

  access = local.addon
}

module "atk4-validate" {
  source = "./addon"
  name = "validate"
  description = "Integration of ATK Data with Valitron for rule-based data validation."
  topics = ["validate"]

  access = local.addon
}

module "atk4-workflow" {
  source = "./addon"
  name = "workflow"
  description = "Implement workflow management in ATK and Saasty using Actions"
  topics = ["workflow"]

  protect_develop = false

  access = local.addon
}

module "atk4-mastercrud" {
  source = "./addon"
  name = "mastercrud"
  description = "Manipulates ATK CRUD through the force of references"
  topics = ["mastercrud"]

  access = local.addon
}

module "atk4-data-spreadsheet" {
  source = "./addon"
  name = "data-spreadsheet"
  description = "use phpoffice/phpspreadsheet as persistence in atk4/data"
  topics = ["data-spreadsheet"]

  access = local.addon
}

module "atk4-seat-selector" {
  source = "./addon"
  name = "seat-selector"
  description = "Add-on for ATK providing you with a seated ticket booking interface for Cinemas, Arenas and other Venues"
  topics = ["seat-selector"]

  access = local.addon
}

module "atk4-laravel-ad" {
  source = "./addon"
  name = "laravel-ad"
  description = "Extension for Laravel to natively integrate with Agile Data (http://git.io/ad)"
  topics = ["laravel-ad"]

  access = local.addon
}

module "atk4-warehouse" {
  source = "./addon"
  name = "warehouse"
  description = "Sample Warehouse app in Agile Toolkit"
  topics = ["warehouse"]

  protect_develop = false

  access = local.addon
}

module "atk4-agiletoolkit-bundle" {
  source = "./addon"
  name = "agiletoolkit-bundle"
  description = "Repository for building archive file for www.agiletoolkit.org DOWNLOAD button."
  topics = ["agiletoolkit-bundle"]

  protect_develop = false

  access = local.addon
}

module "atk4-money-lending-tutorial" {
  source = "./addon"
  name = "money-lending-tutorial"
  description = "Money Lending App - Agile Toolkit Tutorial"
  topics = ["money-lending-tutorial"]

  protect_develop = false

  access = local.addon
}

module "atk4-outbox" {
  source = "./addon"
  name = "outbox"
  description = "Integrate ATK UI with transactional mail gateways"
  topics = ["outbox"]

  access = local.addon
}

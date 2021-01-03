resource "codefresh_project" "saasty-framework" {
  name = "saasty-framework"
  tags = [
    "saasty"
  ]
}

resource "codefresh_pipeline" "agiletoolkit-org" {

  name = "${codefresh_project.saasty-framework.name}/agiletoolkit-org"

  tags = [ "production" ]

  spec {
    concurrency = 1
    spec_template {
      repo = "atk4/ui"
      path = "./.codefresh/ui-build-deploy.yml"
      revision = "develop"
      context = "github"
    }
  }
}
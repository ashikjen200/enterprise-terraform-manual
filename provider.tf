provider "tfe" {
  hostname = app.terraform.io
  token    = var.token_id
  version  = "~> 0.52.0"
}
provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.aws_region
}

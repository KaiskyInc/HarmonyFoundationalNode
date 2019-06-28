provider "aws" {
  version = "2.11"
  region  = "us-west-2"
}

terraform {
  required_version = "0.11.13"

  backend "s3" {
    bucket = "harmony-foundational-node"                           // Must be unique
    key    = "infrastructure/terraform/foundational-nodes.tfstate"
    region = "us-west-2"
  }
}

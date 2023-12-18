provider "aws" {
  default_tags {
    tags = {
      "managedBy" = "Terraform"
      "project"   = "PowereX-LambdaS3"
    }
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.30.0"
    }
  }
  backend "s3" {
    key = "tf/state/powerex"
  }
}

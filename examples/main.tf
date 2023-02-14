terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    tls = "~> 4.0.3"
  }
}

provider "aws" {
  alias  = "my_alias"
  region = "eu-west-2"
}

module "aws_oidc_gitlab" {
  source    = "pelotech/oidc-gitlab/aws"
  providers = {
    aws = aws.my_alias
  }
  subject_roles = {
    "repo:organization/infrastructure:ref:refs/heads/main" = ["AdministratorAccess"]
    "repo:organization/infrastructure:ref:refs/heads/*"    = ["AmazonS3ReadOnlyAccess"]
  }
  # Should only add users that already have admin access - nice to debug eks clusters as the role that created them
  assume_role_names = ["aws-reserved/sso.amazonaws.com/eu-west-2/AWSReservedSSO_SomeManagedpolicy_XXXXXXXXXXXXXXXXX"]
}
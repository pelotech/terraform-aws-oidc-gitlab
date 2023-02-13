terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    tls = "~> 4.0.3"
  }
}

module "aws_oidc_gitlab" {
  for_each             = var.subject_roles
  source               = "./modules/aws-oidc-gitlab"
  role_name            = var.role_name
  gitlab_repos         = [each.key]
  managed_policy_names = each.value
  assume_role_names    = var.assume_role_names
  match_field          = var.match_field
  aud_value            = var.aud_value
  gitlab_url           = var.gitlab_url
  gitlab_tls_url       = var.gitlab_tls_url
  max_session_duration = var.max_session_duration
}
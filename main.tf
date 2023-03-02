terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    tls = "~> 4.0.3"
  }
}

data "tls_certificate" "gitlab" {
  url = var.gitlab_tls_url
}

resource "aws_iam_openid_connect_provider" "gitlab" {
  url             = var.gitlab_url
  client_id_list  = [var.aud_value]
  thumbprint_list = [data.tls_certificate.gitlab.certificates.0.sha1_fingerprint]
}

module "aws_oidc_gitlab" {
  for_each                 = var.role_subject-repos_policies
  source                   = "./modules/aws-roles-oidc-gitlab"
  role_path                = each.value.role_path != null ? each.value.role_path : ""
  gitlab_repos             = each.value.subject_repos
  policy_arns              = each.value.policy_arns
  assume_role_names        = each.value.assume_role_names
  gitlab_oidc_provider_arn = aws_iam_openid_connect_provider.gitlab.arn
  gitlab_oidc_provider_url = aws_iam_openid_connect_provider.gitlab.url
  max_session_duration     = var.max_session_duration
}
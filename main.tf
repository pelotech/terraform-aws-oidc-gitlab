terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    tls = "~> 4.0.3"
  }
}

data "aws_partition" "current" {}
data "aws_caller_identity" "current" {}

data "tls_certificate" "gitlab" {
  url = var.gitlab_url
}

resource "aws_iam_openid_connect_provider" "gitlab" {
  url             = var.gitlab_url
  client_id_list  = ["XXXXXXXXXXX"] # TODO
  thumbprint_list = [data.tls_certificate.gitlab.certificates.0.sha1_fingerprint]
}

data "aws_iam_policy_document" "assume-role-policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.gitlab.arn]
    }
    condition {
      test     = "StringEquals"
      variable = "XXXXXXXXXXXXXXXXX:aud" #TODO
      values   = ["XXXXXXXXXXX"] # TODO
    }
    condition {
      test     = "StringLike"
      variable = "XXXXXXXXXXXXXXXXX:sub" # TODO
      values   = var.gitlab_repos
    }

  }
  dynamic "statement" {
    for_each = var.assume_role_names
    content {
      actions = ["sts:AssumeRole"]
      principals {
        identifiers = formatlist(
          "arn:%s:iam::%s:role/%s",
          data.aws_partition.current.partition,
          data.aws_caller_identity.current.account_id,
          var.assume_role_names
        )
        type = "AWS"
      }
    }
  }
}

resource "aws_iam_role" "gitlab_ci" {
  name               = format("GitLabCI-OIDC-%s", var.role_name)
  description        = "GitLabCI with OIDC"
  path               = "/ci/"
  assume_role_policy = data.aws_iam_policy_document.assume-role-policy.json
  managed_policy_arns = formatlist(
    "arn:%s:iam::aws:policy/%s",
    data.aws_partition.current.partition,
    var.managed_policy_names
  )
}
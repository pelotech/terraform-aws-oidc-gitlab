output "iam_role_arns" {
  description = "Roles that will be assumed by GitLab runner pipelines"
  value       = values(module.aws_oidc_gitlab)[*].iam_role_arn
}

output "gitlab_oidc_provider_arn" {
  description = "oidc provider arn to use for roles/policies"
  value       = aws_iam_openid_connect_provider.gitlab.arn
}

output "gitlab_oidc_provider_url" {
  description = "oidc provider url to use for roles/policies"
  value       = aws_iam_openid_connect_provider.gitlab.url
}


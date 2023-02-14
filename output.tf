output "iam_role_arns" {
  description = "Roles that will be assumed by GitLab runner pipelines"
  value       = values(module.aws_oidc_gitlab)[*].iam_role_arn
}

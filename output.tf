output "iam_role_arn" {
  description = "Role that will be assumed by GitLab runner pipelines"
  value       = module.aws_oidc_gitlab.iam_role_arn
}

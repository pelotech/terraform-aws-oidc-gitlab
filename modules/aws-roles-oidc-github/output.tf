output "iam_role_arn" {
  description = "Role that will be assumed by GitLab runner pipelines"
  value       = aws_iam_role.gitlab_ci.arn
}

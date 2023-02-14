variable "assume_role_names" {
  description = "List of roles that can assume the OIDC role. Useful for debugging cluster before aws-config is updated."
  type        = list(string)
  default     = null
}

variable "subject_roles" {
  type = map(list(string))
  description = "Subject to role mapping. Ex: repo:organization/infrastructure:ref:refs/heads/main -> [AdministratorAccess, AmazonS3FullAccess, CustomUserPolicyOne]"
}

variable "gitlab_tls_url" {
  type        = string
  default     = "tls://gitlab.com:443"
  description = "GitLab URL to perform TLS verification against."
}

variable "gitlab_url" {
  type        = string
  default     = "https://gitlab.com"
  description = "GitLab URL."
}

variable "aud_value" {
  type        = string
  default     = "https://gitlab.com"
  description = "GitLab Aud"
}

variable "match_field" {
  type        = string
  default     = "aud"
  description = "GitLab match_field."
}

variable "max_session_duration" {
  type = number
  description = "Maximum session duration in seconds. - by default assume role will be 15 minutes - when calling from actions you'll need to increase up to the maximum allowed hwere"
  default = 3600
}
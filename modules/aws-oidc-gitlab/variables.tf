variable "gitlab_tls_url" {
  type        = string
  # Avoid using https scheme because the Hashicorp TLS provider has started following redirects starting v4.
  # See https://github.com/hashicorp/terraform-provider-tls/issues/249
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
  default     = "sub"
  description = "GitLab match_field."
}

variable "gitlab_repos" {
  type        = list(string)
  description = "A list of repositories the OIDC role should have access to."
}

variable "role_name" {
  description = "The name of the OIDC role. Note: this will be prefixed with 'GitLabCI-OIDC-'"
  type        = string
}

variable "managed_policy_names" {
  type        = list(string)
  description = "Managed policy names to attach to the OIDC role."
}

variable "assume_role_names" {
  description = "List of roles that can assume the OIDC role. Useful for debuging cluster before aws-config is updated."
  type        = list(string)
  default     = null
}

variable "max_session_duration" {
  type = number
  description = "Maximum session duration in seconds. - by default assume role will be 15 minutes - when calling from actions you'll need to increase up to the maximum allowed hwere"
  default = 3600
}
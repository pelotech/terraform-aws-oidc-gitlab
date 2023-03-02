variable "role_subject-repos_policies" {
  type = map(object({
    role_path         = optional(string)
    subject_repos     = list(string)
    policy_arns       = list(string)
    assume_role_names = optional(list(string))
  }))
  description = "role name to repos and policies mapping. role name as the key and object value for repo subjects ie \"project_path:mygroup/myproject:ref_type:branch:ref:main\" as well as a list of policy arns ie [\"arn:aws:iam::aws:policy/AdministratorAccess\"] and list of roles that can assume the new role for debugging"
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

variable "max_session_duration" {
  type = number
  description = "Maximum session duration in seconds. - by default assume role will be 15 minutes - when calling from actions you'll need to increase up to the maximum allowed hwere"
  default = 3600
}
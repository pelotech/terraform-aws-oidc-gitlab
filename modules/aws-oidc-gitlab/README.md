<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | ~> 4.0.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | ~> 4.0.3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_openid_connect_provider.gitlab](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider) | resource |
| [aws_iam_role.gitlab_ci](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.assume-role-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |
| [tls_certificate.gitlab](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/data-sources/certificate) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_assume_role_names"></a> [assume\_role\_names](#input\_assume\_role\_names) | List of roles that can assume the OIDC role. Useful for debugging cluster before aws-config is updated. | `list(string)` | `[]` | no |
| <a name="input_aud_value"></a> [aud\_value](#input\_aud\_value) | GitLab Aud | `string` | `"https://gitlab.com"` | no |
| <a name="input_gitlab_repos"></a> [gitlab\_repos](#input\_gitlab\_repos) | A list of repositories the OIDC role should have access to. | `list(string)` | n/a | yes |
| <a name="input_gitlab_tls_url"></a> [gitlab\_tls\_url](#input\_gitlab\_tls\_url) | GitLab URL to perform TLS verification against. | `string` | `"tls://gitlab.com:443"` | no |
| <a name="input_gitlab_url"></a> [gitlab\_url](#input\_gitlab\_url) | GitLab URL. | `string` | `"https://gitlab.com"` | no |
| <a name="input_managed_policy_names"></a> [managed\_policy\_names](#input\_managed\_policy\_names) | Managed policy names to attach to the OIDC role. | `list(string)` | n/a | yes |
| <a name="input_max_session_duration"></a> [max\_session\_duration](#input\_max\_session\_duration) | Maximum session duration in seconds. - by default assume role will be 15 minutes - when calling from actions you'll need to increase up to the maximum allowed hwere | `number` | `3600` | no |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | The name of the OIDC role. Note: this will be prefixed with 'gitlab-role-' and any special characters will be replaced with '-'. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_iam_role_arn"></a> [iam\_role\_arn](#output\_iam\_role\_arn) | Role that will be assumed by GitLab runner pipelines |
<!-- END_TF_DOCS -->
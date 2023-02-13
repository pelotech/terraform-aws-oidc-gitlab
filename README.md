# aws-oidc-gitlab
Terraform module to configure GitLab runner pipelines with AWS Identity Provider OIDC

## Debugging features
The `assume_role_names` input allows you to assume the OIDC role and act as if you were the GitLab runner pipeline. This is very useful for debugging while you're getting things setup. Note: we recommend removing this once you're production ready so that all further changes are only applied via the pipeline.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | ~> 4.0.3 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aws_oidc_gitlab"></a> [aws\_oidc\_gitlab](#module\_aws\_oidc\_gitlab) | ./modules/aws-oidc-gitlab | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_assume_role_names"></a> [assume\_role\_names](#input\_assume\_role\_names) | List of roles that can assume the OIDC role. Useful for debuging cluster before aws-config is updated. | `list(string)` | `null` | no |
| <a name="input_aud_value"></a> [aud\_value](#input\_aud\_value) | GitLab Aud | `string` | `"https://gitlab.com"` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region. | `string` | n/a | yes |
| <a name="input_gitlab_tls_url"></a> [gitlab\_tls\_url](#input\_gitlab\_tls\_url) | GitLab URL to perform TLS verification against. | `string` | `"tls://gitlab.com:443"` | no |
| <a name="input_gitlab_url"></a> [gitlab\_url](#input\_gitlab\_url) | GitLab URL. | `string` | `"https://gitlab.com"` | no |
| <a name="input_match_field"></a> [match\_field](#input\_match\_field) | GitLab match\_field. | `string` | `"aud"` | no |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | The name of the OIDC role. Note: this will be prefixed with 'GitLabCI-OIDC-' | `string` | n/a | yes |
| <a name="input_subject_roles"></a> [subject\_roles](#input\_subject\_roles) | Subject to role mapping. Ex: repo:organization/infrastructure:ref:refs/heads/main -> [AdministratorAccess, AmazonS3FullAccess, CustomUserPolicyOne] | `map(list(string))` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ROLE_ARN"></a> [ROLE\_ARN](#output\_ROLE\_ARN) | Role that will be assumed by GitLab runner pipelines |
<!-- END_TF_DOCS -->